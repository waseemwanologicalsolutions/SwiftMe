//
//  APIClient.swift
//

import Foundation

enum APPHTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

class APIClient {
    
    
    func executeGetGenRequest(_ paramDict: [String: String], api:String, completion: @escaping (Result<Data?, APIError>) -> Void) {
        
        var paramString = ""
        for key in paramDict{
            print(key.key)
            paramString.append(key.key)
            paramString.append("=")
            paramString.append(key.value)
            paramString.append("&")
        }
        let serviceUrl = URL(string: APP_URL.API + api + "?" + paramString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        print(serviceUrl)
       
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        /*
        if let apiToken = UserSession.getUser()?.apiToken{
            request.setValue("Bearer " + apiToken, forHTTPHeaderField: "Authorization")
        }*/
    
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in

            #if DEBUG
            if let dataV = data {
                if let str = String(data: dataV, encoding: .utf8){
                    print("response=",str)
                }
            }
            #endif
            
            if error != nil {
                completion(.failure(APIError(status: false, error_type: "Server Error", message: error!.localizedDescription)))
            }else{
                if let statusCode = response?.getStatusCode(), (statusCode == 200 || statusCode == 201){
                    completion(.success(data))
                }else{
                    completion(.failure(APIError(status: false, error_type: "Server Error", message: self.getResponseMessage(data))))
                }
            }
            
        })
        task.resume()
    }
    
    func executeGetRequest(_ paramDict: [String: String], api:String, completion: @escaping (Result<Data?, APIError>) -> Void) {
        
        var paramString = ""
        for key in paramDict{
            print(key.key)
            paramString.append(key.key)
            paramString.append("=")
            paramString.append(key.value)
            paramString.append("&")
        }
        var serviceUrl = URL(string: APP_URL.API + api + "?" + paramString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        if paramString.isEmpty{
            serviceUrl = URL(string: APP_URL.API + api)!
        }
        print(serviceUrl)
       
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        /*
        if let apiToken = UserSession.getUser()?.apiToken{
            request.setValue("Bearer " + apiToken, forHTTPHeaderField: "Authorization")
        }*/
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            #if DEBUG
            if let dataV = data {
                if let str = String(data: dataV, encoding: .utf8){
                    print("response=", api, str)
                    
                }
            }
            #endif
            
            if error != nil {
                completion(.failure(APIError(status: false, error_type: "Server Error", message: error!.localizedDescription)))
            }else{
                if let statusCode = response?.getStatusCode(), (statusCode == 200 || statusCode == 201){
                    completion(.success(data))
                }else{
                    completion(.failure(APIError(status: false, error_type: "Server Error", message: self.getResponseMessage(data))))
                }
            }
            
        })
        task.resume()
    }
    
    func executeGetExRequest(_ paramDict: [String: String], path:String, completion: @escaping (Result<Data?, APIError>) -> Void) {
        
        var paramString = ""
        for key in paramDict{
            print(key.key)
            paramString.append(key.key)
            paramString.append("=")
            paramString.append(key.value)
            paramString.append("&")
        }
        var serviceUrl = URL(string: path + "?" + paramString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        if paramString.isEmpty{
            serviceUrl = URL(string: path + paramString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        }
        print(serviceUrl)
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        /*
        if let apiToken = UserSession.getUser()?.apiToken{
            request.setValue("Bearer " + apiToken, forHTTPHeaderField: "Authorization")
        }
        */
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
           
            #if DEBUG
            if let dataV = data {
                if let str = String(data: dataV, encoding: .utf8){
                    print("response=", path,str)
                }
            }
            #endif
            
            if error != nil {
                completion(.failure(APIError(status: false, error_type: "Server Error", message: error!.localizedDescription)))
            }else{
                
                completion(.success(data))
            }
            
        })
        task.resume()
    }
    
    func executePostRequest(_ paramDict: [String: String], api:String, completion: @escaping (Result<Data?, APIError>) -> Void) {
        
        let serviceUrl = URL(string: APP_URL.API + api)!
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        /*
        if let apiToken = UserSession.getUser()?.apiToken{
            request.setValue("Bearer " + apiToken, forHTTPHeaderField: "Authorization")
        }*/
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.addValue("application/json", forHTTPHeaderField: "Accept")
        print("URL=",serviceUrl.absoluteString)
        print("Params=",paramDict)
        //let postString = self.getPostString(params: paramDict)
        //request.httpBody = postString.data(using: .utf8)
        
        let httpBody = NSMutableData()
        for (key, value) in paramDict {
            httpBody.appendString(self.convertFormField(named: key, value: value, using: boundary))
        }
        request.httpBody = httpBody as Data
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
           
            #if DEBUG
            if let dataV = data {
                if let str = String(data: dataV, encoding: .utf8){
                    print("response=", api ,str)
                }
            }
            #endif
            
            if error != nil {
                completion(.failure(APIError(status: false, error_type: "Server Error", message: error!.localizedDescription)))
            }else{
                if let statusCode = response?.getStatusCode(), (statusCode == 200 || statusCode == 201){
                    completion(.success(data))
                }else{
                    completion(.failure(APIError(status: false, error_type: "Server Error", message: self.getResponseMessage(data))))
                }
            }
        })
        task.resume()
    }
    
    func executePostRequestFields(_ paramDict: [String: String], api:String, completion: @escaping (Result<Data?, APIError>) -> Void) {
        
        let serviceUrl = URL(string: APP_URL.API + api)!
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        /*
        if let apiToken = UserSession.getUser()?.apiToken{
            request.setValue("Bearer " + apiToken, forHTTPHeaderField: "Authorization")
        }*/
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.addValue("application/json", forHTTPHeaderField: "Accept")
        print("URL=",serviceUrl.absoluteString)
        print("Params=",paramDict)
        let postString = self.getPostString(params: paramDict)
        request.httpBody = postString.data(using: .utf8)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
           
            #if DEBUG
            if let dataV = data {
                if let str = String(data: dataV, encoding: .utf8){
                    print("response=", api,str)
                }
            }
            #endif
            
            if error != nil {
                completion(.failure(APIError(status: false, error_type: "Server Error", message: error!.localizedDescription)))
            }else{
                if let statusCode = response?.getStatusCode(), (statusCode == 200 || statusCode == 201){
                    completion(.success(data))
                }else{
                    completion(.failure(APIError(status: false, error_type: "Server Error", message: self.getResponseMessage(data))))
                }
            }
        })
        task.resume()
    }
    

    func executePostRawDataRequest<T:Encodable>(_ paramDict:T, api:String, completion: @escaping (Result<Data?, APIError>) -> Void) {
        
        
        let serviceUrl = URL(string: api)!
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        /*
        if let apiToken = UserSession.getUser()?.apiToken{
            request.setValue("Bearer " + apiToken, forHTTPHeaderField: "Authorization")
        }*/
        request.httpMethod = "POST"
        let jsonData = try? JSONEncoder().encode(paramDict.self)
        request.httpBody = jsonData
        print("URL=",serviceUrl.absoluteString)
        if let str = String(data: jsonData ?? Data(), encoding: .utf8){
            print("Params=",str)
        }
       
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            #if DEBUG
            if let dataV = data {
                if let str = String(data: dataV, encoding: .utf8){
                    print("path=",api)
                    print("response=",str)
                }
            }
            #endif
            if error != nil {
                completion(.failure(APIError(status: false, error_type: "Server Error", message: error!.localizedDescription)))
            }else{
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {

                        if let status = json["success"] as? Bool {
                            
                            if status == true{
                                
                                completion(.success(data))
                                
                            }else{
                                
                                if let message = json["message"] as? String {
                    
                                    completion(.failure(APIError(status: false, error_type: "General", message: message)))
                                }else{
                                    completion(.failure(APIError.generalError))
                                }
                            }
                            
                        }else{
                            
                             completion(.failure(APIError.generalError))
                        }
                        
                    }else{
                        
                         completion(.failure(APIError(status: false, error_type: "JSON Parsing issue", message: "Json not parsed")))
                    }
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                    completion(.failure(APIError.generalError))
                }
            }
            
        })
        task.resume()
    }


    func executeGetWeatherKitRequest(_ paramDict: [String: String], path:String, token:String, completion: @escaping (Result<Data?, APIError>) -> Void) {
        
        var paramString = ""
        for key in paramDict{
            print(key.key)
            paramString.append(key.key)
            paramString.append("=")
            paramString.append(key.value)
            paramString.append("&")
        }
        var serviceUrl = URL(string: path + "?" + paramString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        if paramString.isEmpty{
            serviceUrl = URL(string: path + paramString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        }
        print(serviceUrl)
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
           
            #if DEBUG
            if let dataV = data {
                if let str = String(data: dataV, encoding: .utf8){
                    print("response=", path,str)
                }
            }
            #endif
            
            if error != nil {
                completion(.failure(APIError(status: false, error_type: "Server Error", message: error!.localizedDescription)))
            }else{
                
                completion(.success(data))
            }
            
        })
        task.resume()
    }
    
    func getPostString(params:[String:Any]) -> String{
        
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    
    func convertFormField(named name: String, value: String, using boundary: String) -> String {
      var fieldString = "--\(boundary)\r\n"
      fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
      fieldString += "\r\n"
      fieldString += "\(value)\r\n"

      return fieldString
    }

    
    func convertFileData(fieldName: String, fileName: String, mimeType: String, fileData: Data, using boundary: String) -> Data {
      let data = NSMutableData()

      data.appendString("--\(boundary)\r\n")
      data.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
      data.appendString("Content-Type: \(mimeType)\r\n\r\n")
      data.append(fileData)
      data.appendString("\r\n")

      return data as Data
    }
    
    func getResponseMessage(_ data:Data?)->String{
        var responseMessage = ""
        if let data = data{
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let message = json["message"] as? String {
                        responseMessage = message
                    }
                }
            }catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
                responseMessage = error.localizedDescription
            }
        }
        return responseMessage
    }
}

extension NSMutableData {
  func appendString(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}

extension URLResponse {
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
