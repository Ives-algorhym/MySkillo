//
//  MySkilloSwiftUIUITests.swift
//  MySkilloSwiftUIUITests
//
//  Created by Ives Murillo on 3/5/26.
//

import XCTest

final class MySkilloSwiftUIUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testExample() {
        let app = XCUIApplication()
        app.launch()
    }

    @MainActor
    func testLaunchPerformance() {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
