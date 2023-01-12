//
//  AddressModel.swift
//  TripCon
//
//  Created by MacBook on 22/12/2021.
//

import Foundation
import GooglePlaces
import SwiftUI

class AddressModel: Codable, ObservableObject {
    var id: Int
    var address,mapLocation: String
    var name: String?
    var lat, lng: Double
    var isRestAddress:Bool
    var landmark:String?
    var building:String?
    var apartment:String?
    var country:String?
    var city:String?
    var type:String?
    var distance:Double = 0
    var placeId:String?
    var iconTxt, image:String?
    
    enum CodingKeys: String, CodingKey {
        case id, address, mapLocation
        case lat, lng
        case name = "type"
        case isRestAddress
        case landmark = "landMark"
        case building = "buildingName"
        case apartment
        case country, city, distance
        case placeId, iconTxt, image
    }

    init(id: Int = 0, address: String = "", lat: Double = 0, lng: Double = 0, name:String? = nil, mapLocation:String = "", isRestAddress:Bool = false, landmark:String? = nil, building:String? = nil, apartment:String? = nil, houseNo:String? = nil) {
        self.id = id
        self.address = address
        self.lat = lat
        self.lng = lng
        self.name = name
        self.mapLocation = mapLocation
        self.isRestAddress = isRestAddress
        self.landmark = landmark
        self.building = building
        self.apartment = apartment
        
    }
    
    class func initWithData(result:[String:Any]) -> AddressModel{
        
        let model = AddressModel(id: 0)
        if let value = result[CodingKeys.id.stringValue]{
            model.id = AppUtility.parseFieldForInt(value: value as Any)
        }
        if let value = result[CodingKeys.lat.stringValue]{
            model.lat = AppUtility.parseFieldForDouble(value: value as Any)
        }
        if let value = result[CodingKeys.lng.stringValue]{
            model.lng = AppUtility.parseFieldForDouble(value: value as Any)
        }
        if let value = result[CodingKeys.name.stringValue]{
            model.name = AppUtility.parseFieldForString(value: value as Any)
        }
        if let value = result[CodingKeys.address.stringValue]{
            model.address = AppUtility.parseFieldForString(value: value as Any).trimCharacterNLineSpace()
        }
        if let value = result["location"]{
            model.address = AppUtility.parseFieldForString(value: value as Any).trimCharacterNLineSpace()
        }
        if let value = result[CodingKeys.mapLocation.stringValue]{
            model.mapLocation = AppUtility.parseFieldForString(value: value as Any)
        }
        if let value = result[CodingKeys.landmark.stringValue]{
            model.landmark = AppUtility.parseFieldForString(value: value as Any)
        }
        if let value = result[CodingKeys.building.stringValue]{
            model.building = AppUtility.parseFieldForString(value: value as Any)
        }
        if let value = result[CodingKeys.apartment.stringValue]{
            model.apartment = AppUtility.parseFieldForString(value: value as Any)
        }
        if let value = result[CodingKeys.country.stringValue]{
            model.country = AppUtility.parseFieldForString(value: value as Any)
        }
        if let value = result[CodingKeys.city.stringValue]{
            model.city = AppUtility.parseFieldForString(value: value as Any)
        }
        if let value = result["type"]{
            model.type = AppUtility.parseFieldForString(value: value as Any)
        }
        if let value = result["title"]{
            model.name = AppUtility.parseFieldForString(value: value as Any)
        }
        if let value = result[CodingKeys.distance.stringValue]{
            model.distance = AppUtility.parseFieldForDouble(value: value as Any)
        }
        if model.address.isEmpty || model.address == " "{
            if let val = model.city, val.isEmpty == false{
                model.address.append(val)
            }
            if let val = model.country{
                if model.address.isEmpty == false{
                    model.address.append(", ")
                }
                model.address.append(val)
            }
        }
        
        return model
    }
    
    class func initWithDataDecodeable(data:Data) -> AddressModel?{
        
        if let json = data.dataToJson() {

            var user:AddressModel?
            if let result = json["result"] as? [String:Any] {
                
                if let resultData = AppUtility.jsonToData(result: result) {
                                   
                   user = try? JSONDecoder().decode(AddressModel.self, from: resultData)
                                   
                }
                
            }
            return user
        }else{
            
            return nil
        }
    }
    
    class func initWithPointInterest(result:[String:Any]) -> AddressModel?{
        
        let model = AddressModel(id: 0)
        if let geometryDict = result["geometry"] as? [String:Any]{
            if let locationDict = geometryDict["location"] as? [String:Any]{
                if let value = locationDict["lat"]{
                    model.lat = AppUtility.parseFieldForDouble(value: value as Any)
                }
                if let value = locationDict["lat"]{
                    model.lat = AppUtility.parseFieldForDouble(value: value as Any)
                }
                if let value = locationDict["lng"]{
                    model.lng = AppUtility.parseFieldForDouble(value: value as Any)
                }
            }
        }
        if let value = result["name"]{
            model.name = AppUtility.parseFieldForString(value: value as Any)
        }
        if let value = result["vicinity"]{
            model.address = AppUtility.parseFieldForString(value: value as Any)
        }
        return model
    }
    
