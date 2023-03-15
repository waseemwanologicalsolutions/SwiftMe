//
//  NSMutableData+Extension.swift
//  SwiftyMe
//
//  Created by MacBook on 14/03/2023.
//

import Foundation
extension NSMutableData {
  func appendString(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}
