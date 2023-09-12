import 'api_constant.dart';

enum FlavorValue { development, staging, production }

class AppFlavorConfig {
  final String? baseUrl;

  AppFlavorConfig({this.baseUrl});

  static AppFlavorConfig? _instance;

  static AppFlavorConfig? get getInstance => _instance;

  static AppFlavorConfig? createInstance(FlavorValue flavorValue) {
    if (_instance == null) {
      switch (flavorValue) {
        case FlavorValue.development:
          _instance = AppFlavorConfig(baseUrl: ApiConstant.baseUrlDev);
          break;
        case FlavorValue.staging:
          _instance = AppFlavorConfig(baseUrl: ApiConstant.baseUrlStaging);
          break;
        case FlavorValue.production:
          _instance = AppFlavorConfig(baseUrl: ApiConstant.baseUrlProd);
          break;
      }
    }
    return _instance;
  }
}