    class func getCountryCityName(result:[[String:Any]]) -> (String, String){
        
        var countryName = ""
        var cityName = ""
        for item in result{
            if AddressModel.countryNameFromComponentsTypeCountry(item).isEmpty == false && countryName.isEmpty == true{
                countryName = AddressModel.countryNameFromComponentsTypeCountry(item)
            }else if AddressModel.countryNameFromComponentsTypePolitical(item).isEmpty == false && countryName.isEmpty == true{
                countryName = AddressModel.countryNameFromComponentsTypePolitical(item)
            }
            
            if AddressModel.cityNameFromComponentsTypeSublocality_level_1(item).isEmpty == false && cityName.isEmpty == true{
                cityName = AddressModel.cityNameFromComponentsTypeAdministrative_area_level_2(item)
            }else if AddressModel.cityNameFromComponentsTypeAdministrative_area_level_5(item).isEmpty == false && cityName.isEmpty == true{
                cityName = AddressModel.cityNameFromComponentsTypeAdministrative_area_level_1(item)
            }else if AddressModel.cityNameFromComponentsTypeAdministrative_area_level_2(item).isEmpty == false && cityName.isEmpty == true{
                cityName = AddressModel.cityNameFromComponentsTypeAdministrative_area_level_3(item)
            }else if AddressModel.cityNameFromComponentsTypeAdministrative_area_level_3(item).isEmpty == false && cityName.isEmpty == true{
                cityName = AddressModel.cityNameFromComponentsTypeAdministrative_area_level_4(item)
            }else if AddressModel.cityNameFromComponentsTypeAdministrative_area_level_4(item).isEmpty == false && cityName.isEmpty == true{
                cityName = AddressModel.cityNameFromComponentsTypeAdministrative_area_level_5(item)
            }
        }
        return (countryName, cityName)
    }
    class func countryNameFromComponentsTypeCountry(_ item:[String:Any])->String{
        var countryName = ""
        if let address_components = item["address_components"] as? [[String:Any]]{
            for item2  in address_components{
                if let long_name = item2["long_name"] as? String{
                    if let types = item2["types"] as? [String]{
                        for item3 in types{
                            if item3 == "country"{
                                countryName = long_name
                            }
                        }
                    }
                }
            }
        }
        return countryName
    }
    class func countryNameFromComponentsTypePolitical(_ item:[String:Any])->String{
        var countryName = ""
        if let address_components = item["address_components"] as? [[String:Any]]{
            for item2  in address_components{
                if let long_name = item2["long_name"] as? String{
                    if let types = item2["types"] as? [String]{
                        for item3 in types{
                            if item3 == "political"{
                                countryName = long_name
                            }
                        }
                    }
                }
            }
        }
        return countryName
    }
    class func cityNameFromComponentsTypeSublocality_level_1(_ item:[String:Any])->String{
        var countryName = ""
        if let address_components = item["address_components"] as? [[String:Any]]{
            for item2  in address_components{
                if let long_name = item2["long_name"] as? String{
                    if let types = item2["types"] as? [String]{
                        for item3 in types{
                            if item3 == "sublocality_level_1"{
                                countryName = long_name
                            }
                        }
                    }
                }
            }
        }
        return countryName
    }
    class func cityNameFromComponentsTypeAdministrative_area_level_5(_ item:[String:Any])->String{
        var countryName = ""
        if let address_components = item["address_components"] as? [[String:Any]]{
            for item2  in address_components{
                if let long_name = item2["long_name"] as? String{
                    if let types = item2["types"] as? [String]{
                        for item3 in types{
                            if item3 == "administrative_area_level_5"{
                                countryName = long_name
                            }
                        }
                    }
                }
            }
        }
        return countryName
    }
    class func cityNameFromComponentsTypeAdministrative_area_level_4(_ item:[String:Any])->String{
        var countryName = ""
        if let address_components = item["address_components"] as? [[String:Any]]{
            for item2  in address_components{
                if let long_name = item2["long_name"] as? String{
                    if let types = item2["types"] as? [String]{
                        for item3 in types{
                            if item3 == "administrative_area_level_4"{
                                countryName = long_name
                            }
                        }
                    }
                }
            }
        }
        return countryName
    }
    class func cityNameFromComponentsTypeAdministrative_area_level_3(_ item:[String:Any])->String{
        var countryName = ""
        if let address_components = item["address_components"] as? [[String:Any]]{
            for item2  in address_components{
                if let long_name = item2["long_name"] as? String{
                    if let types = item2["types"] as? [String]{
                        for item3 in types{
                            if item3 == "administrative_area_level_3"{
                                countryName = long_name
                            }
                        }
                    }
                }
            }
        }
        return countryName
    }
    class func cityNameFromComponentsTypeAdministrative_area_level_2(_ item:[String:Any])->String{
        var countryName = ""
        if let address_components = item["address_components"] as? [[String:Any]]{
            for item2  in address_components{
                if let long_name = item2["long_name"] as? String{
                    if let types = item2["types"] as? [String]{
                        for item3 in types{
                            if item3 == "administrative_area_level_2"{
                                countryName = long_name
                            }
                        }
                    }
                }
            }
        }
        return countryName
    }
    class func cityNameFromComponentsTypeAdministrative_area_level_1(_ item:[String:Any])->String{
        var countryName = ""
        if let address_components = item["address_components"] as? [[String:Any]]{
            for item2  in address_components{
                if let long_name = item2["long_name"] as? String{
                    if let types = item2["types"] as? [String]{
                        for item3 in types{
                            if item3 == "administrative_area_level_1"{
                                countryName = long_name
                            }
                        }
                    }
                }
            }
        }
        return countryName
    }

