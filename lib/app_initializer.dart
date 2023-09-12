import 'package:flutter/services.dart';
import 'package:two_min/utils/utils.dart';
import 'package:two_min/config/app_flavor_config.dart';

Future setupAppInit() async {
  await _setupFlavorConfig();
  await _setupFirebase();
}

Future<void> _setupFlavorConfig() async {
  try {
    const platform = MethodChannel('com.adaboys.two_min/flavor');
    final flavor = await platform.invokeMethod('getFlavor');
    final flavorValue = Utils.enumFromString(flavor, FlavorValue.values);
    print('flavor=${flavor}, flavorValue=${flavorValue}');
    AppFlavorConfig.createInstance(flavorValue!);
  } on PlatformException catch (error) {
    print('_setupFlavorConfig=>error=>${error}');
  }
}

Future<void> _setupFirebase() async {

}