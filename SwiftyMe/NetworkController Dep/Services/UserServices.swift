//
//  UserServices.swift
//

import Foundation
import UIKit
import CoreLocation

struct USER_API_NAME {
    static let register = "api/register"
    static let fcm = "api/fcm"
    static let socialRegister = "api/socialRegister"
    static let sendPhoneCode = "api/sendPhoneCode"
    static let loginWithPhone = "api/loginWithPhone"
    static let verifyPhoneCode = "api/verifyPhoneCode"
    static let verifyPhoneCodeWithPhone = "api/verifyPhoneCodeWithPhone"
    static let login = "api/login"
    static let logout = "api/logout"
    static let userUpdate = "api/updateUser"
    static let deleteUser = "api/deleteUser"
    static let getUserProfile = "api/getUserProfile"
    static let forgotPassword = "api/sendEmailForResetPassword"
    static let changePassword = "api/changePassword"
    static let updateForgotPassword = "api/updateForgotPassword"
    static let latlngToAddress = "https://maps.googleapis.com/maps/api/geocode/json"
    
    
}

class UserServices {
    
    private let apiClient = APIClient()
    /*
    func perFormUserLogin(paramDict: [String: String], api:String, completion: @escaping(Result<UserModel,APIError>) -> Void) {
        
        apiClient.executePostRequest(paramDict, api: api) { (result) in
            
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if let data2 = data{
                    if let json = data2.dataToJson(){
                        if let apiStatus = json["success"] as? Bool, apiStatus == true{
                            if let object = UserModel.initWithData(data: data2){
                                UserSession.saveUser(user: object)
                                completion(.success(object))
                            }else{
                                var msg = "Something went wrong"
                                if let errorMsg = json["messagee"] as? String{
                                    msg = errorMsg
                                }
                                completion(.failure(APIError(status: false, error_type: "api", message: msg)))
                            }
                        }else{
                            completion(.failure(APIError.generalError))
                        }
                    }else{
                        completion(.failure(APIError.generalError))
                    }
                }else{
                    completion(.failure(APIError.generalError))
                }
            }
            
        }
    }
    
    func verifyEmail(paramDict: [String: String], api:String, completion: @escaping(Result<(UserModel?, String?, Int),APIError>) -> Void) {
        
        apiClient.executePostRequest(paramDict, api: api) { (result) in
            
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if let data2 = data{
                    if let json = data2.dataToJson(){
                        var msg = "Updated successfully!"
                        var user:UserModel?
                        var alreadyFlag = 0
                        if let val = json["message"] as? String{
                            msg = val
                        }
                        if let val = json["alreadyFlag"]{
                            alreadyFlag = AppUtility.parseFieldForInt(value: val as Any)
                        }
                        if let apiStatus = json["success"] as? Bool, apiStatus == true{
                            if let dataUser = json["data"] as? [String:Any]{
                                if let object = UserModel.initWithDict(result: dataUser){
                                    user = object
                                }
                            }
                            completion(.success((user, msg, alreadyFlag)))
                        }else{
                            completion(.failure(APIError.generalError))
                        }
                    }else{
                        completion(.failure(APIError.generalError))
                    }
                }else{
                    completion(.failure(APIError.generalError))
                }
            }
            
        }
    }
    
    func perFormUserRegister(paramDict: [String: String], api:String, completion: @escaping(Result<UserModel,APIError>) -> Void) {
        
        apiClient.execPostWithAttach(paramDict, imageData: nil, api: api) { (result) in
            
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if let data2 = data{
                    if let json = data2.dataToJson(){
                        if let apiStatus = json["success"] as? Bool, apiStatus == true{
                            if let object = UserModel.initWithData(data: data2){
                                if let value = json["isNew"]{
                                    object.isNew = AppUtility.parseFieldForBool(value: value as Any)
                                }
                                UserSession.saveUser(user: object)
                                UserSession.saveValForKey(value: String(object.type), key: userMode)
                                completion(.success(object))
                            }else{
                                var msg = "Something went wrong"
                                if let errorMsg = json["messagee"] as? String{
                                    msg = errorMsg
                                }
                                completion(.failure(APIError(status: false, error_type: "api", message: msg)))
                            }
                        }else{
                            completion(.failure(APIError.generalError))
                        }
                    }else{
                        completion(.failure(APIError.generalError))
                    }
                }else{
                    completion(.failure(APIError.generalError))
                }
                
            }
            
        }
    }
    
    func isSocialUserExists(paramDict: [String: String], api:String,  completion: @escaping(Result<Bool,APIError>) -> Void) {
        
        apiClient.executePostRequest(paramDict, api: api) { (result) in
            
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if let data2 = data{
                    var isUserExist = false
                    let json = data2.dataToJson()!
                    if let msg = json["isUserExist"] as? Bool {
                        isUserExist = msg
                    }
                    completion(.success(isUserExist))
                }else{
                    completion(.failure(APIError.generalError))
                }
            }
            
        }
        
    }
    
    func getBadges(paramDict: [String: String], api:String, completion: @escaping(Result<[BadgeModel],APIError>) -> Void) {
        apiClient.executePostRequest(paramDict, api: api) { (result) in
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                var badges = [BadgeModel]()
                if let data2 = data{
                    if let json = data2.dataToJson() {
                        if let result = json["data"] as? [[String:Any]] {
                            for item in result{
                                let obj = BadgeModel.initWithData(result: item)
                                badges.append(obj!)
                            }
                        }
                    }
                    UserSession.saveBadges(user: badges)
                    completion(.success(badges))
                    
                }else{
                    completion(.failure(APIError.generalError))
                }
            }
            
        }
    }
    
    func updateBadges(paramDict: [String: String], api:String, completion: @escaping(Result<String,APIError>) -> Void) {
        apiClient.executePostRequest(paramDict, api: api) { (result) in
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if let data2 = data, let json = data2.dataToJson(){
                    let msg = json["message"] as? String ?? ""
                    completion(.success(msg))
                }else{
                    completion(.failure(APIError.generalError))
                }
            }
            
        }
    }
    func sendPhonePinCode(paramDict: [String: String], api:String, completion: @escaping(Result<Data,APIError>) -> Void) {
        
        apiClient.executePostRequest(paramDict, api: api) { (result) in
            
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if let data2 = data{
                    completion(.success(data2))
                }else{
                    completion(.failure(APIError.generalError))
                }
            }
            
        }
    }
    
    func verifyPhonePinCode(paramDict: [String: String], api:String, completion: @escaping(Result<UserModel,APIError>) -> Void) {
        
        apiClient.executePostRequest(paramDict, api: api) { (result) in
            
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if let data2 = data, let object = UserModel.initWithData(data: data2){
                    UserSession.saveUser(user: object)
                    completion(.success(object))
                }else{
                    completion(.failure(APIError.generalError))
                }
            }
            
        }
    }
    
    func updateUserProfile(paramDict: [String: String], api:String, imageData:Data?, completion: @escaping(Result<UserModel,APIError>) -> Void) {
        
        apiClient.execPostWithAttach(paramDict, imageData: imageData, api: api) { (result) in
            
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if let data2 = data{
                    if let json = data2.dataToJson(){
                        if let apiStatus = json["success"] as? Bool, apiStatus == true{
                            if let object = UserModel.initWithData(data: data2){
                                UserSession.saveUser(user: object)
                                completion(.success(object))
                            }else{
                                var msg = "Something went wrong"
                                if let errorMsg = json["messagee"] as? String{
                                    msg = errorMsg
                                }
                                completion(.failure(APIError(status: false, error_type: "api", message: msg)))
                            }
                        }else{
                            completion(.failure(APIError.generalError))
                        }
                    }else{
                        completion(.failure(APIError.generalError))
                    }
                }else{
                    completion(.failure(APIError.generalError))
                }
            }
            
        }
    }
    
    func updateCompaanyInfo(paramDict: [String: String], api:String, imageData:Data?, fieldName:String = "image", completion: @escaping(Result<String,APIError>) -> Void) {
        
        apiClient.execPostWithAttach(paramDict, imageData: imageData, api: api, fieldName:fieldName) { (result) in
            
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if let data2 = data{
                    if let json = data2.dataToJson(){
                        if let apiStatus = json["success"] as? Bool, apiStatus == true{
                            var msg = "Something went wrong"
                            if let errorMsg = json["message"] as? String{
                                msg = errorMsg
                            }
                            completion(.success(msg))
                        }else{
                            completion(.failure(APIError.generalError))
                        }
                    }else{
                        completion(.failure(APIError.generalError))
                    }
                }else{
                    completion(.failure(APIError.generalError))
                }
            }
            
        }
    }
    
    
    func getUserProfile(paramDict: [String: String], api:String, completion: @escaping(Result<UserModel,APIError>) -> Void) {
        
        apiClient.executeGetRequest(paramDict, api: api) { (result) in
            
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if let data2 = data{
                    if let json = data2.dataToJson(){
                        if let apiStatus = json["success"] as? Bool, apiStatus == true{
                            if let object = UserModel.initWithData(data: data2){
                                UserSession.saveUser(user: object)
                                completion(.success(object))
                            }else{
                                var msg = "Something went wrong"
                                if let errorMsg = json["messagee"] as? String{
                                    msg = errorMsg
                                }
                                completion(.failure(APIError(status: false, error_type: "api", message: msg)))
                            }
                        }else{
                            completion(.failure(APIError.generalError))
                        }
                    }else{
                        completion(.failure(APIError.generalError))
                    }
                }else{
                    completion(.failure(APIError.generalError))
                }
            }
            
        }
    }
    func perFormUserLogout(paramDict: [String: String], api:String, completion: @escaping(Result<UserModel,APIError>) -> Void) {
        
        apiClient.executePostRequest(paramDict, api: api) { (result) in
            
            switch result{
            case .failure(let error):
                UserSession.logout()
                completion(.failure(error))
            case .success(let data):
                if let data2 = data, let object = UserModel.initWithData(data: data2){
                    UserSession.logout()
                    completion(.success(object))
                }else{
                    UserSession.logout()
                    completion(.failure(APIError.generalError))
                }
            }
            
        }
    }
    
    func forgotPassword(paramDict: [String: String], api:String, completion: @escaping(Result<String,APIError>) -> Void) {
        
        apiClient.executePostRequest(paramDict, api: api) { (result) in
            
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if let data2 = data{
                    var message = "Sent"
                    let json = data2.dataToJson()!
                    if let msg = json["message"] as? String {
                        message = msg
                    }
                    completion(.success(message))
                }else{
                    completion(.failure(APIError.generalError))
                }
            }
            
        }
    }
    
    func changePassword(paramDict: [String: String], api:String, completion: @escaping(Result<String,APIError>) -> Void) {
        
        apiClient.executePostRequest(paramDict, api: api) { (result) in
            
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if let data2 = data{
                    var message = "Sent"
                    let json = data2.dataToJson()!
                    if let msg = json["message"] as? String {
                        message = msg
                    }
                    completion(.success(message))
                }else{
                    completion(.failure(APIError.generalError))
                }
            }
            
        }
    }
    
    func updateLocation(paramDict: [String: String], api:String, completion: @escaping(Result<String,APIError>) -> Void) {
        
        apiClient.executePostRequest(paramDict, api: api) { (result) in
            
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if let data2 = data{
                    var message = "Sent"
                    let json = data2.dataToJson()!
                    if let msg = json["message"] as? String {
                        message = msg
                    }
                    completion(.success(message))
                }else{
                    completion(.failure(APIError.generalError))
                }
            }
            
        }
    }
    
    func forgotEmail(paramDict: [String: String], api:String, completion: @escaping(Result<String,APIError>) -> Void) {
        
        apiClient.executePostRequest(paramDict, api: api) { (result) in
            
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if let data2 = data{
                    var message = "Sent"
                    let json = data2.dataToJson()!
                    if let msg = json["message"] as? String {
                        message = msg
                    }
                    completion(.success(message))
                }else{
                    completion(.failure(APIError.generalError))
                }
            }
            
        }
    }
    
   */
    
