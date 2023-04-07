//
//  RulesSceneView.swift
//  SwiftyMe
//
//  Created by MacBook on 05/04/2023.
//

import SwiftUI

struct RulesSceneView: View {
    
    @Binding var tabSelection: TabBarItem
    
    var body: some View {
        Text("Rules")
    }
}

struct RulesSceneView_Previews: PreviewProvider {
    static var previews: some View {
        RulesSceneView(tabSelection: .constant(.rules))
    }
}
