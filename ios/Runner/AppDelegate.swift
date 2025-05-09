import Flutter
import UIKit
import GoogleMaps


@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyCEOaI34HQCfn5HBo7IjspiDw7-7GlWwVI")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
