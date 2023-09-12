import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
//   Custom flavor
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let flavorChannel = FlutterMethodChannel(name: "com.adaboys.two_min/flavor",
                                                  binaryMessenger: controller.binaryMessenger)
    flavorChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          let flavor = Bundle.main.infoDictionary?["Flavor"]
          result(flavor)
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
