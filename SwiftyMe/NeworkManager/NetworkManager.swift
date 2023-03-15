//
//  NetworkManager.swift
//  SwiftyMe
//
//  Created by MacBook on 14/03/2023.
//

import Foundation
import Combine

class NetworkManager:NSObject,URLSessionTaskDelegate{
    
    var session = URLSession.shared
    var cancellables = Set<AnyCancellable>()
    var uploadProgressHandler:((Float)->Void)?
    
    /*
     To download file
     */
    func downloadFile(from url: URL) async throws -> Data? {
        if #available(iOS 15.0, *) {
            do{
                let (localURL, _) = try await session.download(from: url)
                let imageData = try Data(contentsOf: localURL)
                return imageData
            }catch(let error){
                throw error
            }
        } else {
            do{
                let (data, _) = try await session.data(from: url)
                return data
            }catch(let error){
                throw error
            }
        }
    }
    
    /*
     To direct upload file
     */
    func upload(_ data: Data, api:String) async throws -> Data? {
        
        let boundary = "Boundary-\(UUID().uuidString)"
        let serviceUrl = URL(string: APP_URL.BASE_URL + api)!
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let httpBody = NSMutableData()
        httpBody.append(convertFileData(fieldName: "payload",
                                        fileName: UUID().uuidString + ".jpg",
                                        mimeType: data.fileMimieType(extensionFile: ".jpg"),
                                        fileData: data,
                                        using: boundary))
        httpBody.appendString("--\(boundary)--")
        request.httpBody = httpBody as Data
        let (responseData, _) = try await session.upload(
            for: request,
            from: data
        )
        return responseData
    }
    
    /*
     Uploading file with parameters multiform data
     */
    func uploadFileWithParams(_ paramDict: [String: String], fileData:Data?, filedName:String, fileName:String, api:String = UUID().uuidString + ".jpg", token:String?, completion: @escaping (Result<Data?, APIError>) -> Void){
        
        let boundary = "Boundary-\(UUID().uuidString)"
        let serviceUrl = URL(string: APP_URL.BASE_URL + api)!
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        if let apiToken = token{
            request.setValue("Bearer " + apiToken, forHTTPHeaderField: "Authorization")
        }
        //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.setValue("*/*", forHTTPHeaderField: "Accept")
        print("url=",serviceUrl.absoluteString)
        print("paramDict=",paramDict)
        
        let httpBody = NSMutableData()
        for (key, value) in paramDict {
            httpBody.appendString(self.convertFormField(named: key, value: value, using: boundary))
        }
        
        if let data = fileData{
            httpBody.append(convertFileData(fieldName: filedName,
                                            fileName: fileName,
                                            mimeType: data.fileMimieType(extensionFile: ".jpg"),
                                            fileData: data,
                                            using: boundary))
        }
        httpBody.appendString("--\(boundary)--")
        request.httpBody = httpBody as Data
        let sessionUpload = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        let task = sessionUpload.dataTask(with: request, completionHandler: { data, response, error in
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
    
    /*
     Multiform data post request
     */
    func executeNetworkRequestMultiForm(_ paramDict:[String:String], api:String, token:String?) async throws ->Data {
        
        let url = URL(string: APP_URL.BASE_URL + api)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        if let apiToken = token{
            request.setValue("Bearer " + apiToken, forHTTPHeaderField: "Authorization")
        }
        print("URL=",url.absoluteString)
        print("Params=",paramDict)
        let httpBody = NSMutableData()
        for (key, value) in paramDict {
            httpBody.appendString(self.convertFormField(named: key, value: value, using: boundary))
        }
        httpBody.appendString("--\(boundary)--")
        request.httpBody = httpBody as Data
        do{
            let (data, response) = try await session.data(for: request)
            #if DEBUG
            print("response debug=",String(data: data, encoding: .utf8) ?? "")
            #endif
            guard response is HTTPURLResponse else {
                throw APIError.init(status: false, error_type: "", message: "Bad response")
            }
            //print("response.code=",response.getStatusCode())
            return data
        }catch(let error){
            throw APIError.init(status: false, error_type: "", message: error.localizedDescription)
        }
        
    }
    /*
     Simple parameters based GET/POST/Delete request
     */
    func executeNetworkRequest(_ paramDict:[String:Any], api:String, httpMethod:APPHTTPMethod, token:String?) async throws ->Data {
        
        var paramString = ""
        for key in paramDict{
            paramString.append(key.key)
            paramString.append("=\(key.value)")
            paramString.append("&")
        }
        let postString = self.getPostString(params: paramDict)
        var url = URL(string: APP_URL.BASE_URL + api + "?" + paramString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        if paramString.isEmpty{
            url = URL(string: APP_URL.BASE_URL + api)!
        }
        print("url=",url)
        print("Params=",paramDict)
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        if let apiToken = token{
            request.setValue("Bearer " + apiToken, forHTTPHeaderField: "Authorization")
        }
        request.httpBody = postString.data(using: .utf8)
        do{
            let (data, response) = try await URLSession.shared.data(for: request)
            #if DEBUG
            print("response debug=",String(data: data, encoding: .utf8) ?? "")
            #endif
            guard response is HTTPURLResponse else {
                throw APIError.init(status: false, error_type: "", message: "Bad response")
            }
            return data
        }catch(let error){
            throw APIError.init(status: false, error_type: "", message: error.localizedDescription)
        }
        
    }
    
    func executeNetworkRequestRaw<T:Encodable>(_ objectType:T, api:String, token:String?) async throws ->Data {
        
        let url = URL(string: APP_URL.BASE_URL + api)!
        print("url=",url)
        var request = URLRequest(url: url)
        request.httpMethod = APPHTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let apiToken = token{
            request.setValue("Bearer " + apiToken, forHTTPHeaderField: "Authorization")
        }
        if let data = AppUtility.encodeTo(objectType){
            request.httpBody = data
            print("Params=",String(data: data, encoding: .utf8) ?? "")
        }
        do{
            let (data, response) = try await URLSession.shared.data(for: request)
            guard response is HTTPURLResponse else {
                throw APIError.init(status: false, error_type: "", message: "Bad response")
            }
            return data
        }catch(let error){
            throw APIError.init(status: false, error_type: "", message: error.localizedDescription)
        }
        
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
    
    func getPostString(params:[String:Any]) -> String{
        
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
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
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64){
        let uploadProgress = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
        print("uploadProgress=",uploadProgress)
        _ = self.uploadProgressHandler?(uploadProgress)
    }
}
