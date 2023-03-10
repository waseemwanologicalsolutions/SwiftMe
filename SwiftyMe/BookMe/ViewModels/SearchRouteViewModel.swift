//
//  SearchRouteViewModel.swift
//  SwiftyMe
//
//  Created by MacBook on 24/01/2023.
//

import Foundation
import SwiftUI

class SearchRouteViewModel:ObservableObject{
    
    @Published var fieldFromLocation: String = ""
    @Published var fieldToLocation: String = ""
    
    @Published var showDatePicker:Bool = false
    @Published var dateComponents:DatePickerComponents = .date
    @Published var showServiceScreen = false
    @Published var showResultsScreen = false
    
    @Published var selectedService:SericeModel?
    @Published var selectedLocationFrom:LocationRouteModel?
    @Published var selectedLocationTo:LocationRouteModel?
    @Published var showSourceDestinationScreen:Bool = false
    @Published var isSourceLocationSelectting:Bool = true
    @Published var selectedDate:Date = Date()
}
