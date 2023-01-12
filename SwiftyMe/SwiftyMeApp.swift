//
//  SwiftyMeApp.swift
//  SwiftyMe
//
//  Created by MacBook on 04/08/2022.
//

import SwiftUI
import AlertKit
import GoogleMaps
import GooglePlaces

@main
struct SwiftyMeApp: App {
    
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var textFieldViewModel:TextFieldViewModel = TextFieldViewModel()
    @StateObject var secureTextFieldViewModel:SecureTextFieldViewModel = SecureTextFieldViewModel()
    @StateObject var selectedTabIndex:SelectedTabViewModel = SelectedTabViewModel()
    
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate
    
    @StateObject var notificationList:NotificationsList = NotificationsList()
    @StateObject var notificationCenter = AppNotificationCenter()
    
    init(){
        /** Google map and PlacesAPI */
        GMSServices.provideAPIKey(GOOGLE_KEY.GOOGLE_MAP_KEY)
        GMSPlacesClient.provideAPIKey(GOOGLE_KEY.GOOGLE_MAP_KEY)
        
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(textFieldViewModel)
                .environmentObject(secureTextFieldViewModel)
                .environmentObject(selectedTabIndex)
                .environmentObject(notificationCenter)
                .environmentObject(notificationList)
                .onAppear(perform:{
                    print("on appear contentview")
                })
        }
        
    }

}
