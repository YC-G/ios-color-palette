//
//  ColorServiceTest.swift
//  ColorPaletteTests
//
//  Created by Yuchen Guo on 4/20/23.
//

import XCTest
@testable import ColorPalette

final class ColorServiceTest: XCTestCase {
    var systemUnderTest: ColorService!
    
    override func setUpWithError() throws {
        self.systemUnderTest = ColorService()
    }

    override func tearDownWithError() throws {
        self.systemUnderTest = nil
    }

    func testAPI_returnSuccessfulResult() throws {
        var colors: [Color]!
        var error: Error?
                
        let promise = expectation(description: "Completion handler is invoked")
                
        self.systemUnderTest.getColors(completion: {data, shouldntHappen in
            colors = data
            error = shouldntHappen
            promise.fulfill()
        })
        wait(for: [promise], timeout: 5)
        XCTAssertNotNil(colors)
        XCTAssertNil(error)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
