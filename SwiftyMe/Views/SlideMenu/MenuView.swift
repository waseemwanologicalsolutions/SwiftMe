//
//  MenuView.swift
//  SwiftyMe
//
//  Created by MacBook on 09/01/2023.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var options: NSideMenuOptions
    @Binding var selectedView: String
    var menuItems = [
        ["label": "Home", "icon": "house"],
        ["label": "History", "icon": "clock.arrow.circlepath"],
        ["label": "Notifications", "icon": "bell.badge"],
        ["label": "Settings", "icon": "gear"],
        ["label": "About", "icon": "info.circle"]
    ]
    var body: some View {
        NavigationView{
            
            ZStack{
                
                AppGradientColor.get.redBlueGradient
                VStack(alignment: options.side.getHorizontalAlignment()){
                    VStack(alignment: options.side.getHorizontalAlignment(), spacing: 16){
                        ForEach(menuItems, id: \.self) {item in
                            Button {
                                selectedView = item["label"]!
                                options.toggleMenu()
                                options.objectWillChange.send()
                            } label: {
                                Label(item["label"]!, systemImage: item["icon"]!)
                                    .foregroundColor(Color.primary)
                                    .frame(maxWidth: .infinity, alignment: options.side.getAlignment())
                            }
                        }
                    }
                    .padding(.top, 32)
                    Spacer()
                    VStack(alignment: options.side.getHorizontalAlignment(), spacing: 10){
                        Button("style to normal"){
                            withAnimation {
                                options.style = .normal
                            }
                        }
                        .foregroundColor(Color.white)
                        Button("style to scale"){
                            withAnimation {
                                options.style = .scale
                            }
                        }
                        .foregroundColor(Color.white)
                        Button("style to slideAside"){
                            withAnimation {
                                options.style = .slideAside
                            }
                        }
                        .foregroundColor(Color.white)
                        Button("style to slideAbove"){
                            withAnimation {
                                options.style = .slideAbove
                            }
                        }
                        .foregroundColor(Color.white)
                        Button("style to rotate"){
                            withAnimation {
                                options.style = .rotate
                            }
                        }
                        .foregroundColor(Color.white)
                        Button("toggle skeletonStack") {
                            withAnimation {
                                options.showSkeletonStack.toggle()
                            }
                        }
                        .foregroundColor(Color.white)
                        
                        Button(action: {
                            options.side = options.side == .leading ? .trailing : .leading
                        }) {
                            VStack{
                                Text("toggle side")
                                    .foregroundColor(Color.white)
                                Text("(current: "+options.side.rawValue+")")
                                    .foregroundColor(Color.white)
                            }
                        }
                    }
                    Text("menu visible:: "+options.show.description)
                        .foregroundColor(Color.white)
                        .padding(.bottom, 16)
                    Button("toggle Menu") {
                        options.toggleMenu()
                    }
                    .foregroundColor(Color.white)
                }
                .padding(.horizontal, 16)
            }
            .toolbar(content: {
                ToolbarItem(placement: options.side.getToolbarItemPlacement(), content: {
                    if(options.show){
                        Button {
                            options.toggleMenu()
                        } label: {
                            Image(systemName: "xmark")
                        }
                        .foregroundColor(Color.primary)
                    }
                })
            }).id(UUID())
            .navigationTitle("Menu")
        }
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(selectedView: .constant("Home"))
    }
}
