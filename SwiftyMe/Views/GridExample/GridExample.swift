//
//  GridExample.swift
//  SwiftyMe
//
//  Created by MacBook on 23/01/2023.
//

import SwiftUI

struct GridExample: View {
    let data = (1...100).map { "Item \($0)" }
    /*
     // adapive mean minimum width
     let columns = [
     GridItem(.adaptive(minimum: 50))
     ]
     */
    
    //flexible mean x number of items in one row
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let items = 1...50
    let rows = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        VStack{
            Text("Vertical grid")
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(data, id: \.self) { item in
                        
                        CardViewItem(item: item)
                            .frame(maxWidth:.infinity)
                            .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    }
                }
                .padding()
            }
            .frame(height: 300)
            .padding()
            
            Text("Horizontal grid")
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, alignment: .center) {
                    ForEach(items, id: \.self) { item in
                        Image(systemName: "\(item).circle.fill")
                            .font(.largeTitle)
                    }
                }
                .frame(height: 70)
            }
            
            Spacer()
        }
    }
}

struct GridExample_Previews: PreviewProvider {
    static var previews: some View {
        GridExample()
    }
}

struct CardViewItem: View {
    let item: String
    
    var body: some View {
        VStack(alignment: .center) {
            Text(item)
        }.frame(height: 70)
        
    }
}
