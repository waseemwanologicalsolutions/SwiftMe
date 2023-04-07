//
//  StateManager.swift
//  SwiftyMe
//
//  Created by MacBook on 05/04/2023.
//

import Foundation
import SwiftUI

class StateManager: ObservableObject {
    @Published var id: String = ""
    @Published var tabSelection: TabBarItem = .home
    @Published var hideFooterTabs:Bool = false
    @Published var selectedVideoFromList: String = ""
    @Published var data:[ReelsModel] = []
    
}
