//
//  BorderedCircle.swift
//  SwiftyMe
//
//  Created by MacBook on 14/02/2023.
//

import SwiftUI

struct BorderedCircle: View {
    var borderColor:Color = .black
    var radius:CGFloat = 7
    var strokeWidth:CGFloat = 1
    var body: some View {
        Rectangle()
            .stroke(Color.clear)
            .background(.clear)
            .frame(width: radius * 2, height: radius * 2)
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(borderColor, lineWidth: strokeWidth)
            )
    }
}

struct BorderedCircle_Previews: PreviewProvider {
    static var previews: some View {
        BorderedCircle()
    }
}
