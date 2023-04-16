import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      guard let apiKey = Bundle.main.infoDictionary?["GOOGLE_MAPS_API_KEY"] as? String else {
        fatalError("Make sure GOOGLE_MAPS_API_KEY is set in the Info.plist file. And that GoogleMapsAPIKeys.xcconfig is included in the root folder with the key. See README for more details")
      }


    GMSServices.provideAPIKey(apiKey)


    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
