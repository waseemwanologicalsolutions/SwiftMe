//
//  SubmitEntrySceneViewModel.swift
//  SwiftyMe
//
//  Created by MacBook on 03/04/2023.
//

import Foundation
class SubmitEntrySceneViewModel:ObservableObject{
    @Published var isLoading:Bool = false
    @Published var isAPICall:Bool = false
    @Published var showAlert: Bool = false
    @Published var errorMsg: String = ""
    @Published var errorMsgTitle: String = ""
    @Published var activeAlert: ActiveAlert = .error
    
    @Published var tfName:String = ""
    @Published var tfPhone:String = ""
    @Published var tfCaption:String = ""
    @Published var tfLocation:String = ""
    @Published var showVideoSelection = false
}
