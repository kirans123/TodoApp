import 'package:dio/dio.dart';
import 'package:login_and_registration/data/init/init_service.dart';
import 'package:login_and_registration/utils/constants/keys.dart';
import 'package:login_and_registration/utils/constants/map.dart';

class SessionExpiredInterceptor extends Interceptor {
  int _getStatusCode(Response response) {
    if (response.data != null) {
      Map<String, dynamic> rawData = <String, dynamic>{};
      if (response.data is Map) {
        rawData = response.data as Map<String, dynamic>;

        return rawData.getInt(AppKeys.statusCode);
      }
    }

    return 0; //default int
  }

  final void Function(DioException err, ErrorInterceptorHandler handler)?
      onSessionExpired401;

  SessionExpiredInterceptor({
    this.onSessionExpired401,
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    try {
      //Checks for response status code and response data status code
      //401
      if (onSessionExpired401 != null && err.response?.statusCode == 401) {
        onSessionExpired401!(err, handler);
      } else if (onSessionExpired401 != null && err.response != null) {
        final response = err.response!;
        var statusCode = _getStatusCode(response);
        if (statusCode == 401) {
          onSessionExpired401!(err, handler);
        }
      }
    } catch (e, s) {
      logger.e('SessionExpiredInterceptor.onError', e, s);
    }

    super.onError(err, handler);
  }
}
