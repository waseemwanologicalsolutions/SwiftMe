//
//  NotificationCenter.swift
//  SwiftyMe
//
//  Created by MacBook on 11/01/2023.
//

import Foundation
import SwiftUI

class NotificationsList:ObservableObject{
    @Published var notifications:[NotificationResponse] = []
}

struct NotificationResponse:Identifiable, Codable{
    let actionIdentifier:String?
    let body:String?
    let title:String?
    let subtitle:String?
    var id = UUID()
}

class AppNotificationCenter: NSObject, ObservableObject {
    @Published var dumbData: NotificationResponse?
    @Published var notificationList: [NotificationResponse] = []
    
    @EnvironmentObject var notificationListEnv:NotificationsList
    var notificationHandler:((NotificationResponse)->Void)?
    
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    func askForNotificattionPermission(){
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (allowed, error) in
            //This callback does not trigger on main loop be careful
            if allowed {
                print("Allowed")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                print("Error")
            }
        }
    }
    
    func setLocalNotification(title: String, subtitle: String, body: String, when: Double) {
            let content = UNMutableNotificationContent()
            content.title = title
            content.subtitle = subtitle
            content.body = body
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: when, repeats: false)
            let request = UNNotificationRequest.init(identifier: "localNotificatoin", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
        }
}

extension AppNotificationCenter: UNUserNotificationCenterDelegate  {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let obj = NotificationResponse(actionIdentifier: response.actionIdentifier, body: response.notification.request.content.body, title: response.notification.request.content.title, subtitle: response.notification.request.content.subtitle)
        self.notificationList.append(obj)
        
        dumbData = obj
        
        notificationHandler?(obj)
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        
    }
}
