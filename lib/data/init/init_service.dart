import 'package:login_and_registration/app/app_config/config.dart';
import 'package:login_and_registration/data/services/api/api_service.dart';
import 'package:login_and_registration/data/services/api/api_service_impl.dart';
import 'package:login_and_registration/data/services/app_info/app_info_service.dart';
import 'package:login_and_registration/data/services/app_info/app_info_service_impl.dart';
import 'package:login_and_registration/data/services/auth_service/auth_service.dart';
import 'package:login_and_registration/data/services/auth_service/auth_service_impl.dart';
import 'package:login_and_registration/data/services/error_handler/error_handler_service.dart';
import 'package:login_and_registration/data/services/error_handler/error_handler_service_impl.dart';
import 'package:login_and_registration/data/services/launch_url/launch_impl.dart';
import 'package:login_and_registration/data/services/launch_url/launch_service.dart';
import 'package:login_and_registration/data/services/logger/log_service.dart';
import 'package:login_and_registration/data/services/logger/log_service_impl.dart';
import 'package:login_and_registration/data/services/network/connectivity_service.dart';
import 'package:login_and_registration/data/services/network/connectivity_service_impl.dart';
import 'package:login_and_registration/data/services/shared_pref/shared_pref_impl.dart';
import 'package:login_and_registration/data/services/shared_pref/shared_pref_service.dart';
import 'package:login_and_registration/data/services/task/task_dao_service.dart';
import 'package:login_and_registration/data/services/task/task_dao_service_impl.dart';

void initService({bool isProd = true}) {
  getIt.registerLazySingleton<ApiService>(() => ApiServiceImpl());
  getIt.registerLazySingleton<AuthService>(
    () => AuthServiceImpl(),
  );
  getIt.registerLazySingleton<AppInfoService>(
    () => AppInfoServiceImpl(),
  );
  getIt.registerLazySingleton<SharedPrefService>(() => SharedPrefImpl());
  getIt.registerSingleton<ErrorHandlerService>(ErrorHandlerServiceImpl());
  getIt.registerLazySingleton<LogService>(() => LogServiceImpl(isProd));
  getIt.registerLazySingleton<LaunchService>(() => LaunchServiceImpl());
  getIt.registerLazySingleton<TaskDaoService>(() => TaskDaoServiceImpl());
  getIt.registerLazySingleton<ConnectivityService>(
      () => ConnectivityServiceImpl());
}

ApiService get apiService => getIt.get();
SharedPrefService get sharedPrefService => getIt.get();
ErrorHandlerService get errorHandlerService => getIt.get();
LogService get logger => getIt.get();
AuthService get authService => getIt.get();
AppInfoService get appInfoService => getIt.get();
LaunchService get launchService => getIt.get();
TaskDaoService get taskDaoService => getIt.get();
ConnectivityService get connectivityService => getIt.get();
