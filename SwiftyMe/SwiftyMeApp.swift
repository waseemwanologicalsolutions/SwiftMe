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
    @StateObject var stateManager = StateManager()
    
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate
    
    @StateObject var notificationList:NotificationsList = NotificationsList()
    @StateObject var notificationCenter = AppNotificationCenter()
    @State var showAlert:Bool = false
    
    @StateObject var searchBusVM = SearchRouteViewModel()
    
    init(){
        /** Google map and PlacesAPI */
        GMSServices.provideAPIKey(GOOGLE_KEY.GOOGLE_MAP_KEY)
        GMSPlacesClient.provideAPIKey(GOOGLE_KEY.GOOGLE_MAP_KEY)
        
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .alert("New Card Added!",
                       isPresented: $showAlert,
                       actions: {
                    Button("OK") {
                        showAlert = false
                    }
                }, message: {
                    Text("NotificationCenter received on app")
                })
                .onReceive(NotificationCenter.default.publisher(for: Notification.Name("Test1"))) { notification in
                    showAlert = true
                }
                .environmentObject(textFieldViewModel)
                .environmentObject(secureTextFieldViewModel)
                .environmentObject(selectedTabIndex)
                .environmentObject(notificationCenter)
                .environmentObject(notificationList)
                .environmentObject(searchBusVM)
                .environmentObject(stateManager)
                .onAppear(perform:{
                    print("on appear contentview")
                    stateManager.data = ReelsDashboardSceneViewModelData.initDataList()
                })
        }
        
    }

}
