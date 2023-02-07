//
//  LocationRouteModel.swift
//  SwiftyMe
//
//  Created by MacBook on 02/02/2023.
//

import Foundation
struct LocationRouteModel:Identifiable, Codable{
    let id:String
    let name:String?
    let shortCode:String?
    var isSelected:Bool = false
    
    init(id: String, name: String?, shortCode:String?, isSelected: Bool) {
        self.id = id
        self.name = name
        self.shortCode = shortCode
        self.isSelected = isSelected
    }
}
