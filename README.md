# two_min

Base project can apply for all project

## SETUP LOCALIZATION (https://docs.flutter.dev/development/accessibility-and-localization/internationalization)
1. Add flutter_localizations, intl under dependencies in pubspec.yaml like this
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations: # Add this line
    sdk: flutter         # Add this line
  intl: ^0.17.0 # Add this line

2. Enable the generate flag
flutter:
  generate: true # Add this line
3. pub get
4. Add a new yaml file to the root directory of the Flutter project called l10n.yaml with the following content:
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
5. In lib folder create l10n folder
6. In l10n folder create app_en.arb file. Path is lib/l10n/app_en.arb
7. open app_en.arb and put content like this
{
    "helloWorld": "Hello World!",
}
8. In l10n folder create app_en.arb file. Path is lib/l10n/app_vi.arb
9. open app_vi.arb and put content like this
{
    "helloWorld": "Xin chao!",
}
10. Run app to generate l10n
11. Add localization to MaterialApp like this
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
return const MaterialApp(
  title: 'Localizations Sample App',
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: MyHomePage(),
);
12. Use like this: Text(AppLocalizations.of(context)!.helloWorld);


## SETUP BUILD RELEASE
## FOR ANDROID (https://docs.flutter.dev/deployment/android)
NOTE: Need put key.properties and keytore in android/app to avoid error ` Keystore file '/Volumes/DATA/Working/MyWork/AndroidStudioProject/two_min/android/app/default_keystore.keystore' not found for signing config 'release'.`
1. Create keystore by run command line and copy keystore file into /android/app/default_keystore.keystore
    keytool -genkey -v -keystore /Users/mac/Desktop/default_keystore.keystore -alias alias_name_your_app -storepass abc@12345678 -keypass abc@12345678
2. Create /android/app/key.properties and setup like this
    storePassword=abc@12345678
    keyPassword=abc@12345678
    keyAlias=alias_name_your_app
    storeFile=default_keystore.keystore
3. In android/app/build.gradle add keystore information like this
   def keystoreProperties = new Properties()
   def keystorePropertiesFile = rootProject.file('app/key.properties')
   if (keystorePropertiesFile.exists()) {
       keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
   }
4. In android/app/build.gradle setup build type and signingConfigs like this
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }

    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }


## SETUP FLAVOR (https://medium.com/flutter-community/flutter-ready-to-go-e59873f9d7de#2e2d)
https://www.chwe.at/2020/10/flutter-flavors/
## FOR ANDROID
1. In app/src create folder development (for dev env) and staging (for staging env)
2. If you want show app icon difference for each environment, create development/res, staging/res for each env
3. If use google service need copy google json file for each environment
4. In android/app/bundle.grade setup flavor like this

    flavorDimensions "default"
    productFlavors {
        development {
            applicationIdSuffix ".dev"
            versionNameSuffix = "-dev"
            resValue "string", "app_name", "Dev Env" => App name for dev env
        }
        staging {
            applicationIdSuffix ".staging"
            versionNameSuffix = "-staging"
            resValue "string", "app_name", "Staging Env" => App name for staging env
        }
        production {
            resValue "string", "app_name", "Production Env" => App name for production env
        }
    }
5. Put app name in application tag in manifest
    android:label="@string/app_name"
6. Use method channel to get flavor for each platform
    For Android:
            private val CHANNEL = "com.adaboys.two_min/flavor";

            override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
                super.configureFlutterEngine(flutterEngine)
                MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
                    if (call.method == "getFlavor") {
                        result.success(BuildConfig.FLAVOR)
                    } else {
                        result.notImplemented()
                    }
                }
            }
    For IOS: SEE IOS CONFIG

## FOR IOS (custom schemes)
1. Open ios folder by xcode (Double click Runner.xcworkspace file)
2. Create custom build configurations for the flavors
    2.1. In the main window, select the “Runner” node below “PROJECT” (NOT below TARGETS)
    2.2. Select the “Info” tab
    2.3. In the “Configurations” section, do the following:
        Rename “Debug” to “Debug-development”
        Rename “Release” to “Release-development”
        Rename “Profile” to “Profile-development”

        Duplicate “Debug-staging” and rename it to “Debug-staging”
        Duplicate “Release-staging” and rename it to “Release-staging”
        Duplicate “Profile-staging” and rename it to “Profile-staging”

        Duplicate “Debug-development” and rename it to “Debug-production”
        Duplicate “Release-development” and rename it to “Release-production”
        Duplicate “Profile-development” and rename it to “Profile-production”
