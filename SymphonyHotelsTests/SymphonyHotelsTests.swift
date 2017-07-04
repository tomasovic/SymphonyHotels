//
//  SymphonyHotelsTests.swift
//  SymphonyHotelsTests
//
//  Created by Milan Tomasovic on 7/4/17.
//  Copyright © 2017 Milan Tomasovic. All rights reserved.
//

import XCTest
@testable import SymphonyHotels

let DEFAULT_TIMEOUT = 5.0

class SymphonyHotelsTests: XCTestCase {
    
    // MARK: - Properties
    let api = RESTManager.shared
    var hotels = [Hotel]()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchingHotels() {
        let currentExpectation = expectation(description: "Hotels fetched successfully")
        
        api.loadData(from: "\(BASE_URL)/hotel_api/", method: .get, parameters: nil, completion: { (status, response) in
            XCTAssert(status == .success, "Hotels fetching error")
            
            currentExpectation.fulfill()
        })
        
        waitForExpectations(timeout: DEFAULT_TIMEOUT) { (error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
    
}
