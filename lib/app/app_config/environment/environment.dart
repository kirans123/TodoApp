import 'package:login_and_registration/utils/constants/keys.dart';

class AppEnvironment {
  static String baseUrl = const String.fromEnvironment(
    AppKeys.baseUrl,
  );
  static String env = const String.fromEnvironment(
    AppKeys.env,
    defaultValue: 'prod',
  );

  static bool isProduction = env == 'prod';

  static bool isDev = env == 'dev';
}
