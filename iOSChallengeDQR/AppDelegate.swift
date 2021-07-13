//
//  AppDelegate.swift
//  iOSChallengeDQR
//
//  Created by DevLuis on 12/07/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var enableOrientationLandscape = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.orange, .font: UIFont.systemFont(ofSize: 27)]
        UITabBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().barTintColor = UIColor.black
        UITabBar.appearance().unselectedItemTintColor = .lightGray
        UITabBar.appearance().isTranslucent = true
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: SupportedInterfaceOrientationsFor
    func application(_: UIApplication, supportedInterfaceOrientationsFor _: UIWindow?) -> UIInterfaceOrientationMask {
           if enableOrientationLandscape == true {
               return .landscape
           }

           return .portrait
    }
}
