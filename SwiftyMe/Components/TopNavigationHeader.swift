//
//  TopNavigationHeader.swift
//  SwiftyMe
//
//  Created by MacBook on 23/12/2022.
//

import SwiftUI

struct TopNavigationHeader: View {
    
    let actionLeft: () -> Void
    let actionRight: () -> Void
    var rightTitle:String = ""
    @State var showBackButton:Bool = true
    
    var body: some View {
        HStack() {
            if showBackButton{
                IconButton(title: "", foreground: .clear, background: .clear, image: Image("leftArrow"),iconTintColor: Color.black, iconAlignment: .leading, action: actionLeft)
                    .frame(width: 50, height: 50)
            }
            Spacer()
            ZStack {
                RectButton(title: rightTitle, foreground: Color.black, background: .clear, weight: .regular, action: actionRight)
                    .frame(width: 60, height: 50)
            }
        }
    }
    
}

struct TopNavigationHeader_Previews: PreviewProvider {
    static var previews: some View {
        TopNavigationHeader(actionLeft: {}, actionRight: {})
    }
}
