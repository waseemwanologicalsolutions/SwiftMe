//
//  SericeModel.swift
//  SwiftyMe
//
//  Created by MacBook on 25/01/2023.
//

import Foundation
struct SericeModel:Identifiable, Codable{
    let id:String
    let name:String?
    let discount:String?
    var isSelected:Bool = false
    
    init(id: String, name: String?, discount:String?, isSelected: Bool) {
        self.id = id
        self.name = name
        self.discount = discount
        self.isSelected = isSelected
    }
}
