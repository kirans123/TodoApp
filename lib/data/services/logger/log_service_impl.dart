import 'package:flutter/material.dart';
import 'package:login_and_registration/features/developer/logger/observer/log_bloc_observer.dart';
import 'package:login_and_registration/utils/check_platform/check_platform.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../features/developer/logger/utils/query_filter.dart';
import 'log_service.dart';

class LogServiceImpl implements LogService {
  late Talker _talker;

  @override
  Talker get talker => _talker;

  LogServiceImpl(
    bool isProd, {
    String? query,
    bool enableLogs = true,
  }) {
    _talker = Talker(
      logger: TalkerLogger(
        filter: isProd
            ? const LogLevelFilter(LogLevel.error)
            : query != null
                ? QueryFilter(query)
                : const LogLevelFilter(LogLevel.debug),
        settings: TalkerLoggerSettings(
          enableColors: CheckPlatform.isNotIOS,
        ),
        output: debugPrint,
      ),
      settings: TalkerSettings(enabled: enableLogs),
    );
  }

  @override
  void d(String message) {
    _talker.debug(message);
  }

  @override
  void i(String message) {
    _talker.info(message);
  }

  @override
  void w(String message, [Object? error, StackTrace? stackTrace]) {
    _talker.warning(message, error, stackTrace);
  }

  @override
  void e(String message, [Object? error, StackTrace? stackTrace]) {
    _talker.error(message, error, stackTrace);
  }

  @override
  NavigatorObserver setRouteObserver() {
    return TalkerRouteObserver(_talker);
  }

  @override
  TalkerBlocObserver setBlocObserver() {
    return TalkerBlocObserver(talker: _talker);
  }
}
