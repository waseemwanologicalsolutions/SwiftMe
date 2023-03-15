//
//  APIError.swift
//


import Foundation
struct APIError : Codable,Error {
    let status : Bool
    let error_type : String
    let message : String
    var numberOfTry:Int?
    
    static var generalError : APIError {
        return APIError.init(status: false, error_type: "General", message: "Something went Wrong", numberOfTry:0)
    }
}
