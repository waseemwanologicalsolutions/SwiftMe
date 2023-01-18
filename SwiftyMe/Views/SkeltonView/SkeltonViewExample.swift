//
//  SkeltonViewExample.swift
//  SwiftyMe
//
//  Created by MacBook on 18/01/2023.
//

import SwiftUI

struct SkeltonViewExample: View {
    
    @State var isLoading = true
    
    var body: some View {
        VStack{
            VStack{
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .padding(10)
                Text("Redactive modifier is for making view skelton loading")
                Image("img")
                    .resizable()
                    .frame(width: 200,height: 200)
            }
            .padding()
            .redacted(if: isLoading)
            CapsuleButton(title: isLoading ? "Stop loading" : "Show loading", foreground: Color.red, background: Color.green) {
                isLoading.toggle()
            }
        }
    }
}

struct SkeltonViewExample_Previews: PreviewProvider {
    static var previews: some View {
        SkeltonViewExample()
    }
}
