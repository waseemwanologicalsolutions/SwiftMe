//
//  ContentView.swift
//  SwiftyMe
//
//  Created by MacBook on 04/08/2022.
//

import SwiftUI
import AlertKit

struct ContentView: View {
    
    @StateObject var alertManager = AlertManager()
    
    
    var body: some View {
        
        /*
        VStack{
            StartingListOptionsView()
        }.uses(alertManager)*/
        
        NavigationStack {
            Group{
                SearchRouteView()
            }.navigationBarHidden()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
