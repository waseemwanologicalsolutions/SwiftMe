//
//  TabBarItem.swift
//  SwiftyMe
//
//  Created by MacBook on 05/04/2023.
//

import Foundation
import SwiftUI

enum TabBarItem: Hashable {
    case home, feed, add, rules, profile
    var iconName: String {
        switch self {
        case .home: return "circle.grid.2x2.fill"
        case .feed: return "checkmark.circle"
        case .add: return "plus.rectangle.fill"
        case .rules: return "car"
        case .profile: return "person"
        }
    }
    var title: String {
        switch self {
        case .home: return "Home"
        case .feed: return "Reels"
        case .add: return ""
        case .rules: return "Rules"
        case .profile: return "Profile"
        }
    }
    
    var color: Color {
        switch self {
        case .home: return Color.white
        case .feed: return Color.white
        case .add: return Color.white
        case .rules: return Color.white
        case .profile: return Color.white
        }
    }
}
