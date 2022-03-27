//
//  DetailsViewControllerTests.swift
//  BankDemoTests
//
//  Created by Santanu on 23/03/2022.
//

import XCTest
@testable import BankDemo

class DetailsViewControllerTests: XCTestCase {
    var detailsViewController = (UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController)
    var  mockAPIService = MockApiService()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        detailsViewController?.loadViewIfNeeded()
    }
    func testRender() {
        //Given a sut with fetched topstories
        mockAPIService.completeTopStories = StubGenerator().stubTopStories()
        let indexPath = IndexPath(row: 1, section: 0)
        let testStory = mockAPIService.completeTopStories[indexPath.row]
        let model = TopStoryDetailsViewModel(titleText: testStory.newsTitle ?? "", authorText: testStory.newsByLine ?? "", imageUrl: "", dateText: testStory.newsPublishedDate ?? "", detailsText: testStory.newsAbstract ?? "", seeMoreLink: testStory.newsWebUrl ?? "", subSection: testStory.newSubsection ?? "")
        detailsViewController?.topStoryViewModel  = model
        detailsViewController?.viewSetUp()
        XCTAssertEqual(detailsViewController?.navigationItem.title, "News Details")
        XCTAssertEqual(detailsViewController?.newsTitle?.text, "A Pastor Pushes Forward as a Drought Threatens His Town and His Church")
        XCTAssertEqual(detailsViewController?.newsDesc?.text, "The specter of harder times hangs over a rural Australian town where the worst of the drought has yet to come.")
        XCTAssertEqual(detailsViewController?.newsAuthor?.text, "By RICK ROJAS")
        XCTAssertEqual(detailsViewController?.newsDate?.text, "2018-10-07T15:01:06-04:00")
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        detailsViewController = nil
    }


}


