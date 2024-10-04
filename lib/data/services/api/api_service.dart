import 'package:dio/dio.dart';
import 'package:login_and_registration/data/services/api/models/api_config.dart';
import 'package:login_and_registration/data/services/api/models/app_response.dart';

abstract class ApiService {
  String get token;

  String get requestTime;

  Dio get dio;

  void init({
    required ApiConfig config,
  });

  void setToken(String token);

  Future<AppResponse> get({
    required String url,
    Map<String, dynamic> queryParams,
  });

  Future<AppResponse> post({
    required String url,
    Map<String, dynamic> queryParams,
    data,
  });

  Future<AppResponse> put({
    required String url,
    Map<String, dynamic> queryParams,
    data,
  });

  Future<AppResponse> patch({
    required String url,
    Map<String, dynamic> queryParams,
    data,
  });

  Future<AppResponse> delete({
    required String url,
    Map<String, dynamic> queryParams,
  });
  addSessionExpiry(Function() logout);
}
