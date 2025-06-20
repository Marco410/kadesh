import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "com.kadesh.env", binaryMessenger: controller.binaryMessenger)


    channel.setMethodCallHandler { call, result in
      if call.method == "setApiKey", let args = call.arguments as? [String: String], let apiKey = args["apiKey"] {
        GMSServices.provideAPIKey(apiKey)
        result(nil)
      } else {
        result(FlutterError(code: "ERROR", message: "API Key missing", details: nil))
      }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
