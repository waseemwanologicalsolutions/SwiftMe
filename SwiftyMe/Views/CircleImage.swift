//
//  CircleImage.swift
//  SwiftyMe
//
//  Created by MacBook on 17/08/2022.
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    var body: some View {
        image
            .clipShape(Circle())
            .overlay(Circle().strokeBorder(.red, lineWidth: 4.0))
            .shadow(radius: 7)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("turtlerock"))
    }
}
