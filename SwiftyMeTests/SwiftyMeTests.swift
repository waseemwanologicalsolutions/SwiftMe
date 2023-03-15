//
//  SwiftyMeTests.swift
//  SwiftyMeTests
//
//  Created by MacBook on 15/03/2023.
//

import XCTest
@testable import SwiftyMe

final class SwiftyMeTests: XCTestCase {

    let networkManger = NetworkManager()
    
    let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI0IiwianRpIjoiMDk3YjIwZjcyOWM5ZTY0N2E1NjU0MjgzYmM3NTg5ZWI4NWY2OWM1YWE2ZjdkZTc3ZWJkNWVhODRhODIwNGM1YTc3NmM4ZGQ5ZGVlOGZiYmYiLCJpYXQiOjE2Nzg4MDQ3NTcuNTM0MjkzODg5OTk5Mzg5NjQ4NDM3NSwibmJmIjoxNjc4ODA0NzU3LjUzNDI5NjAzNTc2NjYwMTU2MjUsImV4cCI6MTcxMDQyNzE1Ny41MjY0MTc5NzA2NTczNDg2MzI4MTI1LCJzdWIiOiIzIiwic2NvcGVzIjpbXX0.D6fthXPCDhhwS4Yhsd4IM9cGwGMXmeqfrzRvQv7EWCsR1eK2bCQtrp2p1MH5aWJp6NSogyrurS2EkhDZbD8--GKZIBqAJTpAoPgZEozZm9RSmRyFbbytS2uLdUuAganIUvTHqjRCF-r3TPkg21Ry3jA--Ge6a7tfFESVUZzM1pSjc2NsKsiumrGvk2316HBLyBTe3vNhh-wtSjJkGfTKwnTpyLi-iPYPiOtqYwEeMeHCk8eMptHGQ70IBxvpuQ47JiGadWrYHa80yvuGMbeaAqpenwJr16P3s_sCH5Hm4SO5vyzKzXpLA3wpZxMz07hkTPjBjNkMiJeROIUs2ngmVm9WiF6S4VOfo0f86RKwIBrjzAxIOwiNBaDrsWUNsIgAqSfSURwkoteeipFFIMyt4jOWiAvf0GYvOC6WqmzJ1JzSUJ3Iv8BzXJBvshubvxsp4zVhy3-nEHsM5O0Ctiiw13dQ-l0uMsjwlU1iD1d_1HhOimT8gynMNZoJZZ_WxiSfQ07RE5FkKc1Gy3_YJtWG09OJsvKWXrdJVXZMpxZ7Rgnps3QrARfQju7PLrHX6xnuA85jII8O6KlCvxUL1AjH8KLkM5GZpsHCgp1BHS1I7FLISv7WYAvbYxlB_VUrHf4fqJrZUb8c6dTGWxfVBjIxJGeDI730TLRXjS1Lmw-_rVk"
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
            
        }
    }
    
    func testMultiFormRequest() async{
        let paramDict = ["email":"waseemhost@gmail.com", "password":"123456", "device_type":"Android"]
        do{
            let data = try await self.networkManger.executeNetworkRequestMultiForm(paramDict, api: "api/login", token: token)
            if let json = data.dataToJson(){
                print("json=",json)
                XCTAssertTrue(true)
            }else{
                XCTAssertTrue(false)
            }
        }catch(let error){
            print("error=",error.localizedDescription)
            XCTAssertTrue(false)
        }
    }

}
