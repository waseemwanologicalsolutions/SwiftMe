//
//  AppDelegate.swift
//  SwiftyMe
//
//  Created by MacBook on 11/01/2023.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseMessaging

class AppDelegate: NSObject, UIApplicationDelegate {
    
    var application:UIApplication?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        self.application = application
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self

        return true
    }
    //No callback in simulator -- must use device to get valid push token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        Messaging.messaging().apnsToken = deviceToken
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("devieToken", deviceTokenString)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String){

      let deviceToken:[String: String] = ["token": fcmToken ?? ""]
        print("Device token: ", deviceToken) // This token can be used for testing notifications on FCM
    }
}