    class func getCountryCityName(item:[GMSAddressComponent]) -> (String, String){
        
        var countryName = ""
        var cityName = ""
        if AddressModel.countryNameFromComponentsTypeCountry(item).isEmpty == false && countryName.isEmpty == true{
            countryName = AddressModel.countryNameFromComponentsTypeCountry(item)
        }else if AddressModel.countryNameFromComponentsTypePolitical(item).isEmpty == false && countryName.isEmpty == true{
            countryName = AddressModel.countryNameFromComponentsTypePolitical(item)
        }
        
        if AddressModel.cityNameFromComponentsTypeSublocality_level_1(item).isEmpty == false && cityName.isEmpty == true{
            cityName = AddressModel.cityNameFromComponentsTypeAdministrative_area_level_2(item)
        }else if AddressModel.cityNameFromComponentsTypeAdministrative_area_level_5(item).isEmpty == false && cityName.isEmpty == true{
            cityName = AddressModel.cityNameFromComponentsTypeAdministrative_area_level_1(item)
        }else if AddressModel.cityNameFromComponentsTypeAdministrative_area_level_2(item).isEmpty == false && cityName.isEmpty == true{
            cityName = AddressModel.cityNameFromComponentsTypeAdministrative_area_level_3(item)
        }else if AddressModel.cityNameFromComponentsTypeAdministrative_area_level_3(item).isEmpty == false && cityName.isEmpty == true{
            cityName = AddressModel.cityNameFromComponentsTypeAdministrative_area_level_4(item)
        }else if AddressModel.cityNameFromComponentsTypeAdministrative_area_level_4(item).isEmpty == false && cityName.isEmpty == true{
            cityName = AddressModel.cityNameFromComponentsTypeAdministrative_area_level_5(item)
        }
        return (countryName, cityName)
    }
    class func countryNameFromComponentsTypeCountry(_ address_components:[GMSAddressComponent])->String{
        var countryName = ""
        for item2  in address_components{
            for item3 in item2.types{
                if item3 == "country"{
                    countryName = item2.name
                }
            }
        }
        return countryName
    }
    class func countryNameFromComponentsTypePolitical(_ address_components:[GMSAddressComponent])->String{
        var countryName = ""
        for item2  in address_components{
            for item3 in item2.types{
                if item3 == "political"{
                    countryName = item2.name
                }
            }
        }
        return countryName
    }
    class func cityNameFromComponentsTypeSublocality_level_1(_ address_components:[GMSAddressComponent])->String{
        var countryName = ""
        for item2  in address_components{
            for item3 in item2.types{
                if item3 == "sublocality_level_1"{
                    countryName = item2.name
                }
            }
        }
        return countryName
    }
    class func cityNameFromComponentsTypeAdministrative_area_level_5(_ address_components:[GMSAddressComponent])->String{
        var countryName = ""
        for item2  in address_components{
            for item3 in item2.types{
                if item3 == "administrative_area_level_5"{
                    countryName = item2.name
                }
            }
        }
        return countryName
    }
    class func cityNameFromComponentsTypeAdministrative_area_level_4(_ address_components:[GMSAddressComponent])->String{
        var countryName = ""
        for item2  in address_components{
            for item3 in item2.types{
                if item3 == "administrative_area_level_4"{
                    countryName = item2.name
                }
            }
        }
        return countryName
    }
    class func cityNameFromComponentsTypeAdministrative_area_level_3(_ address_components:[GMSAddressComponent])->String{
        var countryName = ""
        for item2  in address_components{
            for item3 in item2.types{
                if item3 == "administrative_area_level_3"{
                    countryName = item2.name
                }
            }
        }
        return countryName
    }
    class func cityNameFromComponentsTypeAdministrative_area_level_2(_ address_components:[GMSAddressComponent])->String{
        var countryName = ""
        for item2  in address_components{
            for item3 in item2.types{
                if item3 == "administrative_area_level_2"{
                    countryName = item2.name
                }
            }
        }
        return countryName
    }
    class func cityNameFromComponentsTypeAdministrative_area_level_1(_ address_components:[GMSAddressComponent])->String{
        var countryName = ""
        for item2  in address_components{
            for item3 in item2.types{
                if item3 == "administrative_area_level_1"{
                    countryName = item2.name
                }
            }
        }
        return countryName
    }
}
