import 'package:login_and_registration/utils/constants/map.dart';

class ServerConfig {
  String baseUrl;

  ServerConfig({required this.baseUrl});

  Map<String, dynamic> toJson() {
    return {
      'baseUrl': baseUrl,
    };
  }

  @override
  String toString() {
    return 'ServerConfig : ${toJson().toPretty()}';
  }
}
