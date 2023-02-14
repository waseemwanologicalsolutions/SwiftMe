//
//  BusDetailsViewModel.swift
//  SwiftyMe
//
//  Created by MacBook on 14/02/2023.
//

import Foundation
import Foundation
import SwiftUI

class BusDetailsViewModel:ObservableObject{
    
    @Published var results:[ServicesSearchResultsModel] = []
    
}

class BusDetailsViewModelData{
    static func initServicesList()->[ServicesSearchResultsModel]{
        //let array = Array(repeating: SericeModel(id: UUID().uuidString, name: "Daewoo bus service Pakistan", discount: "30 % off", isSelected: false), count: 20)
        var array = [ServicesSearchResultsModel]()
        let from = LocationRouteModel(id: UUID().uuidString, name: "Islamabad", shortCode: "ISB", isSelected: false)
        let to = LocationRouteModel(id: UUID().uuidString, name: "Karachi", shortCode: "KRC", isSelected: false)
        array.append(ServicesSearchResultsModel(id: UUID().uuidString, name: "Lahore", logo: "daewoo", time:"11:30 PM", price:2000,fromLoction:from, toLocation: to,  isSelected: false))
        array.append(ServicesSearchResultsModel(id: UUID().uuidString, name: "Lahore", logo: "daewoo", time:"12:30 PM", price:3000,fromLoction:from, toLocation: to,  isSelected: false))
        return array
    }
}
