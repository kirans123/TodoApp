import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:login_and_registration/data/init/init_service.dart';
import 'package:login_and_registration/data/services/api/api_service.dart';
import 'package:login_and_registration/data/services/api/interceptor/session_interceptors.dart';
import 'package:login_and_registration/data/services/api/models/api_config.dart';
import 'package:login_and_registration/data/services/api/models/app_response.dart';
import 'package:login_and_registration/utils/check_platform/check_platform.dart';
import 'package:login_and_registration/utils/constants/constants.dart';
import 'package:login_and_registration/utils/constants/keys.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

class ApiServiceImpl implements ApiService {
  late Dio _dio;
  late ApiConfig config;
  String? _token;

  @override
  Dio get dio => _dio;

  @override
  String get token => _token ?? '';

  @override
  String get requestTime => DateTime.now().millisecondsSinceEpoch.toString();

  final contentType = (CheckPlatform.isWeb) ? 'audio/webm' : "audio/wav";

  final formatType = (CheckPlatform.isWeb) ? 'webm' : "wav";

  @override
  void init({
    required ApiConfig config,
  }) {
    config = config;
    _dio = Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        receiveTimeout: config.receiveTimeout,
        connectTimeout: config.connectTimeout,
      ),
    );
    _dio.interceptors.addAll(
      [
        TalkerDioLogger(
          talker: logger.talker,
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: false,
            printResponseHeaders: false,
            printResponseMessage: true,
          ),
        ),
      ],
    );
  }

  @override
  void setToken(String token) {
    _token = token;
  }

  @override
  Future<AppResponse> get({
    required String url,
    Map<String, dynamic> queryParams = const {},
  }) async {
    return _apiCall(
      () => dio.get(
        url,
        queryParameters: queryParams,
        options: Options(
          headers: {
            AppKeys.contentType: 'application/json',
            AppKeys.authorization: 'Bearer $token',
          },
          followRedirects: true,
        ),
      ),
    );
  }

  @override
  Future<AppResponse> patch({
    required String url,
    Map<String, dynamic> queryParams = const {},
    data,
  }) async {
    return _apiCall(
      () => dio.patch(
        url,
        queryParameters: queryParams,
        options: Options(
          headers: {
            AppKeys.contentType: 'application/json',
            AppKeys.authorization: 'Bearer $token',
          },
          followRedirects: true,
        ),
        data: data,
      ),
    );
  }

  @override
  Future<AppResponse> post({
    required String url,
    Map<String, dynamic> queryParams = const {},
    data,
  }) async {
    return _apiCall(
      () => dio.post(
        url,
        queryParameters: queryParams,
        options: Options(
          headers: {
            AppKeys.contentType: 'application/json',
            AppKeys.authorization: 'Bearer $token',
          },
          followRedirects: true,
        ),
        data: data,
      ),
    );
  }

  @override
  Future<AppResponse> put({
    required String url,
    Map<String, dynamic> queryParams = const {},
    data,
  }) async {
    return _apiCall(
      () => dio.put(
        url,
        queryParameters: queryParams,
        options: Options(
          headers: {
            AppKeys.contentType: 'application/json',
            AppKeys.authorization: 'Bearer $token',
          },
          followRedirects: true,
        ),
        data: data,
      ),
    );
  }

  @override
  Future<AppResponse> delete({
    required String url,
    Map<String, dynamic> queryParams = const {},
  }) async {
    return _apiCall(
      () => dio.delete(
        url,
        queryParameters: queryParams,
        options: Options(
          headers: {
            AppKeys.contentType: 'application/json',
            AppKeys.authorization: 'Bearer $token',
          },
          followRedirects: true,
        ),
      ),
    );
  }

  @override
  Future<AppResponse> multipartUpload({
    required String url,
    required String filePath,
    required List<String> tags,
    Map<String, dynamic> queryParams = const {},
  }) async {
    try {
      final headers = {
        'Accept': '*/*',
        'Authorization': 'Bearer $token',
        'Content-Type': contentType,
      };

      FormData formData = await _getFormData(
        filePath,
        tags,
      );

      var response = await dio.post(
        url,
        data: formData,
        queryParameters: queryParams,
        options: Options(
          headers: headers,
          contentType: contentType,
          followRedirects: true,
          maxRedirects: 2,
          preserveHeaderCase: true,
          validateStatus: (status) {
            // Accept all status codes for now, adjust as necessary
            return status != null && status >= 200 && status < 400;
          },
        ),
      );
      if (response.statusCode == 307) {
        // Handle the redirection manually
        var redirectedUrl = response.headers['location']?.first;
        if (redirectedUrl != null) {
          // Create a new instance of FormData for the redirected request
          var newFormData = await _getFormData(
            filePath,
            tags,
          );

          // Re-send the request to the new location
          var redirectedResponse = await dio.post(
            redirectedUrl,
            data: newFormData,
            options: Options(
              headers: headers,
            ),
          );
          if (redirectedResponse.statusCode != null &&
              redirectedResponse.statusCode! >= 200 &&
              redirectedResponse.statusCode! < 300) {
            //check if redirectedResponse has error key then return error else return success
            //from backend receiving same same status code for both success and error
            //so checking error key in response to differentiate between success and error
            if (redirectedResponse.data[AppKeys.error] != null) {
              return AppResponse.error(
                message: redirectedResponse.data[AppKeys.message],
              );
            } else {
              return AppResponse.fromDioResponse(redirectedResponse);
            }
          } else {
            return AppResponse.error(message: 'Failed to upload a note');
          }
        }
      } else if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return AppResponse.fromDioResponse(response);
      } else {
        return AppResponse.error(message: 'Failed to upload a note');
      }
    } catch (e, s) {
      return AppResponse.error(
        message: 'Failed to upload a note',
        error: e,
        stackTrace: s,
      );
    }
    return AppResponse();
  }

  Future<FormData> _getFormData(
    String filePath,
    List<String> tags,
  ) async {
    if (CheckPlatform.isWeb) {
      final path = filePath.replaceFirst(r'blob:', '');

      logger.i("File path: $path");
      Response fileResponse = await dio.get(
        path,
        options: Options(
          responseType: ResponseType.bytes,
          contentType: contentType,
        ),
      );
      Uint8List fileBytes = fileResponse.data;
      return FormData.fromMap({
        AppKeys.file: MultipartFile.fromBytes(
          fileBytes,
          filename: 'audio_${DateTime.now()}.$formatType',
          headers: {
            'Content-Type': [contentType],
          },
        ),
        AppKeys.tags: tags,
      });
    } else {
      return FormData.fromMap({
        AppKeys.file: await MultipartFile.fromFile(filePath),
        AppKeys.tags: tags,
      });
    }
  }

  Future<AppResponse> _apiCall(
    Future<Response<dynamic>> Function() apiCall,
  ) async {
    try {
      final response = await apiCall();
      return AppResponse.fromDioResponse(response);
    } on DioException catch (e, s) {
      if (e.type == DioExceptionType.connectionError) {
        return AppResponse.error(message: noInternet);
      } else if (e.type == DioExceptionType.badResponse &&
          e.response?.statusCode == 401) {
        return AppResponse.error(message: 'User is not authorized');
      } else {
        var errorResponse = e.response;
        if (errorResponse != null) {
          return AppResponse.fromDioResponse(errorResponse);
        }
        return AppResponse.error(
          error: e,
          stackTrace: s,
        );
      }
    } catch (e, s) {
      return AppResponse.error(
        error: e,
        stackTrace: s,
      );
    }
  }

  @override
  addSessionExpiry(Function() logout) {
    _dio.interceptors.add(
      SessionExpiredInterceptor(
        onSessionExpired401: (error, handler) {
          logger.e('TAG INTERCEPTOR --> ${error.message}');
          logout();
        },
      ),
    );
  }
}
