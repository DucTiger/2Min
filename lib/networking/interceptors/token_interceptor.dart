import 'dart:async';

import 'package:two_min/config/app_flavor_config.dart';
import 'package:two_min/utils/sessions_utils.dart';
import 'package:dio/dio.dart';

import 'package:two_min/di/service_locator.dart';

import 'package:two_min/utils/shared_pref_manager.dart';

class TokenInterceptor extends InterceptorsWrapper {
  @override
  void onError(DioError error, ErrorInterceptorHandler handler) async {
    Dio _dio = getIt.get<Dio>();

    final accessToken = SessionUtils.getAccessToken();
    final refreshToken = SessionUtils.getRefreshToken();

    // User is not logged in, so no need to refresh token
    if (accessToken == null && refreshToken == null) {
      handler.next(error);
      return;
    }

    // StatusCode is not equal 401 (code unauthorized) no need to refresh token
    final statusCode = error.response?.statusCode;
    if (statusCode != 401) {
      handler.next(error);
      return;
    }

    try {
      RequestOptions request = error.response!.requestOptions;

      /// Dio is locked, some api is doing refresh token at this point.
      /// So just try to request the api again with retry count 1.
      /// On token refresh, this key will be removed from headers anyway.
      if (_dio.interceptors.requestLock.locked) {
        unawaited(_dio.fetch(request));
        return;
      }

      _dio.lock();

      final currentRefreshToken = getIt
          .get<SharedPreferencesManager>()
          .getString(SharedPreferenceKey.keyRefreshToken);

      // create a new instance of Dio so it does not trigger this interceptor and others
      Dio refreshTokenDio =
          Dio(BaseOptions(baseUrl: AppFlavorConfig.getInstance?.baseUrl ?? ""));
      // Need call api refresh token in here

      _dio.unlock();

      final data = await _dio.fetch(request);
      handler.resolve(data);
    } on DioError catch (error, stackTrace) {
      // This cannot be done in finally block, with this in finally block,
      // the pending api with old refresh token will proceed and will cause
      // user logged out.
      _dio.unlock();

      // refresh token fail, log user out
      if (error.type != DioErrorType.other) {
        //  Need logout user
      }

      handler.reject(error);
    } catch (_) {
      handler.reject(error);
    }
  }
}
