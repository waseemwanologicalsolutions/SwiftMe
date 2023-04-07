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
    var iconPadding:CGFloat = 0
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
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .tint(iconTintColor)
                            .padding([.leading],iconPadding)
                        Spacer()
                    }
                }else if iconAlignment == .trailing{
                    HStack {
                        Spacer()
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .tint(iconTintColor)
                            .padding([.trailing],iconPadding)
                    }
                }else{
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .tint(iconTintColor)
                        .padding(iconPadding)
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
