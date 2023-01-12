//
//  MapViewCustom.swift
//  SwiftyMe
//
//  Created by MacBook on 30/12/2022.
//

import SwiftUI
import GoogleMaps

struct MapViewCustom: View {
    
    @Binding var zoomInCenter: Bool
    @State var expandList: Bool = false
    @State var selectedMarker: GMSMarker?
    @State var yDragTranslation: CGFloat = 0
    
    /// State for markers displayed on the map for each city in `cities`
    @State var markers: [GMSMarker] = cities.map {
        let marker = GMSMarker(position: $0.coordinate)
        marker.title = $0.name
        return marker
    }
    
    
    var body: some View {
        
        let scrollViewHeight: CGFloat = 80
        
        NavigationView{
            GeometryReader { geometry in
                ZStack{
                    
                    VStack{
                        
                        Text("Google map via UIViewControllerRepresentable")
                        MapViewControllerBridge(markers: $markers, selectedMarker: $selectedMarker, mapViewWillMove: { _ in
                            
                        })
                        .background(Color(red: 254.0/255.0, green: 1, blue: 220.0/255.0))
                        .frame(height: geometry.size.height/2)
                        
                        Text("Google map via UIViewRepresentable")
                        MapViewGoogle(markers: $markers, selectedMarker: $selectedMarker, onAnimationEnded: {
                            
                        })
                        .background(Color(red: 254.0/255.0, green: 1, blue: 220.0/255.0))
                        .frame(height: geometry.size.height/2)
                    }
                    
                    // Cities List
                    CitiesList(markers: $markers) { (marker) in
                        guard self.selectedMarker != marker else { return }
                        self.selectedMarker = marker
                        self.zoomInCenter = false
                        self.expandList = false
                    }  handleAction: {
                        self.expandList.toggle()
                    }.background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .offset(
                            x: 0,
                            y: geometry.size.height - (expandList ? scrollViewHeight + 150 : scrollViewHeight)
                        )
                        .offset(x: 0, y: self.yDragTranslation)
                        .animation(.spring())
                        .gesture(
                            DragGesture().onChanged { value in
                                self.yDragTranslation = value.translation.height
                            }.onEnded { value in
                                self.expandList = (value.translation.height < -120)
                                self.yDragTranslation = 0
                            }
                        )
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .navigationTitle("MapView")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Help") {
                    print("Help tapped!")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                CapsuleButton(title: "About",foreground: Color.white, background: Color.blue) {
                    print("About tapped!")
                }
            }
        }
        
    }
}

struct MapViewCustom_Preview: PreviewProvider {
    
    static var previews: some View {
        StatefulPreviewWrapper(true){
            MapViewCustom(zoomInCenter:$0 )
        }
    }
}
