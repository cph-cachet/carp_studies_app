import UIKit
import Flutter
import flutter_local_notifications

// func registerPlugins(registry: FlutterPluginRegistry) -> () {
//     if (!registry.hasPlugin("BackgroundLocatorPlugin")) {
//         GeneratedPluginRegistrant.register(with: registry)
//     }
// }

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    //  from flutter_local_notifications
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
