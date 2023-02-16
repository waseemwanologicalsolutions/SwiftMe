//
//  TextFieldClearButton.swift
//  SwiftyMe
//
//  Created by MacBook on 02/02/2023.
//

import SwiftUI

struct TextFieldClearButton: View {
    
    var color:Color = .secondary
    let action: () -> Void
    
    var body: some View {
        Button(action:action) {
            Image(systemName: "multiply.circle.fill")
                .foregroundColor(color)
        }
    }
}

struct TextFieldClearButton_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldClearButton(){
            
        }
    }
}

