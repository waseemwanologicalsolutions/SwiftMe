//
//  CustomTabBarView.swift
//  SwiftyMe
//
//  Created by MacBook on 05/04/2023.
//

import Foundation
import SwiftUI

struct CustomTabBarView: View {
    @EnvironmentObject var stateManager: StateManager
    @State private var tabSelection: TabBarItem = .home
     
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom){
                CustomTabBarContainer(selection: $tabSelection, hideFooterTabs: $stateManager.hideFooterTabs) {
                     
                    ReelsDashboardSceneView(tabSelection: $tabSelection)
                        .tabBarItem(tab: .home, selection: $tabSelection)
        
                    
                    SubmitEntrySceneView(tabSelection: $tabSelection)
                        .tabBarItem(tab: .add, selection: $tabSelection)
                    
                    VideosFeedSceneView(data: .constant(stateManager.data), tabSelection: $tabSelection)
                        .tabBarItem(tab: .feed, selection: $tabSelection)
                    
                    //RulesSceneView(tabSelection: $tabSelection)
                    //    .tabBarItem(tab: .rules, selection: $tabSelection)
                    
                    
                }
                .onChange(of: tabSelection) { _ in
                    print("tab changed")
                }
            
            }
            .navigationTitle(tabSelection.title)
            .onReceive(stateManager.$tabSelection) { newTabSelection in
                self.tabSelection = newTabSelection
            }
            .onAppear{
                stateManager.hideFooterTabs = false
            }
            
        }
    }
    
    
}

struct CustomTabBarView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        CustomTabBarView()
            .environmentObject(StateManager())
    }
}

