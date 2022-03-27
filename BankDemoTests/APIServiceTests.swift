//
//  CodingTestTests.swift
//  CodingTestTests
//
//  Created by faizal on 07/10/18.
//  Copyright © 2018 test. All rights reserved.
//

import XCTest
@testable import BankDemo

class APIServiceTests: XCTestCase {
    
    var apiService: APIService?
    
    override func setUp() {
        super.setUp()
        apiService = APIService()
    }
    
    override func tearDown() {
        apiService = nil
        super.tearDown()
    }
    
    func testFetchTopStories() {
        
        // Given A apiservice
        let apiService = self.apiService
        
        // When fetch top stories
        let expect = XCTestExpectation(description: "callback")
        
        apiService?.fetchTopStories(complete: { (success, topStories, error) in
            expect.fulfill()
            //for story in topStories {
                XCTAssertNotNil(topStories)
           // }
            
        })
        
        wait(for: [expect], timeout: 31.0)
    }
    
}
