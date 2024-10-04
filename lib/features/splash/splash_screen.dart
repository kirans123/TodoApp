// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_and_registration/app/router/routes.dart';
import 'package:login_and_registration/data/init/init_service.dart';
import 'package:login_and_registration/utils/constants/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  void navigate() async {
    Timer(const Duration(seconds: 2), () async {
      if (await authService.checkAndInitUser()) {
        const HomeRoute().pushReplacement(context);
      } else {
        const LoginRoute().pushReplacement(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue, Colors.white],
        ),
      ),
      child: Center(
        child: Hero(
          tag: 'logo',
          child: Image.asset(Assets.logo, width: 200, height: 200),
        ),
      ),
    );
  }
}
