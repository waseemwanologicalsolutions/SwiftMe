//
//  TabBarView.swift
//  SwiftyMe
//
//  Created by MacBook on 30/12/2022.
//

import SwiftUI

class SelectedTabViewModel : ObservableObject {
    @Published var selectedView = 0
}

struct TabBarView: View {
    
    @EnvironmentObject var selectedTabIndex:SelectedTabViewModel
    var showBackButton:Bool = true
    
    init(showBackButton:Bool = true) {
        self.showBackButton = showBackButton
     UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.init(name: "Avenir-Heavy", size: 15)! ], for: .normal)
    }
    
    var body: some View {
        TabView(selection: $selectedTabIndex.selectedView) {
            LoginView(showBackButton:showBackButton).tint(Color.blue)
                .tabItem {
                    Label("Login", systemImage: "list.dash")
                        .font(.sfProRounded(20))
                        .foregroundColor(Color.green)
                }.tag(0)
            
            SignupView(showBackButton:showBackButton).tint(Color.blue)
                .tabItem {
                    Label("Signup", systemImage: "square.and.pencil")
                }
                .badge(5)
                .tag(1)
        }.tint(Color.red)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView().environmentObject(SelectedTabViewModel())
    }
}