3. Assign build configurations to custom schemes
    3.1. Make sure the root “Runner” node is selected in XCode.
    3.2. Select “Product -> Scheme -> Manage Schemes…” in the main toolbar.
        3.2.1. To get the “development” scheme:
        3.2.2. Select the “Runner” scheme, click on the settings-icon in the top left and select “Duplicate”
        3.2.3. Rename the scheme to “development”
        3.2.4. Make sure “Shared” is selected
        3.2.5. Close the dialog

        3.2.6. To get the “staging” scheme:
        3.2.7. Select the “Runner” scheme again, click on the settings-icon in the top left and select “Duplicate”
        3.2.8. Rename the scheme to “staging”
        3.2.9. For each of the sections (“Run”, “Test”, “Profile”, “Analyze”, “Archive”) on the left, change the build configuration to the corresponding “-staging” version.
        3.2.10. Make sure “Shared” is selected
        3.2.11. Close the dialog

        3.2.12. To get the “production” scheme:
        3.2.13. Select the “Runner” scheme again, click on the settings-icon in the top left and select “Duplicate”
        3.2.14. Rename the scheme to “staging”
        3.2.15. For each of the sections (“Run”, “Test”, “Profile”, “Analyze”, “Archive”) on the left, change the build configuration to the corresponding “-production” version.
        3.2.16. Make sure “Shared” is selected
        3.2.17. Close the dialog
4. Adding the method channel for iOS
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let flavorChannel = FlutterMethodChannel(name: "com.adaboys.two_min/flavor",
                                                      binaryMessenger: controller.binaryMessenger)
        flavorChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
              let flavor = Bundle.main.infoDictionary?["Flavor"]
              result(flavor)
        })

This will set up a method channel handler that reads the current flavor from a Bundle.main.infoDictionary with a key called "Flavor".
5. Set up the flavor value per scheme
    5.1. Open the Runner/Info.plist file in XCode and and add a new row with the following settings:
        Key: Flavor
        Type: String
        Value $(FLAVOR)
    5.2. Select the root “Runner” node in your XCode project structure
    5.3. Select “Runner” below TARGETS
    5.4. Select the “Build settings” tab
    5.5. Click on the + to add a new User-defined setting
    5.6. Name it FLAVOR
    5.7. Expand the node by clicking on the little arrow on the left of the row and add the actual flavor value to each build configuration:
         Debug-development: development
         Debug-staging: staging
         Debug-production: production
         Profile-development: development
         Profile-staging: staging
         Profile-production: production
         Release-development: development
         Release-staging: staging
         Release-production: production
6. Set the flavor-specific bundle identifier
- The Info.plist file already contains a key named Bundle identifier that already contains a dynamic value $(PRODUCT_BUNDLE_IDENTIFIER), so we don’t have to create another entry in this file.
- Instead, we just have to modify this key in the the build settings:
    6.1. In XCode, select the root “Runner” node in the project explorer
    6.2. Select “Runner” below TARGETS
    6.3. Go to the “Build Settings” tab
    6.4. In the “Packaging” section, find the “Product Bundle Identifier” key
    6.5. Expand the key by clicking on the small arrow on the left
        Debug-development: com.adaboys.two_min.dev
        Debug-staging: com.adaboys.two_min.staging
        Debug-production: com.adaboys.two_min
        Profile-development: com.adaboys.two_min.dev
        Profile-staging: com.adaboys.two_min.staging
        Profile-production: com.adaboys.two_min
        Release-development: com.adaboys.two_min.dev
        Release-staging: com.adaboys.two_min.staging
        Release-production: com.adaboys.two_min
7. Set the flavor-specific app name
    7.1. In XCode, select the root “Runner” node in the project explorer
    7.2. Select “Runner” below TARGETS
    7.3. Select the “Info” tab
    7.4. Change the value of the key "Bundle name" and "Bundle display name" to $(APP_NAME).
    7.5. Go to the “Build Settings” tab
    7.6 Add a new User-Defined setting
    7.7. Name it APP_NAME
    7.8. Expand the APP_NAME-node by clicking on the small arrow on the left side of the node.
    7.9. Set the value per build configuration:
        Debug-development: DEV TwoMin
        Debug-staging: Staging TwoMin
        Debug-production: TwoMin
        Profile-development: DEV TwoMin
        Profile-staging: Staging TwoMin
        Profile-production: TwoMin
        Release-development: DEV TwoMin
        Release-staging: Staging TwoMin
        Release-production: TwoMin

## FOR FLUTTER
1. Setup app_flavor_config.dart in lib/config/app_flavor_config.dart
2. Run or build
    On the command line: flutter run --flavor development
    In Android Studio: Run/debug configuration Drop Down → Edit Configuration... → Build flavor: development
3. Build command:
   flutter build apk --flavor development
   flutter build apk --flavor staging
   flutter build apk --flavor production

   flutter build appbundle --flavor development
   flutter build appbundle --flavor staging
   flutter build appbundle --flavor production

   flutter build ios --flavor development
   flutter build ios --flavor staging
   flutter build ios --flavor production

## Setup Auto Router (https://pub.dev/packages/auto_route)
dependencies:
  auto_route: [latest-version]

dev_dependencies:
  auto_route_generator: [latest-version]
  build_runner:

flutter packages pub run build_runner watch / flutter packages pub run build_runner build / flutter packages pub run build_runner build --delete-conflicting-outputs
