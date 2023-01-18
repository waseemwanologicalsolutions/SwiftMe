//
//  StartingListOptionsView.swift
//  SwiftyMe
//
//  Created by MacBook on 29/12/2022.
//

import SwiftUI

struct StartingListOptionsView: View {
    
    @State var zoomInCenter: Bool = false
    @State var selectedAddress:AddressModel?
    @EnvironmentObject var listNotification:NotificationsList
    
    
    var body: some View {
        NavigationView{
            List {
                
                Section(header: Text("Sample Implementtions of Components")){
                    NavigationLink(destination: LoginView(showBackButton:true)){
                        Label("Login",systemImage: "paintpalette")
                            .font(.sfProRounded(20))
                            .foregroundColor(Color.blue)
                    }
                    
                    NavigationLink(destination: SignupView()){
                        Label("Signup",systemImage: "paintpalette")
                            .font(.sfProRounded(20))
                            .foregroundColor(Color.blue)
                    }
                    NavigationLink(destination: TabBarView(showBackButton:true)){
                        Label("TabBar", systemImage: "paintpalette")
                            .font(.system(size: 20))
                            .foregroundColor(Color.blue)
                    }
                    NavigationLink(destination: MapViewCustom(zoomInCenter: $zoomInCenter)){
                        Label("Google with swiftUI", systemImage: "paintpalette")
                            .font(.system(size: 20))
                            .foregroundColor(Color.blue)
                    }
                    NavigationLink(destination: MapLocationSelectionView(){ adrs in
                        self.selectedAddress = adrs
                    }){
                        Label("Google with UIKit", systemImage: "paintpalette")
                            .font(.system(size: 20))
                            .foregroundColor(Color.blue)
                        Text($selectedAddress.wrappedValue?.address ?? "")
                    }
                    NavigationLink(destination: SlideMenuDemo()) {
                        Label("Slide Menu", systemImage: "paintpalette")
                            .font(.system(size: 20))
                            .foregroundColor(Color.blue)
                    }
                    NavigationLink(destination: NotificationDemoView()){
                        Label("Push notification", systemImage: "paintpalette")
                            .font(.system(size: 20))
                            .foregroundColor(Color.blue)
                    }
                    NavigationLink(destination:PickersSample(dateComponents: .hourAndMinute)){
                        Label("PickersSample", systemImage: "paintpalette")
                            .font(.system(size: 20))
                            .foregroundColor(Color.blue)
                    }
                    NavigationLink(destination: AnimateSampleView()){
                        Text("Animations")
                    }
                   
                    NavigationLink(destination: SkeltonViewExample()) {
                        Label("SkeltonViewExample", systemImage: "paintpalette")
                            .font(.system(size: 20))
                            .foregroundColor(Color.blue)
                    }
                    
                }
                CapsuleButton(title: "Notification Observer test", foreground: Color.red) {
                    NotificationCenter.default.post(Notification(name:Notification.Name("Test1")))
                }
            }
            
            
        }.navigationBarHidden(true)
    }
}

struct StartingListOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        StartingListOptionsView()
    }
}
