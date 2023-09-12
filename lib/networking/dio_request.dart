import 'package:dio/dio.dart';

import '../config/app_flavor_config.dart';

Dio get getDioInstance {
  final dio = Dio();
  dio.options
    ..baseUrl = AppFlavorConfig.getInstance?.baseUrl ?? ''
    ..connectTimeout = 30000;

  dio.interceptors.addAll([
// AuthInterceptor(), // Add access token to header. Need custom for each project
// TokenInterceptor(), // Handle access token expired. Need custom for each project
    LogInterceptor(responseBody: true),
  ]);
  return dio;
}
