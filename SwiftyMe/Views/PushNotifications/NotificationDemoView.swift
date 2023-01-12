//
//  NotificationDemoView.swift
//  SwiftyMe
//
//  Created by MacBook on 11/01/2023.
//

import SwiftUI

struct NotificationDemoView: View {
    
    @EnvironmentObject var notificationCenter:AppNotificationCenter
    @EnvironmentObject var notificationList:NotificationsList
   
    var body: some View {
        VStack{
            CapsuleButton(title: "Notification Permission", foreground: Color.white, background: Color.black) {
                
                notificationCenter.askForNotificattionPermission()
                
            }.padding(30)
            
            CapsuleButton(title: "Notification Show", foreground: Color.white, background: Color.black) {
                
                notificationCenter.setLocalNotification(title: "Hello", subtitle: "Test title", body: "How is today?", when: 1)
                
                
                
            }.padding(30)
            
            //// can be handled via published object
            List {
                ForEach($notificationCenter.notificationList) { notification in
                    CardView(notification: notification.wrappedValue)
                }
            }
            
            //can be handled via environment variable , updating via handler
            /*
            List {
                ForEach($notificationList.notifications) { notification in
                    CardView(notification: notification.wrappedValue)
                }
            }*/
            
        }.onAppear(perform: {
            let nList = $notificationCenter.notificationList
            print("nList=", nList.count)
            notificationCenter.notificationHandler = { val in
                notificationList.notifications.append(val)
            }
        })
    }
    
}

struct NotificationDemoView_Previews: PreviewProvider {
    static let response = NotificationResponse(actionIdentifier: "test", body: "body", title: "title", subtitle: "Subtitle")
    static var previews: some View {
        NotificationDemoView()
    }
}

struct CardView: View {
    let notification: NotificationResponse
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Old Notification Payload:")
            Text(notification.actionIdentifier ?? "")
            Text(notification.body ?? "")
            Text(notification.title ?? "")
            Text(notification.subtitle ?? "")
        }
        .padding()
        
    }
}
