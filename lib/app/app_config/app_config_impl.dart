import 'package:login_and_registration/app/app_config/app_config.dart';
import 'package:login_and_registration/app/app_config/environment/environment.dart';
import 'package:login_and_registration/app/app_config/models/server_config.dart';

class AppConfigImpl extends AppConfig {
  final ServerConfig _serverConfig = ServerConfig(
    baseUrl: AppEnvironment.baseUrl,
  );
  @override
  ServerConfig get serverConfig => _serverConfig;
}
