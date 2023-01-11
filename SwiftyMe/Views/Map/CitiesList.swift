//
//  CitiesList.swift
//  SwiftyMe
//
//  Created by MacBook on 03/01/2023.
//

import SwiftUI
import GoogleMaps
import CoreLocation

struct City {
  var name: String
  var coordinate: CLLocationCoordinate2D
}

let cities = [
  City(name: "San Francisco", coordinate: CLLocationCoordinate2D(latitude: 37.7576, longitude: -122.4194)),
  City(name: "Seattle", coordinate: CLLocationCoordinate2D(latitude: 47.6131742, longitude: -122.4824903)),
  City(name: "Singapore", coordinate: CLLocationCoordinate2D(latitude: 1.3440852, longitude: 103.6836164)),
  City(name: "Sydney", coordinate: CLLocationCoordinate2D(latitude: -33.8473552, longitude: 150.6511076)),
  City(name: "Tokyo", coordinate: CLLocationCoordinate2D(latitude: 35.6684411, longitude: 139.6004407))
]

struct CitiesList: View {

  @Binding var markers: [GMSMarker]
  var buttonAction: (GMSMarker) -> Void
  var handleAction: () -> Void

  var body: some View {
    GeometryReader { geometry in
      VStack(spacing: 0) {

        // List Handle
        HStack(alignment: .center) {
          Rectangle()
            .frame(width: 25, height: 4, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .cornerRadius(10)
            .opacity(0.25)
            .padding(.vertical, 8)
        }
        .frame(width: geometry.size.width, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .onTapGesture {
          handleAction()
        }

        // List of Cities
        List {
            ForEach(0..<self.markers.count) { id in
              let marker = self.markers[id]
              Button(action: {
                buttonAction(marker)
              }) {
                Text(marker.title ?? "")
              }
            }
        }.frame(maxWidth: .infinity)
      }
    }
  }
}

/*
struct CitiesList_Previews: PreviewProvider {
    static var previews: some View {
        CitiesList()
    }
}*/
