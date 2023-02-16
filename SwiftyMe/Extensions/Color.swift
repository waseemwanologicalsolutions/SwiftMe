//
//  Color.swift
//  SwiftyMe
//
//  Created by MacBook on 23/12/2022.
//

import Foundation
import SwiftUI

extension Color{
    
    static let tableBackground = Color(hex: "#151517")
    static let tableTextColor = Color(hex: "#FFFFFF")
    static let bm_black_text = Color("bm_black_text")
    static let bm_white_text = Color("bm_white_text")
    static let bm_blue_bg = Color("bm_blue_bg")
    static let bm_blue_icon = Color("bm_blue_icon")
    static let bm_yellow = Color("bm_yellow")
    static let bm_field_bg = Color("bm_field_bg")
    static let bm_location_field_inactive = Color("bm_location_field_inactive")
    static let bm_light_gray = Color("bm_light_gray")
    static let bm_light_gray_black = Color("bm_light_gray_black")
    static let bm_seats_bg = Color("bm_seats_bg")
    static let bm_dark_blue = Color("bm_dark_blue")
    static let bm_orange = Color("bm_orange")
    static let bm_pink = Color("bm_pink")
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
