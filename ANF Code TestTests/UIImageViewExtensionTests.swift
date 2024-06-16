//
//  UIImageExtensionTests.swift
//  ANF Code TestTests
//
//  Created by Daniel Espinosa on 6/16/24.
//

import XCTest
@testable import ANF_Code_Test


final class UIImageViewExtensionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testScaleToFitScreen_with_portrait_image() {
        // Given
        let image = UIImage(named: "anf-US-20160601-app-women-spotlight")
        let expectedWidth = UIScreen.main.bounds.size.width

        // When
        let scaledImage = image?.scaleToFitScreen()

        // Then
        XCTAssertNotNil(scaledImage, "Scaled image should not be nil")
        XCTAssertEqual(scaledImage?.size.width, expectedWidth, "Scaled image width should match screen size")
        XCTAssertNotEqual(scaledImage?.size.height, image?.size.height, "Scaled image height should not match original height")
    }
    
    func testScaleToFitScreen_with_landscape_image() {
        // Given
        let image = UIImage(named: "anf-US-20160601-app-women-dresses")
        let expectedWidth = UIScreen.main.bounds.size.width

        // When
        let scaledImage = image?.scaleToFitScreen()

        // Then
        XCTAssertNotNil(scaledImage, "Scaled image should not be nil")
        XCTAssertEqual(scaledImage?.size.width, expectedWidth, "Scaled image width should match screen width")
        XCTAssertNotEqual(scaledImage?.size.height, image?.size.height, "Scaled image height should not match original height")
    }

}
