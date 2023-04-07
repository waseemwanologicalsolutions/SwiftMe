//
//  SocialCircleButton.swift
//  SwiftyMe
//
//  Created by MacBook on 30/03/2023.
//

import SwiftUI

struct SocialCircleButton: View {
    let image: String
    var bgColor:Color = Color.reel_blue
    var iconPadding:CGFloat = 4
    var width: CGFloat = 36.0
    var height:CGFloat = 36.0
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            ZStack{
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(iconPadding)
            }
            .frame(height: width)
            .frame(width: width)
            .background(bgColor)
            .cornerRadius(width/2.0)
            .shadow(radius: 2)
        }
        .buttonStyle(.plain)
    }
}

struct SocialCircleButton_Previews: PreviewProvider {
    static var previews: some View {
        SocialCircleButton(image: "reel_facebook") {
            
        }
    }
}
