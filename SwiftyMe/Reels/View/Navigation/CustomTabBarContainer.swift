//
//  CustomTabBarContainer.swift
//  SwiftyMe
//
//  Created by MacBook on 05/04/2023.
//

import Foundation
import SwiftUI

struct CustomTabBarContainer<Content:View>: View {
    @Binding var selection: TabBarItem
    @Binding var hideFooterTabs:Bool
    let content: Content
    @State private var tabs: [TabBarItem] = []

    init(selection: Binding<TabBarItem>,hideFooterTabs:Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self._hideFooterTabs = hideFooterTabs
        self.content = content()
    }

    var body: some View {
        VStack {
            ZStack {
                content
            }
            if(hideFooterTabs == false){
                CustomTabBar(tabs: tabs, selection: $selection, localSelection: selection)
            }
        }
        .ignoresSafeArea(.keyboard)
        .onPreferenceChange(TabBarItemPreferenceKey.self) { value in
            self.tabs = value
        }
    }
}

struct CustomTabBarContainer_Previews: PreviewProvider {
    static let tabs: [TabBarItem] = [
        .home, .feed, .add, .rules, .profile
    
    ]
    
    static var previews: some View {
        CustomTabBarContainer(selection: .constant(tabs.first!), hideFooterTabs: .constant(false)) {
            Color.red
        }
    }
}
