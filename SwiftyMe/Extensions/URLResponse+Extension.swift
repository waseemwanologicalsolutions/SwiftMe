//
//  URLResponse+Extension.swift
//  SwiftyMe
//
//  Created by MacBook on 14/03/2023.
//

import Foundation
extension URLResponse {
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
