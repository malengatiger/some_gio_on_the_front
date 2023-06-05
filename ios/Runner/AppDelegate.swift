import UIKit
import Flutter
import GoogleMaps
import FirebaseMessaging
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      FirebaseApp.configure()
      print("AppDelegate: 🔱 FiebaseApp has been configured")

              // Register for remote notifications
              UNUserNotificationCenter.current().delegate = self
              application.registerForRemoteNotifications()

    GMSServices.provideAPIKey("AIzaSyCXzo0wT6tMvgc1PHFET6nml3xO0fL-vFg")
      GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
