//
//  ColorPaletteUITests.swift
//  ColorPaletteUITests
//
//  Created by Yuchen Guo on 4/6/23.
//

import XCTest

final class ColorPaletteUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.tables.element(boundBy: 0).tap()
        
        let colorPaletteBackButton = app.navigationBars["ColorPalette.DetailView"].buttons["Chinese Traditional Colors"]
        XCTAssertTrue(colorPaletteBackButton.exists)
        colorPaletteBackButton.tap()
        XCTAssertFalse(colorPaletteBackButton.exists)
        
        app.tables.children(matching: .cell).element(boundBy: 2).tap()
        XCTAssertTrue(colorPaletteBackButton.exists)
        colorPaletteBackButton.tap()
        XCTAssertFalse(colorPaletteBackButton.exists)
        
    
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
