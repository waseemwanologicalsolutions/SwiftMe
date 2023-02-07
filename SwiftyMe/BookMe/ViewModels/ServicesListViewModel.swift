//
//  ServicesListViewModel.swift
//  SwiftyMe
//
//  Created by MacBook on 25/01/2023.
//

import Foundation
import SwiftUI


class ServicesListViewModel:ObservableObject{
    
    @Published var services:[SericeModel] = []
    @Published var fieldToLocation: String = ""
    
    @Published var showDatePicker:Bool = false
    @Published var dateComponents:DatePickerComponents = .date
    @Published var showServiceScreen = false
    
}

class ServiceListViewModelData{
    static func initServicesList()->[SericeModel]{
        //let array = Array(repeating: SericeModel(id: UUID().uuidString, name: "Daewoo bus service Pakistan", discount: "30 % off", isSelected: false), count: 20)
        var array = [SericeModel]()
        array.append(SericeModel(id: UUID().uuidString, name: "Daewoo bus service Pakistan", discount: "30 % off", isSelected: false))
        array.append(SericeModel(id: UUID().uuidString, name: "Skywase bus service Pakistan", discount: "10 % off", isSelected: false))
        array.append(SericeModel(id: UUID().uuidString, name: "Rana bus service Pakistan", discount: "10 % off", isSelected: false))
        array.append(SericeModel(id: UUID().uuidString, name: "Balooch bus service Pakistan", discount: "10 % off", isSelected: false))
        array.append(SericeModel(id: UUID().uuidString, name: "Malik bus service Pakistan", discount: "10 % off", isSelected: false))
        return array
    }
}
