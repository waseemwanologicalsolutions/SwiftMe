//
//  APITestsViewModel.swift
//  SwiftyMe
//
//  Created by MacBook on 14/03/2023.
//

import Foundation
import SwiftUI
import UIKit

class APITestsViewModel:ObservableObject{
    
    @Published var isLoading:Bool = false
    @Published var uploadProgress:Float = 0
    @Published var downloadProgress:Float = 0
   
    let networkManger = NetworkManager()
    let downloader = FileDownloader()
    
    let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI0IiwianRpIjoiMDk3YjIwZjcyOWM5ZTY0N2E1NjU0MjgzYmM3NTg5ZWI4NWY2OWM1YWE2ZjdkZTc3ZWJkNWVhODRhODIwNGM1YTc3NmM4ZGQ5ZGVlOGZiYmYiLCJpYXQiOjE2Nzg4MDQ3NTcuNTM0MjkzODg5OTk5Mzg5NjQ4NDM3NSwibmJmIjoxNjc4ODA0NzU3LjUzNDI5NjAzNTc2NjYwMTU2MjUsImV4cCI6MTcxMDQyNzE1Ny41MjY0MTc5NzA2NTczNDg2MzI4MTI1LCJzdWIiOiIzIiwic2NvcGVzIjpbXX0.D6fthXPCDhhwS4Yhsd4IM9cGwGMXmeqfrzRvQv7EWCsR1eK2bCQtrp2p1MH5aWJp6NSogyrurS2EkhDZbD8--GKZIBqAJTpAoPgZEozZm9RSmRyFbbytS2uLdUuAganIUvTHqjRCF-r3TPkg21Ry3jA--Ge6a7tfFESVUZzM1pSjc2NsKsiumrGvk2316HBLyBTe3vNhh-wtSjJkGfTKwnTpyLi-iPYPiOtqYwEeMeHCk8eMptHGQ70IBxvpuQ47JiGadWrYHa80yvuGMbeaAqpenwJr16P3s_sCH5Hm4SO5vyzKzXpLA3wpZxMz07hkTPjBjNkMiJeROIUs2ngmVm9WiF6S4VOfo0f86RKwIBrjzAxIOwiNBaDrsWUNsIgAqSfSURwkoteeipFFIMyt4jOWiAvf0GYvOC6WqmzJ1JzSUJ3Iv8BzXJBvshubvxsp4zVhy3-nEHsM5O0Ctiiw13dQ-l0uMsjwlU1iD1d_1HhOimT8gynMNZoJZZ_WxiSfQ07RE5FkKc1Gy3_YJtWG09OJsvKWXrdJVXZMpxZ7Rgnps3QrARfQju7PLrHX6xnuA85jII8O6KlCvxUL1AjH8KLkM5GZpsHCgp1BHS1I7FLISv7WYAvbYxlB_VUrHf4fqJrZUb8c6dTGWxfVBjIxJGeDI730TLRXjS1Lmw-_rVk"
    
    func testMultiFormRequest(){
        let paramDict = ["email":"waseemhost@gmail.com", "password":"123456", "device_type":"Android"]
        
        Task{
            do{
                let data = try await self.networkManger.executeNetworkRequestMultiForm(paramDict, api: "api/login", token: token)
                if let json = data.dataToJson(){
                    print("json response=",json)
                }else{
                    print("no response")
                }
            }catch(let error){
                print("error 2=",error.localizedDescription)
            }
        }
    }
    
    func testPostRequest(){
        
        Task{
            do{
                let paramDict = ["email":"waseemhost@gmail.com", "password":"123456", "device_type":"Android"]
                let data = try await self.networkManger.executeNetworkRequest(paramDict, api: "api/login", httpMethod: APPHTTPMethod.post, token: token)
                if let json = data.dataToJson(){
                    print("json response=",json)
                }else{
                    print("no response")
                }
            }catch(let error){
                print("error 2=",error.localizedDescription)
            }
        }
    }
    
    func testFileUpload(){
        
        let image = UIImage(named:"1")!
        let imageData = image.pngData()
        let paramDict = ["email":"waseemhost@gmail.com", "password":"123456", "device_type":"Android"]
        self.networkManger.uploadProgressHandler = { val in
            withAnimation{
                self.uploadProgress = val
            }
        }
        self.networkManger.uploadFileWithParams(paramDict,fileData:imageData, filedName:"profile", fileName: "profile.png", api: "api/updateUser", token: token) { (result) in
            DispatchQueue.main.async {
                switch result{
                case .failure(let error):
                    print(error.message)
                case .success( _):
                    print("done")
                }
            }
       }
    }
    
    func testPostJsonRequest(){
        
        Task{
            do{
                let reqModel = BookingRequestModel(id: 1,booking_id: 2)
                let data = try await self.networkManger.executeNetworkRequestRaw(reqModel, api: "api/booking-details", token: token)
                if let json = data.dataToJson(){
                    print("json response=",json)
                }else{
                    print("no response")
                }
            }catch(let error){
                print("error 2=",error.localizedDescription)
            }
        }
    }
    
    func testFileDownload(){
        downloader.progressHandler = { val in
            DispatchQueue.main.async {
                self.downloadProgress = Float(val)
            }
            
        }
        downloader.downloadFileWithProgress(fName: "test", fileUrl: "https://link.testfile.org/30MB", indexPath: IndexPath(row: 0, section: 0))
    }
}


struct BookingRequestModel: Codable {
    var id:Int?
    var booking_id:Int?
}
