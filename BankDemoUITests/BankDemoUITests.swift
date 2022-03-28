//
//  BankDemoUITests.swift
//  BankDemoUITests
//
//  Created by Santanu on 18/03/2022.
//

import XCTest

class BankDemoUITests: XCTestCase {
    let app = XCUIApplication()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTableView() {
        app.launch()
        let tablelist = app.descendants(matching: .table)
        print(tablelist)
        wait(for: 20)
        let newsTableView = tablelist["newsTableView"]
        
        // Assert that we are displaying the tableview
        XCTAssertTrue(newsTableView.exists, "The  tableview exists")
        
        let tableCells  = newsTableView.cells
        
        if tableCells.count > 0 {
            let count = tableCells.count - 1
            let promise = expectation(description: "Wait for table cells")
            for i in stride(from: 0, to: count, by: 1) {
                let tablecell = tableCells.element(boundBy: i)
                XCTAssertTrue(tablecell.exists, "the \(i) ceel is exit")
                tablecell.tap()
                if i == (count - 1) {
                    promise.fulfill()
                }
                let loadMoreButton = app.buttons["Open Web Link"]
                XCTAssertTrue(loadMoreButton.exists, "Open Web Link Button Exit")
                loadMoreButton.tap()
                let webView = app.webViews["newsWebView"]
                //Display Webview
                XCTAssertTrue(webView.exists, "WKWebView Exit")
                // Back Button
                app.navigationBars.buttons.element(boundBy: 0).tap()
                app.navigationBars.buttons.element(boundBy: 0).tap()
            }
            waitForExpectations(timeout:2, handler: nil)
            XCTAssertTrue(true, "Finished validating the table cells")
        } else {
            XCTAssert(false, "Was not able to find any table cells")
        }
    }

//    func testExample() throws {
//        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
//        app.launch()
//
//        // Use recording to get started writing UI tests.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
    
    

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}

extension XCTestCase {

  func wait(for duration: TimeInterval) {
    let waitExpectation = expectation(description: "Waiting")

    let when = DispatchTime.now() + duration
    DispatchQueue.main.asyncAfter(deadline: when) {
      waitExpectation.fulfill()
    }
    // We use a buffer here to avoid flakiness with Timer on CI
    waitForExpectations(timeout: duration + 0.5)
  }
}
