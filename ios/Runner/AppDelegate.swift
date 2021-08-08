import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // TODO: Add your API key
    GMSServices.provideAPIKey("AIzaSyDb9BhJ4sK8l0ySWSaSTfGlbYWZozXBEJs")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
