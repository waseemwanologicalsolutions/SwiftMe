//
//  View+Animation.swift
//  SwiftyMe
//
//  Created by MacBook on 16/01/2023.
//

import Foundation
import SwiftUI

extension Animation {

    static func ripple(index: Int, speed:Double = 2, delay:Double = 0.03) -> Animation {
        Animation.spring(dampingFraction: 0.5)
            .speed(speed)
            .delay(delay)

    }

}


