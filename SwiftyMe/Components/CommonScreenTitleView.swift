//
//  CommonScreenTitleView.swift
//  SwiftyMe
//
//  Created by MacBook on 28/12/2022.
//

import SwiftUI

struct CommonScreenTitleView: View {
    var title:String = "Login to your account!"
    var body: some View {
        return Text(title)
            .font(.title)
            .fontWeight(.medium)
    }

}
