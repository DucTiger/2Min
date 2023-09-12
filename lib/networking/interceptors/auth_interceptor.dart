import 'package:dio/dio.dart';

import 'package:two_min/utils/sessions_utils.dart';

class AuthInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Some api no need add access token to header so need add 'no-auth' to headers to skip access token
    if (options.headers['no-auth'] != null) {
      options.headers.remove('no-auth');
      handler.next(options);
      return;
    }

    final accessToken = SessionUtils.getAccessToken();
    if (accessToken != null) {
      // This one need custom for each project because some project use Authorization and Bearer but some project use access-token and no need Bearer
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }
}
