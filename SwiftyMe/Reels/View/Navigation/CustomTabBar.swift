//
//  CustomTabBar.swift
//  SwiftyMe
//
//  Created by MacBook on 05/04/2023.
//

import Foundation
import SwiftUI

struct CustomTabBar: View {
    
    let tabs: [TabBarItem]
    
    @Binding var selection: TabBarItem
    @Namespace private var namespace
    @State var localSelection: TabBarItem
    @State private var showSheet: Bool = false

    var body: some View {
            HStack {
                ForEach(tabs, id: \.self) { tab in
                    tabBar(tab: tab)
                        .onTapGesture {
                            switchToTab(tab: tab)
                        }
                        .onChange(of: selection, perform: { value in
                            withAnimation(.easeInOut) {
                                localSelection = value
                            }
                        })
                }
                
            }
            .padding(6)
            .background(Color.black.ignoresSafeArea(edges: .bottom))
            
        
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static let tabs: [TabBarItem] = [
        .home, .feed, .rules, .profile
    
    ]

    static var previews: some View {
        
        VStack {
            Spacer()
            CustomTabBar(tabs: tabs, selection: .constant(tabs.first!), localSelection: tabs.first!)
        }
    }
}

extension CustomTabBar {
    private func tabBar(tab: TabBarItem) -> some View {
        VStack {
            if tab == .add{
                Image(systemName: tab.iconName)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .font(.headline)
            }else{
                Image(systemName: tab.iconName)
                    .font(.subheadline)
                Text(tab.title)
                    .font(.custom("Poppins Medium", size: 12))
            }
        }
        .foregroundColor(localSelection == tab ? tab.color : Color.gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                if localSelection == tab {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(tab.color.opacity(0.2))
                        .matchedGeometryEffect(id: "background_rectangle", in: namespace)
                }
            }
        )
    }
    
    private func switchToTab(tab: TabBarItem) {
        selection = tab
    }
}
