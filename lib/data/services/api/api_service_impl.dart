import 'package:dio/dio.dart';
import 'package:login_and_registration/data/init/init_service.dart';
import 'package:login_and_registration/data/services/api/api_service.dart';
import 'package:login_and_registration/data/services/api/interceptor/session_interceptors.dart';
import 'package:login_and_registration/data/services/api/models/api_config.dart';
import 'package:login_and_registration/data/services/api/models/app_response.dart';
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

  Future<AppResponse> _apiCall(
    Future<Response<dynamic>> Function() apiCall,
  ) async {
    try {
      final response = await apiCall();
      logger.e('TAG API RESPONSE --> $response');
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
