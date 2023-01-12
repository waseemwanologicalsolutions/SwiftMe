//
//  MapLocationSelectionView.swift
//  SwiftyMe
//
//  Created by MacBook on 03/01/2023.
//

import SwiftUI

struct MapLocationSelectionView: View {
    @Environment(\.presentationMode) var presentation
    @State var isToMoveBack:Bool = false
    var didLocationSelected: (AddressModel?) -> ()
    
    var body: some View {
        NavigationView{
            MapLocationSelectionViewControllerBridge(didLocationSelected: { adrs in
                if let address = adrs{
                    print(address.address)
                }
                self.didLocationSelected(adrs)
                self.presentation.wrappedValue.dismiss()
            })
        }.navigationBarHidden(true)
    }
}

struct MapLocationSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        MapLocationSelectionView(){_ in
            
        }
    }
}
