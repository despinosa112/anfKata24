//
//  ContentViewModelTests.swift
//  ANF Code TestTests
//
//  Created by Daniel Espinosa on 6/16/24.
//

import XCTest
@testable import ANF_Code_Test


final class ContentItemViewModelTests: XCTestCase {
    
    var contentItemViewModelA: ContentItemViewModel!
    var contentItemViewModelB: ContentItemViewModel!


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let contentItemA = ContentItem(elementType: "hyperlink", target: "https://www.abercrombie.com/shop/us/mens-new-arrivals", title: "SHOP NOW")
        let contentItemB = ContentItem(elementType: nil, target: nil, title: nil)
        
        contentItemViewModelA = ContentItemViewModel(contentItem: contentItemA)
        contentItemViewModelB = ContentItemViewModel(contentItem: contentItemB)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_contentItemViewModelA() {
        XCTAssert(contentItemViewModelA.titleText == "SHOP NOW")
        XCTAssert(contentItemViewModelA.target == "https://www.abercrombie.com/shop/us/mens-new-arrivals")
    }
    
    func test_contentItemViewModelB() {
        XCTAssert(contentItemViewModelB.titleText == "")
        XCTAssert(contentItemViewModelB.target == "")
    }

}