    func execGeneralPost(paramDict: [String: String], api:String, completion: @escaping(Result<String?,APIError>) -> Void) {
        
        apiClient.executePostRequest(paramDict, api: api) { (result) in
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if let data2 = data{
                    if let json = data2.dataToJson(){
                        if let val = json["message"] as? String{
                            completion(.success(val))
                        }else{
                            completion(.failure(APIError.generalError))
                        }
                    }else{
                        completion(.failure(APIError.generalError))
                    }
                }else{
                    completion(.failure(APIError.generalError))
                }
            }
            
        }
    }
    
    
    
    
    func getlatlngToAddress(paramDict: [String: String], api:String, completion: @escaping(Result<(String, String, String), APIError>) -> Void) {
        
        /*
         var toFetchNew = true
         let addressSaved = UserSession.getValForKey(USER_DEFAULT_KEY.CURRENT_ADDRESS)
         if  addressSaved.isEmpty == false{
         if let latlng = paramDict["latlng"]{
         let comp = latlng.components(separatedBy: ",")
         if comp.count > 1{
         let lat = Double(comp[0]) ?? 0.0
         let lng = Double(comp[1]) ?? 0.0
         let distance = LocationsManager.distanceFromCurrentLocationTo(lat: lat, lng: lng)
         if distance < 0.02{
         toFetchNew = false
         }
         }
         }
         }
         if toFetchNew == false{
         completion(.success(addressSaved))
         return
         }*/
        
        apiClient.executeGetExRequest(paramDict, path: api) { (result) in
            
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if let data2 = data, let json = data2.dataToJson(){
                    var address:String = ""
                    var country = ""
                    var city = ""
                    if let dataArray = json["results"] as? [[String:Any]] {
                        if(dataArray.count > 0){
                            let dictValue = dataArray[0]
                            if let name = dictValue["formatted_address"] as? String {
                                address = name
                            }
                            
                        }
                        let (cnt, cit) = AddressModel.getCountryCityName(result: dataArray)
                        country = cnt
                        city = cit
                    }
                    completion(.success((address, country, city)))
                }else{
                    completion(.failure(APIError.generalError))
                }
            }
            
        }
    }
    
    func searchPlacesByKeyword(paramDict: [String: String], lat:Double, lng:Double, keyword:String, completion: @escaping(Result<[AddressModel],APIError>) -> Void) {
        
        var stringURL = String(format:"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&keyword=%@&radius=5000&sensor=false&key=%@&type=pharmacy",lat,lng,keyword,GOOGLE_KEY.GOOGLE_MAP_KEY)
        stringURL = stringURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        apiClient.executeGetExRequest(paramDict, path: stringURL) { (result) in
            
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if let data2 = data, let json = data2.dataToJson(){
                    var address = [AddressModel]()
                    if let dataArray = json["results"] as? [[String:Any]] {
                        for itemData  in dataArray{
                            if let addModel = AddressModel.initWithPointInterest(result: itemData){
                                address.append(addModel)
                            }
                        }
                    }
                    completion(.success(address))
                }else{
                    completion(.failure(APIError.generalError))
                }
            }
            
        }
    }
    
    func searchPharamcies(paramDict: [String: String], lat:Double, lng:Double, keyword:String, completion: @escaping(Result<[AddressModel],APIError>) -> Void) {
        
        var stringURL = String(format:"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&keyword=%@&radius=5000&sensor=false&key=%@&type=pharmacy",lat,lng,keyword,GOOGLE_KEY.GOOGLE_MAP_KEY)
        stringURL = stringURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        apiClient.executeGetExRequest(paramDict, path: stringURL) { (result) in
            
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if let data2 = data, let json = data2.dataToJson(){
                    var address = [AddressModel]()
                    if let dataArray = json["results"] as? [[String:Any]] {
                        for itemData  in dataArray{
                            if let addModel = AddressModel.initWithPointInterest(result: itemData){
                                address.append(addModel)
                            }
                        }
                    }
                    completion(.success(address))
                }else{
                    completion(.failure(APIError.generalError))
                }
            }
            
        }
    }
    
    func getMapRoute(wayPoints: String?, origin:CLLocationCoordinate2D, destination:CLLocationCoordinate2D, completion: @escaping(Result<String?,APIError>) -> Void) {
        
        //var stringURL = String(format:"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&keyword=%@&radius=5000&sensor=false&key=%@&type=pharmacy",lat,lng,keyword,GOOGLE_KEY.GOOGLE_MAP_KEY)
        
        var stringURL = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin.latitude),\(origin.longitude)&destination=\(destination.latitude),\(destination.longitude)&mode=driving&key=\(GOOGLE_KEY.GOOGLE_MAP_KEY)"
        if wayPoints != nil{
            stringURL = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin.latitude),\(origin.longitude)&destination=\(destination.latitude),\(destination.longitude)&mode=driving&waypoints=\(wayPoints!)&key=\(GOOGLE_KEY.GOOGLE_MAP_KEY)"
        }
        stringURL = stringURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        apiClient.executeGetExRequest([:], path: stringURL) { (result) in
            
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if let data2 = data, let json = data2.dataToJson(){
                    var path:String?
                    if let routesArray = json["routes"] as? [[String:Any]] {
                        if let itemData = routesArray.first{
                            if let overview_polyline = itemData["overview_polyline"] as? [String:Any] {
                                if let pathV = overview_polyline["points"] as? String {
                                    path = pathV
                                }
                            }
                        }
                    }
                    completion(.success(path))
                }else{
                    completion(.failure(APIError.generalError))
                }
            }
            
        }
    }

}

