//
//  LandmarkRow.swift
//  SwiftyMe
//
//  Created by MacBook on 17/08/2022.
//

import SwiftUI

struct LandmarkRow: View {
    
    var landmark: Landmark
    
    var body: some View {
        HStack {
            landmark.image
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(5)
                .padding(10)
    
            VStack(alignment: .leading, spacing: 5) {
                Text(landmark.name).font(.title)
                Text("Subtitle \nSubtitle").font(.subheadline)
            }.padding(10)
            Spacer()
        }
        .background(RoundedRectangle(cornerRadius: 4.0).fill(.white).shadow(radius:4.0).opacity(0.25))
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LandmarkRow(landmark: landmarks[0])
        }.previewLayout(.fixed(width: 300, height: 70))
    }
}
