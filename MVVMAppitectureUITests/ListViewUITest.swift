//
//  ListViewUITest.swift
//  MVVMAppitectureUITests
//
//  Created by Rupin on 2/1/19.
//  Copyright © 2019 . All rights reserved.
//

import XCTest

class ListViewUITest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMesser1() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let cellTitle = tablesQuery.staticTexts["Formal name: Messier 1"]
        let cellSubTitle = tablesQuery.staticTexts["Informal name: The Crab Nebula"]
        XCTAssertTrue(cellTitle.exists)
        XCTAssertTrue(cellSubTitle.exists)
        
        let activityIndicator = app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Informal name: The Crab Nebula")/*[[".cells.containing(.staticText, identifier:\"Formal name: Messier 1\")",".cells.containing(.staticText, identifier:\"Informal name: The Crab Nebula\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.activityIndicators["In progress"]
        XCTAssertTrue(activityIndicator.exists)
        
//        expectation(for: NSPredicate(format: "count == 0"), evaluatedWith: activityIndicator, handler: nil)
        expectation(for: NSPredicate(format: "exists == 0"), evaluatedWith: activityIndicator, handler: nil)
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
