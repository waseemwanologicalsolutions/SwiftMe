// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


import GoogleMaps
import SwiftUI

/// The wrapper for `GMSMapView` so it can be used in SwiftUI
struct MapViewGoogle: UIViewRepresentable {
    
    @Binding var markers: [GMSMarker]
    @Binding var selectedMarker: GMSMarker?
    
    var onAnimationEnded: () -> ()
    
    private let gmsMapView = GMSMapView(frame: .zero)
    private let defaultZoomLevel: Float = 12
    
    func makeUIView(context: Context) -> GMSMapView {
        // Create a GMSMapView centered around the city of San Francisco, California
        let sanFrancisco = CLLocationCoordinate2D(latitude: 37.7576, longitude: -122.4194)
        gmsMapView.camera = GMSCameraPosition.camera(withTarget: sanFrancisco, zoom: defaultZoomLevel)
        gmsMapView.delegate = context.coordinator
        gmsMapView.isUserInteractionEnabled = true
        return gmsMapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        markers.forEach { marker in
            marker.map = uiView
        }
        selectedMarker?.map = uiView
        animateToSelectedMarker(uiView)
    }
    
    private func animateToSelectedMarker(_ uiView: GMSMapView) {
        guard let selectedMarker = selectedMarker else {
            return
        }
        
        let map = uiView
        if map.selectedMarker != selectedMarker {
            map.selectedMarker = selectedMarker
            map.animate(with: GMSCameraUpdate.setTarget(selectedMarker.position))
        }
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(self)
    }
    
    
    final class MapViewCoordinator: NSObject, GMSMapViewDelegate {
        var mapView: MapViewGoogle
        
        init(_ mapView: MapViewGoogle) {
            self.mapView = mapView
        }
        
        func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
            //      let marker = GMSMarker(position: coordinate)
            //      self.mapView.polygonPath.append(marker)
        }
        
        func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
            self.mapView.onAnimationEnded()
            print("ideal at")
        }
        
    }
}
