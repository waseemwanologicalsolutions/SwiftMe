//
//  AppGradientColor.swift
//  SwiftyMe
//
//  Created by MacBook on 09/01/2023.
//

import Foundation
import SwiftUI

struct AppGradientColor{
    static let get = AppGradientColor()
    var redBlueGradient:some View{
        LinearGradient
            .init(gradient: .init(
                colors: [Color.blue,Color.purple]
            ), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}
