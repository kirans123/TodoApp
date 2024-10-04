// coverage:ignore-file
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:login_and_registration/data/init/init_service.dart';
import 'package:login_and_registration/data/services/error_handler/error_handler_service.dart';

class ErrorHandlerServiceImpl implements ErrorHandlerService {
  @override
  Future<void> recordError(
    error,
    StackTrace stackTrace, {
    context,
  }) async {
    var errorTitle = '';

    if (error is PlatformException) {
      errorTitle = error.code;
    }
    logger.e(
      'ErrorHandlerService[${error.runtimeType}][$context] $errorTitle ',
      error,
      stackTrace,
    );

    //TODO (Kiran) : Add error logging to analytics
    if (!kIsWeb) {}
  }
}
