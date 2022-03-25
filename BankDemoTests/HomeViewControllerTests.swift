//
//  BankDemoTests.swift
//  BankDemoTests
//
//  Created by Santanu on 18/03/2022.
//

import XCTest
@testable import BankDemo

class HomeViewControllerTests: XCTestCase {
   // var homeViewModel = HomeViewModelTests()
    var  mockAPIService = MockApiService()
    var homeViewModel: HomeViewModel?
    var sut = (UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController)
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        homeViewModel = HomeViewModel(apiService: mockAPIService)
        sut?.loadViewIfNeeded()
        sut?.viewDidLoad()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    func testInitMyTableView() {
        XCTAssertNotNil(sut?.newsTableView)
    }
    func testLoadViewSetsTableViewDataSource(){
        XCTAssertNotNil(sut?.newsTableView?.dataSource)
    }
    func testLoadViewSetsTableViewDelegate(){
        XCTAssertNotNil(sut?.newsTableView?.delegate)
    }
    func testRowNumberOfTableView() {
        mockAPIService.completeTopStories = StubGenerator().stubTopStories()
        homeViewModel?.initFetch()
        mockAPIService.fetchSuccess()
        if let viewModel = homeViewModel {
            sut?.viewModel = viewModel
            let rowNumber = sut?.newsTableView?.numberOfRows(inSection: 0)
            XCTAssertEqual(rowNumber, 38, "should return the right number of rows")
        }
    }
    func testSectionNumberOfTableView() {
        let sectionNumber = sut?.newsTableView?.numberOfSections
        XCTAssertEqual(sectionNumber, 1, "should return the right number of sections")
    }
    func testTableCell() {
        mockAPIService.completeTopStories = StubGenerator().stubTopStories()
        homeViewModel?.initFetch()
        mockAPIService.fetchSuccess()
        if let viewModel = homeViewModel {
        sut?.viewModel = viewModel
            let cell = sut?.tableView(sut?.newsTableView ?? UITableView(), cellForRowAt: IndexPath(row: 0, section: 0)) as? NewsCell
            XCTAssertEqual(cell?.newsTitle.text, "Kavanaugh, Interpol, the Afghan War: Your Monday Briefing")
            XCTAssertEqual(cell?.newCoverBy.text, "By ALISHA HARIDASANI GUPTA")
        }
    }
//    func testTablee() {
//        //homeViewModel.goToFetchTopStoriesFinished()
//      //  sut?.viewModel.topStories = StubGenerator().stubTopStories()
//        mockAPIService.completeTopStories = StubGenerator().stubTopStories()
//        let indexPath = IndexPath(row: 1, section: 0)
//        let testStory = mockAPIService.completeTopStories[indexPath.row]
//        
//       // homeViewModel.initFetch()
//        homeViewModel?.initFetch()
//        mockAPIService.fetchSuccess()
//        
//        sut?.viewModel = homeViewModel!
//        
//        let vm = sut?.viewModel.getCellViewModel(at: indexPath)
//        
//    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
