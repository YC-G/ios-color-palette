//
//  ColorTest.swift
//  ColorPaletteTests
//
//  Created by Yuchen Guo on 4/20/23.
//

import XCTest
@testable import ColorPalette

final class ColorTest: XCTestCase {

    func testColorDebugDescription() throws {
        let subjectUnderTest = Color("水牛灰", "buffalo grey", "#2F2F35", "https://color-term.com/assets/img/colors/shuiniuhui-2f2f35.png")

                let actualValue = subjectUnderTest.debugDescription

                let expectedValue = "Color(name: 水牛灰, englishName: buffalo grey, hexValue: #2F2F35"
                
                XCTAssertEqual(actualValue, expectedValue)
    }

}
