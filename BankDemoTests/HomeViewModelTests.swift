//
//  TopStoriesListViewModelTests.swift
//  CodingTestTests
//
//  Created by faizal on 07/10/18.
//  Copyright © 2018 test. All rights reserved.
//

import XCTest
@testable import BankDemo

class HomeViewModelTests: XCTestCase {
    var homeViewModel: HomeViewModel?
   // var mockAPIService: MockApiService!
    var  mockAPIService = MockApiService()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
       // mockAPIService = MockApiService()
        homeViewModel = HomeViewModel(apiService: mockAPIService)
    }
    
   
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        homeViewModel = nil
      //  mockAPIService = nil
        super.tearDown()
    }
    
    
  
    
    
    func testFetchTopStories() {
        // Given
        mockAPIService.completeTopStories = [TopStorie]()
        
        // When
        homeViewModel?.initFetch()
        
        // Assert
            XCTAssert(mockAPIService.isFetchTopStoriesCalled)
        
    }
    
    func testFetchTopStoriesFail() {
        
//        //Create an instance of Api error for mocking the fetch fail
//        let error

        // When
        homeViewModel?.initFetch()
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Object does not exist"])
        //Replace the nil with error instace
        mockAPIService.fetchFail(error: error )

        // Sut should display predefined error message
        XCTAssertEqual( homeViewModel?.alertMessage, "Object does not exist")
        
    }
   
    
    func testGetCellViewModel() {
        
        //Given a sut with fetched topstories
        goToFetchTopStoriesFinished()
        
        let indexPath = IndexPath(row: 1, section: 0)
        let testStory = mockAPIService.completeTopStories[indexPath.row]
        
        // When
        let vm = homeViewModel?.getCellViewModel(at: indexPath)
        
        //Assert
        XCTAssertEqual( vm?.titleText, testStory.newsTitle)
        XCTAssertEqual( vm?.authorText, testStory.newsByLine)

    }
   
    func testUserPressViewModel() {
        
        //Given a sut with fetched topstories
        goToFetchTopStoriesFinished()
        
        let indexPath = IndexPath(row: 1, section: 0)
        let testStory = mockAPIService.completeTopStories[indexPath.row]
        
        // When
        let dataModel = homeViewModel?.userPressed(at: indexPath.row)
        
        //Assert
        XCTAssertEqual( dataModel?.titleText, testStory.newsTitle)
        XCTAssertEqual( dataModel?.authorText, testStory.newsByLine)

    }
    
}


//MARK: State control
extension HomeViewModelTests {
    private func goToFetchTopStoriesFinished() {
        mockAPIService.completeTopStories = StubGenerator().stubTopStories()
        homeViewModel?.initFetch()
        mockAPIService.fetchSuccess()
    }
}


class MockApiService: APIServiceProtocol {
    var isFetchTopStoriesCalled = false

    var completeTopStories: [TopStorie] = [TopStorie]()
    var completeClosure: ((Bool, [TopStorie], Error?) -> ())!
    
    
    func fetchTopStories(complete: @escaping (Bool, [TopStorie], Error?) -> ()) {
        isFetchTopStoriesCalled = true
        completeClosure = complete
        
    }

    func fetchSuccess() {
        completeClosure( true, completeTopStories, nil )
    }
    
    func fetchFail(error: Error?) {
        completeClosure( false, completeTopStories, error )
    }
    
}

class StubGenerator {
    func stubTopStories() -> [TopStorie] {
        guard let path = Bundle.main.path(forResource: "localStorage", ofType: "json") else { return []}
        do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let topStoriesList = try decoder.decode(TopStoriesResponse.self, from: data)
            return topStoriesList.newsResults
        } catch {}
      return []
    }
   
}
