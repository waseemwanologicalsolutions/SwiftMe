//
//  ReelsModel.swift
//  SwiftyMe
//
//  Created by MacBook on 30/03/2023.
//

import Foundation
struct ReelsModel:Codable, Identifiable{
    var id:String
    var url:String?
    var location:String?
    var caption:String?
    var votes:Int?
    var autherName:String?
    var autherPhoto:String?
    var tag:Int
}
