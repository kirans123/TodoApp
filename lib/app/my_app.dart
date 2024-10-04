import 'package:flutter/material.dart';
import 'package:login_and_registration/app/app_config/environment/environment.dart';
import 'package:login_and_registration/app/bloc_providers/bloc_provider_wrapper.dart';
import 'package:login_and_registration/app/router/router_config.dart';
import 'package:login_and_registration/app/widgets/banner_widget.dart';
import 'package:login_and_registration/data/init/init_service.dart';
import 'package:login_and_registration/utils/constants/constants.dart';
import 'package:login_and_registration/utils/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BannerWidget(
      show: !AppEnvironment.isProduction,
      title: appInfoService.appInfo.currentAppVersion,
      child: BlocProviderWrapper(
        child: Builder(
          builder: (context) {
            return MaterialApp.router(
              title: kAppName,
              theme: AppTheme.lightTheme,
              themeMode: ThemeMode.light,
              darkTheme: AppTheme.darkTheme,
              routerConfig: routerConfig,
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
    );
  }
}
