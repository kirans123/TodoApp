import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_and_registration/app/init/init_dependencies.dart';
import 'package:login_and_registration/app/my_app.dart';
import 'package:login_and_registration/app/router/routes.dart';
import 'package:login_and_registration/app/widgets/custom_error_widget.dart';
import 'package:login_and_registration/utils/constants/assets.dart';

initApp() {
  runZonedGuarded(() async {
    await initDependencies();

    ErrorWidget.builder = (errorDetails) {
      return CustomErrorWidget(
        errorDetails: errorDetails,
        logoAsset: Assets.profileIcon,
        showErrorDetails: false,
        onRestart: (context) {
          const SplashRoute().pushReplacement(context);
        },
      );
    };

    runApp(
      const MyApp(),
    );
  }, (error, stack) {
    // Add better debug log here
    debugPrint('Error: $error');
    // print("Error: $error");
  });
}
