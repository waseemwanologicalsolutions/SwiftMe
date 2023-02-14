//
//  BusFacilityModel.swift
//  SwiftyMe
//
//  Created by MacBook on 14/02/2023.
//

import Foundation
struct BusFacilityModel:Identifiable, Codable, Hashable{
    let id:String
    let name:String?
    let icon:String?
    
    init(id: String = UUID().uuidString, name: String?, icon:String?) {
        self.id = id
        self.name = name
        self.icon = icon
    }
}
