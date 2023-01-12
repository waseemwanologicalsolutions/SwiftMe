//
//  CapsuleButton.swift
//  SwiftyMe
//
//  Created by MacBook on 23/12/2022.
//

import SwiftUI

struct IconButton: View {
    let title: String
    var foreground: Color = .black
    var background: Color = .white
    var fontSize: CGFloat = 17.0
    var height:CGFloat = 48.0
    var round:CGFloat = 5.0
    var weight:Font.Weight = .medium
    var image:Image = Image("leftArrow")
    var iconTintColor:Color = .black
    var iconAlignment:TextAlignment = .center
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            ZStack{
                Rectangle()
                    .fill(background)
                    .cornerRadius(round)
                Text(title)
                    .font(.sfProRounded(fontSize, weight: weight))
                    .foregroundColor(foreground)
                if iconAlignment == .leading{
                    HStack {
                        image
                            .tint(iconTintColor)
                        Spacer()
                    }
                }else if iconAlignment == .trailing{
                    HStack {
                        Spacer()
                        image
                            .tint(iconTintColor)
                    }
                }else{
                    image
                        .tint(iconTintColor)
                }
            }
            .frame(height: height)
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(title: "", action: {})
    }
}
