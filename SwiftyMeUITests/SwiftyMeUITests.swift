//
//  SwiftyMeUITests.swift
//  SwiftyMeUITests
//
//  Created by MacBook on 15/03/2023.
//

import XCTest
@testable import SwiftyMe

final class SwiftyMeUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        app = XCUIApplication()
        let uploadFile = app.staticTexts["Test File upload"]
        uploadFile.tap()
    }
    func testDownload() throws {
        app = XCUIApplication()
        let uploadFile = app.staticTexts["Test File downloaad"]
        uploadFile.tap()
    }

    func testHitButton(){
        app = XCUIApplication()
        let uploadFile = app.buttons["Hit Button"]
        uploadFile.tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
