import 'package:flutter/material.dart';
import 'package:login_and_registration/features/developer/logger/observer/log_bloc_observer.dart';
import 'package:talker_flutter/talker_flutter.dart';

abstract class LogService {
  Talker get talker;

  void d(String message);

  void i(String message);

  void w(
    String message, [
    Object? error,
    StackTrace? stackTrace,
  ]);

  void e(
    String message, [
    Object? error,
    StackTrace? stackTrace,
  ]);

  NavigatorObserver setRouteObserver();

  TalkerBlocObserver setBlocObserver();
}
