import 'package:dio/dio.dart';

class ApiConfig {
  final String baseUrl;
  final List<Interceptor> interceptors;
  // connectTimeout: in milliseconds. default = 30000.
  final Duration connectTimeout;
  // receiveTimeout: in milliseconds. default = 30000.
  final Duration receiveTimeout;
  // retries: number of retries default = 3.
  final int retries;

  // retriesDelayList: list of Duration. default = [1, 2, 3].
  final List<Duration> retriesDelayList;
  final bool printResponseData;
  final bool printResponseHeaders;
  final bool printResponseMessage;
  final bool printRequestData;
  final bool printRequestHeaders;

  ApiConfig({
    required this.baseUrl,
    this.interceptors = const [],
    this.connectTimeout = const Duration(minutes: 10),
    this.receiveTimeout = const Duration(minutes: 10),
    this.retries = 3,
    this.retriesDelayList = const [
      Duration(seconds: 1),
      Duration(seconds: 2),
      Duration(seconds: 3),
    ],
    this.printResponseData = false,
    this.printResponseHeaders = false,
    this.printResponseMessage = false,
    this.printRequestData = false,
    this.printRequestHeaders = false,
  });
}
