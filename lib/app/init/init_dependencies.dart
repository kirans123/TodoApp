import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_and_registration/app/app_config/config.dart';
import 'package:login_and_registration/data/init/init_service.dart';
import 'package:login_and_registration/data/services/api/models/api_config.dart';
import 'package:login_and_registration/firebase_options.dart';

Future<void> initDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initConfig();
  initService();

  apiService.init(config: ApiConfig(baseUrl: appConfig.serverConfig.baseUrl));
  Bloc.observer = logger.setBlocObserver();

  await sharedPrefService.init();
  await appInfoService.initPackageInfo();
  errorHandlerService.recordError;
}
