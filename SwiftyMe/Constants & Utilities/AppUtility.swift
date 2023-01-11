//
//  AppUtility.swift
//


import Foundation
import UIKit
import LocalAuthentication
import CommonCrypto

class AppUtility: NSObject{
   
    public typealias SuccessHandler = (String) -> Void
    public typealias FailureHandler = (String) -> Void
    
    class public func authWithBiometric(reason:String, successHandler: @escaping SuccessHandler, failureHandler: @escaping FailureHandler) {
        
        var isEnabledFaceId = false
        if let val = UserDefaults.standard.value(forKey: "faceIdEnable") as? Bool{
            isEnabledFaceId = val
        }
        if isEnabledFaceId{
            let context = LAContext()
            context.localizedCancelTitle = "Enter Email & Password"
            //context.localizedFallbackTitle = "Enter Password"
            // First check if we have the needed hardware support.
            var error: NSError?
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in
                    if success {
                        // Move to the main thread because a state update triggers UI changes.
                        DispatchQueue.main.async {
                            successHandler("success")
                        }
                    } else {
                        DispatchQueue.main.async {
                            failureHandler(error?.localizedDescription ?? "Failed to authenticate")
                        }
                    }
                }
            }else {
                DispatchQueue.main.async {
                    failureHandler(error?.localizedDescription ?? "Can't evaluate policy")
                }
            }
        }else{
            DispatchQueue.main.async {
                failureHandler("Face ID not enabled by user")
            }
        }

        
    }
    class func  anyObjectTypeToDouble (obj:AnyObject) -> Double {
        
        if obj is NSDecimalNumber
        {
            let valueInt:NSDecimalNumber! = (obj as? NSDecimalNumber)!
            
            return Double(truncating: valueInt)
        }
        else if obj is Double
        {
            let valueInt:Double! = (obj as? Double)!
            
            return valueInt
        }
        else if obj is Float
        {
            let valueInt:Float! = (obj as? Float)!
            
            return Double (valueInt)
        }
        else if obj is NSNumber
        {
            let valueInt:Double! = Double(truncating: obj as? NSNumber ?? 0)
            
            return valueInt
        }
        else if obj is Int {
            
            let valueInt:Int = (obj as? Int)!
            return Double (valueInt)
        }
        else if obj is String {
            
            return Double(obj as! String) ?? 0.0
            
        }
        else if(obj is NSNull)
        {
            return 0
        }
        else
        {
            let valueInt:Double! = Double(obj as? String ?? "") ?? 0
            
            return valueInt
        }
    }

    class func anyObjectTypeToInt (obj:AnyObject) -> Int {
        
        //print("obj=",obj)
        if obj is Int {
            
            let valueInt:Int = (obj as? Int)!
            return valueInt
        }
        else if obj is NSNumber
        {
            let valueInt:Int! = Int(truncating: obj as? NSNumber ?? 0)
            
            return valueInt
        }
        else if obj is String {
            
            return Int(obj as! String) ?? 0
            
        }
        else if(obj is NSNull)
        {
            return 0
        }
        else
        {
            let strValue:String! = obj as? String
            let valueInt:Int! = Int(strValue!) ?? 0
            
            return valueInt
        }
    }
    
    class func parseFieldForString(value:Any) -> String{
        
        if let value = value as? String{
            return value
        }
        if let value = value as? Int{
            return String(value)
        }
        if let value = value as? Double{
            return String(value)
        }
        if let value = value as? CGFloat{
            let db = Double(value)
            return String(db)
        }
        if let value = value as? Bool{
            if value{
                return ""
            }
            return ""
        }
        return ""
    }
    
    class func parseFieldForDouble(value:Any) -> Double{
        
        if let value = value as? String{
            return Double(value) ?? 0
        }
        if let value = value as? Int{
            return Double(value)
        }
        if let value = value as? Double{
            return value
        }
        if let value = value as? CGFloat{
            return Double(value)
        }
        if let value = value as? Bool{
            if value{
                return 1
            }
            return 0
        }
        return 0
    }
    
    class func parseFieldForInt(value:Any) -> Int{
        
        if let value = value as? String{
            return Int(value) ?? 0
        }
        if let value = value as? Int{
            return value
        }
        if let value = value as? Double{
            return Int(value)
        }
        if let value = value as? CGFloat{
            return Int(value)
        }
        if let value = value as? Bool{
            if value{
                return 1
            }
            return 0
        }
        return 0
    }
    
    class func parseFieldForBool(value:Any) -> Bool{
        
        var va = 0
        if let value = value as? String{
            if value == "true"{
                va = 1
            }else{
                va = Int(value) ?? 0
            }
        }
        if let value = value as? Int{
            va = value
        }
        if let value = value as? Double{
            va = Int(value)
        }
        if let value = value as? CGFloat{
            va = Int(value)
        }
        if let value = value as? Bool{
            return value
        }
        if va == 1{
            return true
        }else{
            return false
        }

    }
    
    class func jsonToData(result:[String: Any]) -> Data?{
        
        return try? JSONSerialization.data(withJSONObject:result)
    }
    class func jsonToData(result:[[String: Any]]) -> Data?{
        
        return try? JSONSerialization.data(withJSONObject:result)
    }
    class func jsonToData(result:[String]) -> Data?{
        
        return try? JSONSerialization.data(withJSONObject:result)
    }
    class func jsonToData(result:[Int]) -> Data?{
        
        return try? JSONSerialization.data(withJSONObject:result)
    }
    class func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    class func checkFileExisits(path:String) -> Bool{
        let url = self.getPathForFile(file: path)
        if (FileManager.default.fileExists(atPath: url.path))   {
            print("FILE AVAILABLE")
            return true
        }else        {
            print("FILE NOT AVAILABLE")
            return false
        }
    }
    class func getPathForFile(file:String) -> URL{
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documents.appendingPathComponent(file)
        return url
    }
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    class func documentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
        
    }
    
    class func fileUrl(filename:String) -> URL {
        
        let filename = "\(filename)"
        let filePath = documentsDirectory().appendingPathComponent(filename)
        return filePath
    }

}

