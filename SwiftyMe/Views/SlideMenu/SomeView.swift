//
//  SomeView.swift
//  SwiftyMe
//
//  Created by MacBook on 09/01/2023.
//

import SwiftUI

struct SomeView: View {
    var label: String
    @EnvironmentObject var options: NSideMenuOptions
    var body: some View {
        NavigationView{
            VStack{
                Text(label)
                    .padding()
                Text("Menu Visible: "+options.show.description)
            }
            .frame(maxHeight: .infinity)
            .toolbar(content: {
                ToolbarItem(placement: options.side.getToolbarItemPlacement(), content: {
                    if(!options.show){
                        Button {
                            options.toggleMenu()
                        } label: {
                            Image(systemName: "line.3.horizontal")
                        }
                    }
                })
            }).id(UUID())
                .navigationTitle(label)
                .navigationBarTitleDisplayMode(.large)
                
        }
        
    }
}

struct SomeView_Previews: PreviewProvider {
    static var previews: some View {
        SomeView(label: "test")
    }
}
