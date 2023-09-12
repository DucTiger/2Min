import 'package:two_min/di/service_locator.dart';
import 'package:two_min/utils/shared_pref_manager.dart';

class SessionUtils {
  static void saveSession({
    required String accessToken,
    required String refreshToken,
    String? userEmail,
    String? userName,
    String? userId,
  }) {
    final preferencesManager = getIt.get<SharedPreferencesManager>();
    preferencesManager.putString(
        SharedPreferenceKey.keyAccessToken, accessToken);
    preferencesManager.putString(
        SharedPreferenceKey.keyRefreshToken, refreshToken);
    if (userEmail != null) {
      preferencesManager.putString(SharedPreferenceKey.keyUserEmail, userEmail);
    }

    if (userName != null) {
      preferencesManager.putString(SharedPreferenceKey.keyUserName, userName);
    }

    if (userId != null) {
      preferencesManager.putString(SharedPreferenceKey.keyUserId, userId);
    }
  }

  static String? getUserName() => getIt
      .get<SharedPreferencesManager>()
      .getString(SharedPreferenceKey.keyUserName);

  static String? getUserEmail() => getIt
      .get<SharedPreferencesManager>()
      .getString(SharedPreferenceKey.keyUserEmail);

  static String? getUserId() => getIt
      .get<SharedPreferencesManager>()
      .getString(SharedPreferenceKey.keyUserId);

  static String? getAccessToken() => getIt
      .get<SharedPreferencesManager>()
      .getString(SharedPreferenceKey.keyAccessToken);

  static String? getRefreshToken() => getIt
      .get<SharedPreferencesManager>()
      .getString(SharedPreferenceKey.keyRefreshToken);

  static Future<void> clearUserData() async {
    await getIt.get<SharedPreferencesManager>().clear();
  }
}
