//
//  BankDemoTests.swift
//  BankDemoTests
//
//  Created by Santanu on 18/03/2022.
//

import XCTest
@testable import BankDemo

class HomeViewControllerTests: XCTestCase {
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
            XCTAssertEqual(rowNumber, 6, "should return the right number of rows")
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
            XCTAssertEqual(cell?.newsTitle.text, "Audrey Wells, Screenwriter Behind ‘The Hate U Give,’ Dies at 58")
            XCTAssertEqual(cell?.newCoverBy.text, "By SARAH MERVOSH")
        }
    }

}
