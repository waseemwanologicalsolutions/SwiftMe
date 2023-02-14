//
//  ServicesSearchResultsModel.swift
//  SwiftyMe
//
//  Created by MacBook on 13/02/2023.
//

import Foundation
struct ServicesSearchResultsModel:Identifiable, Codable{
    let id:String
    let name:String?
    let logo:String?
    let time:String?
    let price:Double?
    let fromLoction:LocationRouteModel?
    let toLocation:LocationRouteModel?
    var isSelected:Bool = false
    var facilities:[BusFacilityModel] = []
    
    init(id: String, name: String?, logo:String?, time:String?, price:Double?,fromLoction:LocationRouteModel?,toLocation:LocationRouteModel?, isSelected: Bool) {
        self.id = id
        self.name = name
        self.logo = logo
        self.time = time
        self.price = price
        self.fromLoction = fromLoction
        self.toLocation = toLocation
        self.isSelected = isSelected
    }
}
