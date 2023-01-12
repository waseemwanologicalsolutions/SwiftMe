//
//  CapsuleButton.swift
//  SwiftyMe
//
//  Created by MacBook on 23/12/2022.
//

import SwiftUI

struct CapsuleButton: View {
    let title: String
    var foreground: Color = .black
    var background: Color = .white
    var fontSize: CGFloat = 17.0
    var height:CGFloat = 48.0
    var weight:Font.Weight = .medium
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            ZStack{
                Capsule()
                    .fill(background)
                Text(title)
                    .font(.sfProRounded(fontSize, weight: weight))
                    .foregroundColor(foreground)
            }
            .frame(height: height)
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }
}

struct CapsuleButton_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleButton(title: "Submit", action: {})
    }
}
