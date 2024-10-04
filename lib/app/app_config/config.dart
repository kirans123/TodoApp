import 'package:get_it/get_it.dart';
import 'package:login_and_registration/app/app_config/app_config.dart';
import 'package:login_and_registration/app/app_config/app_config_impl.dart';

final getIt = GetIt.instance;

void initConfig() {
  getIt.registerLazySingleton<AppConfig>(() => AppConfigImpl());
}

AppConfig get appConfig => getIt.get();
