// import UIKit
// import Flutter
// import GoogleMaps
// @UIApplicationMain
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     // [GMSServices provideAPIKey:@"AIzaSyCfv3sHSCLPqFyUwjIOsKtC13OnHPV_nJQ"];
//      GMSServices.provideAPIKey("AIzaSyCfv3sHSCLPqFyUwjIOsKtC13OnHPV_nJQ")
//     GeneratedPluginRegistrant.register(with: self)
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
// }


// import UIKit
// import Flutter
// import Firebase
// // import flutter_downloader
// import GoogleMaps

// @UIApplicationMain
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
      
//     GMSServices.provideAPIKey("AIzaSyCfv3sHSCLPqFyUwjIOsKtC13OnHPV_nJQ")
//     GeneratedPluginRegistrant.register(with: self)
//       if(FirebaseApp.app() == nil){
//               FirebaseApp.configure()
//           }
   
//       // FlutterDownloaderPlugin.setPluginRegistrantCallback(registerPlugins)

//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
// }
// // // private func registerPlugins(registry: FlutterPluginRegistry) {
// // //     if (!registry.hasPlugin("FlutterDownloaderPlugin")) {
// // //        FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin")!)
// // //     }
// // }
import UIKit
import Flutter
import Firebase // Add this import


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, MessagingDelegate  {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // GMSServices.provideAPIKey("AIzaSyCfv3sHSCLPqFyUwjIOsKtC13OnHPV_nJQ")
    FirebaseApp.configure()
    Messaging.messaging().delegate = self
    GeneratedPluginRegistrant.register(with: self)
    if #available(iOS 10.0, *) {
        // For iOS 10 display notification (sent via APNS)
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
    } else {
        let settings: UIUserNotificationSettings =
        UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        application.registerUserNotificationSettings(settings)
    }
    application.registerForRemoteNotifications()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}