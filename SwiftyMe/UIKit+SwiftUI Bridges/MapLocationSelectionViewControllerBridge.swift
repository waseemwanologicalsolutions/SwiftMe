//
//  MapLocationSelectionViewControllerBridge.swift
//  SwiftyMe
//
//  Created by MacBook on 03/01/2023.
//

import Foundation
import GoogleMaps
import SwiftUI

struct MapLocationSelectionViewControllerBridge: UIViewControllerRepresentable {
    
    var didLocationSelected: (AddressModel?) -> ()
    
    func makeUIViewController(context: Context) -> MapLocationSelectionViewController {
        let uiViewController = MapLocationSelectionViewController.initFromStoryboard()
        //uiViewController.map.delegate = context.coordinator
        uiViewController.completeionHandler = { adrs in
            self.didLocationSelected(adrs)
        }
        return uiViewController
    }
    
    func updateUIViewController(_ uiViewController: MapLocationSelectionViewController, context: Context) {
        
        //do update related stuff
        
    }
    func makeCoordinator() -> MapLocationSelectionViewControllerCoordinator {
        return MapLocationSelectionViewControllerCoordinator(self)
    }
    
   
    final class MapLocationSelectionViewControllerCoordinator: NSObject {
        var viewControllerBridge: MapLocationSelectionViewControllerBridge
        
        init(_ viewControllerBridge: MapLocationSelectionViewControllerBridge) {
            self.viewControllerBridge = viewControllerBridge
        }
        
    }
}
