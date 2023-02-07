//
//  SourceDestinationLocationViewModel.swift
//  SwiftyMe
//
//  Created by MacBook on 02/02/2023.
//

import Foundation
import SwiftUI

class SourceDestinationLocationViewModel:ObservableObject{
    
    @Published var locationRoutes:[LocationRouteModel] = []
    
}

class SourceDestinationLocationViewModelData{
    static func initServicesList()->[LocationRouteModel]{
        //let array = Array(repeating: SericeModel(id: UUID().uuidString, name: "Daewoo bus service Pakistan", discount: "30 % off", isSelected: false), count: 20)
        var array = [LocationRouteModel]()
        array.append(LocationRouteModel(id: UUID().uuidString, name: "Lahore", shortCode: "LHR", isSelected: false))
        array.append(LocationRouteModel(id: UUID().uuidString, name: "Islamabad", shortCode: "ISB", isSelected: false))
        array.append(LocationRouteModel(id: UUID().uuidString, name: "Karachi", shortCode: "KRC", isSelected: false))
        array.append(LocationRouteModel(id: UUID().uuidString, name: "Faisalabad", shortCode: "FSB", isSelected: false))
        array.append(LocationRouteModel(id: UUID().uuidString, name: "Multan", shortCode: "MNT", isSelected: false))
        return array
    }
}
