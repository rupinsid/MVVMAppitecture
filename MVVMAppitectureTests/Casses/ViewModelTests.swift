//
//  ViewModelTests.swift
//  MVVMAppitectureTests
//
//  Created by Rupin on 1/29/19.
//  Copyright © 2019. All rights reserved.
//

import XCTest
@testable import MVVMAppitecture

class ViewModelTests: XCTestCase {
    
    var viewModel: ViewModel!

    func testsFirstViewModel() {
        testViewModel(for: 0)
    }
    
    func testsSirstViewModel() {
        testViewModel(for: 1)
    }
    
    func testsThirdViewModel() {
        testViewModel(for: 2)
    }
    
    private func testViewModel(for index: Int) {
        let dataModel = data[index]
        viewModel = ViewModel(model: dataModel)
        XCTAssertEqual(viewModel.name, dataModel.formalName)
        XCTAssertEqual(viewModel.formalName, "Formal name: \(dataModel.formalName)")
        XCTAssertEqual(viewModel.commonName, "Informal name: \(dataModel.commonName)")
        XCTAssertEqual(viewModel.description, dataModel.description)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let dateString = dateFormatter.string(from: Date())
        XCTAssertEqual(viewModel.dateString, dateString)
        
        let fullfill = expectation(description: "Image_Downloader")
        viewModel.download(completionHanlder: { image ,error in
            if error == nil {
                if index != 2 {
                    fullfill.fulfill()
                }
                else {
                    XCTFail()
                }
            }
            else {
                if index == 0 {
                    XCTFail()
                }
                else {
                    fullfill.fulfill()
                }
            }
        })
        waitForExpectations(timeout: 10.0, handler: {(error) in
            if let error = error {
                print("Error: \(error)")
            }
        })
    }
}
