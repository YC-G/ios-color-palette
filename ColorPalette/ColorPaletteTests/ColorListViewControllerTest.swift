//
//  ColorListViewControllerTest.swift
//  ColorPaletteTests
//
//  Created by Yuchen Guo on 4/20/23.
//

import XCTest
@testable import ColorPalette

final class ColorListViewControllerTest: XCTestCase {
    var systemUnderTest : colorListViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
                
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyBoard.instantiateInitialViewController() as! UINavigationController
        self.systemUnderTest = navigationController.topViewController as? colorListViewController
                
        // UIApplication.shared.windows.filter { $0.isKeyWindow}.first!.rootViewController = self.systemUnderTest
        UIApplication.shared.windows.filter { $0.isKeyWindow}.first?.rootViewController = self.systemUnderTest
                
                
        XCTAssertNotNil(navigationController.view)
        XCTAssertNotNil(self.systemUnderTest.view)
    }

    func testTableview_loadsColors() throws {
        //Given
        let mockColorService = mockColorService()
        let mockColors = [Color("景泰蓝", "cloisonne blue", "#2775B6", "https://color-term.com/assets/img/colors/jingtailan-2775b6.png"),
            Color("鸥蓝", "gull blue", "#C7D2D4", "https://color-term.com/assets/img/colors/oulan-c7d2d4.png"),
            Color("玉髓绿", "chrysoprase green", "#41B349", "https://color-term.com/assets/img/colors/yusuilv-41b349.png")]
        mockColorService.mockColors = mockColors
                
        self.systemUnderTest.viewDidLoad()
        self.systemUnderTest.colorService = mockColorService
                
        //When
        self.systemUnderTest.viewWillAppear(false)
                
        //Then
        XCTAssertEqual(mockColors.count, 3)
        XCTAssertEqual(mockColors.count, self.systemUnderTest.colors.count)
        XCTAssertEqual(mockColors.count, self.systemUnderTest.tableView.numberOfRows(inSection: 0))
    }

    class mockColorService: ColorService {
        var mockColors: [Color]?
        var mockError: Error?
            
        override func getColors(completion: @escaping ([Color]?, Error?) -> ()) {
            completion(mockColors, mockError)
        }
            
    }

}
