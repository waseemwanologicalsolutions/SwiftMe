//
//  SeatSelectionViewModel.swift
//  SwiftyMe
//
//  Created by MacBook on 15/02/2023.
//

import SwiftUI

class SeatSelectionViewModel:ObservableObject{
    
    @Published var seats:[SeatModel] = []
    @Published var seatsSelected:[SeatModel] = []
    @Published var showGenderTypeSelection = false
    @Published var seatCurrentSelection:SeatModel?
    
}

class SeatSelectionViewModelData{
    static func initData()->[SeatModel]{
        var arry = [SeatModel]()
        arry.append(SeatModel(id: UUID().uuidString, name: "1", gender: "", isSelected: false, isReserved: false))
        arry.append(SeatModel(id: UUID().uuidString, name: "2", gender: "", isSelected: false, isReserved: false))
        arry.append(SeatModel(id: UUID().uuidString, name: "3", gender: "", isSelected: false, isReserved: false))
        arry.append(SeatModel(id: UUID().uuidString, name: "4", gender: "", isSelected: false, isReserved: false))
        arry.append(SeatModel(id: UUID().uuidString, name: "5", gender: "", isSelected: false, isReserved: false))
        arry.append(SeatModel(id: UUID().uuidString, name: "6", gender: "", isSelected: false, isReserved: false))
        arry.append(SeatModel(id: UUID().uuidString, name: "7", gender: "", isSelected: false, isReserved: false))
        arry.append(SeatModel(id: UUID().uuidString, name: "8", gender: "", isSelected: false, isReserved: false))
        arry.append(SeatModel(id: UUID().uuidString, name: "9", gender: "", isSelected: false, isReserved: false))
        arry.append(SeatModel(id: UUID().uuidString, name: "10", gender: "", isSelected: false, isReserved: false))
        arry.append(SeatModel(id: UUID().uuidString, name: "11", gender: "", isSelected: false, isReserved: false))
        arry.append(SeatModel(id: UUID().uuidString, name: "12", gender: "", isSelected: false, isReserved: false))
        arry.append(SeatModel(id: UUID().uuidString, name: "13", gender: "", isSelected: false, isReserved: false))
        arry.append(SeatModel(id: UUID().uuidString, name: "14", gender: "", isSelected: false, isReserved: false))
        arry.append(SeatModel(id: UUID().uuidString, name: "15", gender: "", isSelected: false, isReserved: false))
        arry.append(SeatModel(id: UUID().uuidString, name: "16", gender: "", isSelected: false, isReserved: false))
        arry.append(SeatModel(id: UUID().uuidString, name: "17", gender: "", isSelected: false, isReserved: false))
        arry.append(SeatModel(id: UUID().uuidString, name: "18", gender: "", isSelected: false, isReserved: false))
        arry.append(SeatModel(id: UUID().uuidString, name: "19", gender: "", isSelected: false, isReserved: false))
        arry.append(SeatModel(id: UUID().uuidString, name: "20", gender: "", isSelected: false, isReserved: false))
        arry.append(SeatModel(id: UUID().uuidString, name: "21", gender: "", isSelected: false, isReserved: false))
        arry.append(SeatModel(id: UUID().uuidString, name: "22", gender: "", isSelected: false, isReserved: false))
        arry.append(SeatModel(id: UUID().uuidString, name: "23", gender: "", isSelected: false, isReserved: false))
        arry.append(SeatModel(id: UUID().uuidString, name: "24", gender: "", isSelected: false, isReserved: false))
        
        return arry
    }
}
