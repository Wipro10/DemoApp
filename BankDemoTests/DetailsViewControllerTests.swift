//
//  DetailsViewControllerTests.swift
//  BankDemoTests
//
//  Created by Santanu on 23/03/2022.
//

import XCTest
@testable import BankDemo

class DetailsViewControllerTests: XCTestCase {
    let sut = (UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController)
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut?.loadViewIfNeeded()
    }
    func testRender() {
        
        let model = TopStoryDetailsViewModel(titleText: "testTitle", authorText: "Dr Richard", imageUrl: "https://static01.nyt.com/images/2018/10/07/briefing/08Briefing-asia-promo/08Briefing-asia-promo-thumbStandard.jpg", dateText: "2018-10-07T17:40:06-04:00", detailsText: "Test Desc", seeMoreLink: "Test", subSection: "Test")
        sut?.topStoryViewModel  = model
        sut?.viewSetUp()
        XCTAssertEqual(sut?.navigationItem.title, "News Details")
        XCTAssertEqual(sut?.newsTitle?.text, "testTitle")
        XCTAssertEqual(sut?.newsDesc?.text, "Test Desc")
        XCTAssertEqual(sut?.newsAuthor?.text, "Dr Richard")
        XCTAssertEqual(sut?.newsDate?.text, "2018-10-07T17:40:06-04:00")
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
