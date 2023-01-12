//
//  Font.swift
//  SwiftyMe
//
//  Created by MacBook on 23/12/2022.
//

import Foundation
import SwiftUI

extension Font{
    static func sfProRounded(_ style: Font.TextStyle, weight: Font.Weight? = nil) -> Font{
        if #available(iOS 16.0, *) {
            return Font.system(style, design: .rounded, weight: weight)
        } else {
            return Font.system(style, design: .rounded)
        }
    }
    static func sfProRounded(_ size: CGFloat, weight: Font.Weight? = nil) -> Font{
        if #available(iOS 16.0, *) {
            return Font.system(size: size, weight: weight, design: .rounded)
        } else {
            return Font.system(size: size, design: .rounded)
        }
    }
}
