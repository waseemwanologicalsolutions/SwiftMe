//
//  ProgressCircle.swift
//  SwiftyMe
//
//  Created by MacBook on 12/01/2023.
//

import SwiftUI

struct ProgressCircle<Background: ShapeStyle, Forground: ShapeStyle>: View {
    let progress: CGFloat
    let strockWidth: CGFloat
    let background: Background
    let forground: Forground
    
    private let size: CGFloat = 1.0
    var body: some View {
        ZStack{
            circleShape
                .stroke(style: stroke)
                .fill(background)
            circleShape
                .trim(from: 0, to: progress)
                .stroke(style: stroke)
                .fill(forground)
        }
        .aspectRatio(1, contentMode: .fit)
        .padding(strockWidth / 2) // Move center border to inner border
        .rotationEffect(Angle(degrees: -90))
    }
    
    var stroke: StrokeStyle{
        StrokeStyle(
            lineWidth: strockWidth,
            lineCap: .round
        )
    }
    
    var circleShape: some Shape{
        Circle()
            .trim(from: 0, to: size)
    }
}

struct ProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircle(
            progress: 0.5,
            strockWidth: 50,
            background: Color.white,
            forground: Color.red
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

