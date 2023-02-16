//
//  SeatModel.swift
//  SwiftyMe
//
//  Created by MacBook on 16/02/2023.
//

import Foundation
struct SeatModel:Identifiable, Codable, Hashable{
    var id:String
    let name:String?
    var gender:String?
    var isSelected:Bool
    let isReserved:Bool
    
}
