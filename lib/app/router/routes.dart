import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_and_registration/app/router/route_path.dart';
import 'package:login_and_registration/features/error/error_screen.dart';
import 'package:login_and_registration/features/home/home_screen.dart';
import 'package:login_and_registration/features/login/login_screen.dart';
import 'package:login_and_registration/features/signup/signup_screen.dart';
import 'package:login_and_registration/features/splash/splash_screen.dart';

part 'routes.g.dart';

class ErrorRoute extends GoRouteData {
  ErrorRoute({required this.error});
  final Exception error;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ErrorScreen();
  }
}

@TypedGoRoute<SplashRoute>(path: RoutePath.splash)
class SplashRoute extends GoRouteData {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashScreen();
  }
}

@TypedGoRoute<LoginRoute>(path: RoutePath.login)
class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginScreen();
  }
}

@TypedGoRoute<SignUpRoute>(path: RoutePath.signUp)
class SignUpRoute extends GoRouteData {
  const SignUpRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignUpScreen();
  }
}

@TypedGoRoute<HomeRoute>(path: RoutePath.home)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}
