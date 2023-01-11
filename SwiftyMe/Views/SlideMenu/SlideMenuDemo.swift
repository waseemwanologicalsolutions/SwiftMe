//
//  SlideMenuDemo.swift
//  SwiftyMe
//
//  Created by MacBook on 09/01/2023.
//

import SwiftUI

struct SlideMenuDemo: View {
    
    @State var selectedView = "Home"
    @StateObject var options = NSideMenuOptions(style: .normal, side: .leading, width: 220, showSkeletonStack: false, skeletonStackColor: .white, cornerRaduisIfNeeded: 16, rotationDegreeIfNeeded: 8, onWillClose: {
        print("options:onWillClose!")
    }, onWillOpen: {
        print("options:onWillOpen!")
    }, onDidClose: {
        print("options:onDidClose!")
    }, onDidOpen: {
        print("options:onDidOpen!")
    })
    
    var body: some View {
        
        NSideMenuView(options: options){
            Menu{
                MenuView(selectedView: $selectedView)
            }
            Main{
                switch selectedView {
                case "History":
                    SomeView(label: "History")
                case "Notifications":
                    SomeView(label: "Notifications")
                case "Settings":
                    SomeView(label: "Settings")
                case "About":
                    SomeView(label: "About")
                default:
                    /*
                    VStack{
                        CapsuleButton(title: "Show Menu",background:.blue) {
                            options.toggleMenu()
                        }
                        //SomeView(label: "Default")
                    }*/
                    SomeView(label: "Default")
                }
            }
        }
        .onAppear{
            options.width = 220
            options.onDidOpen = {
                print("options:onDidOpen!")
            }
            options.onDidClose = {
                print("options:onDidClose!")
            }
            options.onWillClose = {
                print("options:onWillClose!")
            }
            options.onWillOpen = {
                print("options:onWillOpen!")
            }
        }
        .navigationBarBackButtonHidden()
        .environmentObject(options)
    }
}

struct SlideMenuDemo_Previews: PreviewProvider {
    static var previews: some View {
        SlideMenuDemo()
    }
}
