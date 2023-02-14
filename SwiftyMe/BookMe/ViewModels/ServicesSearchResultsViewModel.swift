//
//  ServicesSearchResultsViewModel.swift
//  SwiftyMe
//
//  Created by MacBook on 13/02/2023.
//

import Foundation
import SwiftUI

class ServicesSearchResultsViewModel:ObservableObject{
    
    @Published var results:[ServicesSearchResultsModel] = []
    @Published var showBusDetails:Bool = false
    @Published var selectedResult:ServicesSearchResultsModel = ServicesSearchResultsViewModelData.initServicesList()[0]
}

class ServicesSearchResultsViewModelData{
    static func initServicesList()->[ServicesSearchResultsModel]{
        //let array = Array(repeating: SericeModel(id: UUID().uuidString, name: "Daewoo bus service Pakistan", discount: "30 % off", isSelected: false), count: 20)
        var facilitties = [BusFacilityModel]()
        facilitties.append(BusFacilityModel(name: "Wifi", icon: "wifi"))
        facilitties.append(BusFacilityModel(name: "Tablet", icon: "tv"))
        facilitties.append(BusFacilityModel(name: "Air condition", icon: "snowflake"))
        facilitties.append(BusFacilityModel(name: "Headphones", icon: "headphones"))
        facilitties.append(BusFacilityModel(name: "Refershment", icon: "fork.knife"))
        facilitties.append(BusFacilityModel(name: "Power plug", icon: "powerplug"))
        
        var array = [ServicesSearchResultsModel]()
        let from = LocationRouteModel(id: UUID().uuidString, name: "Islamabad", shortCode: "ISB", isSelected: false)
        let to = LocationRouteModel(id: UUID().uuidString, name: "Karachi", shortCode: "KRC", isSelected: false)
        var item1 = ServicesSearchResultsModel(id: UUID().uuidString, name: "Lahore", logo: "daewoo", time:"11:30 PM", price:2000,fromLoction:from, toLocation: to,  isSelected: false)
        item1.facilities = facilitties
        array.append(item1)
        var item2 = ServicesSearchResultsModel(id: UUID().uuidString, name: "Lahore", logo: "daewoo", time:"12:30 PM", price:3000,fromLoction:from, toLocation: to,  isSelected: false)
        item2.facilities = facilitties
        array.append(item2)
        return array
    }
}
