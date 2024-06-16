//
//  CardViewModelTests.swift
//  ANF Code TestTests
//
//  Created by Daniel Espinosa on 6/16/24.
//

import XCTest
@testable import ANF_Code_Test


final class CardViewModelTests: XCTestCase {
    
    var cardViewModelA: CardViewModel!
    var cardViewModelB: CardViewModel!


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let contentItem = ContentItem(elementType: nil, target: "www.google.com", title: "itemTitle")
        let cardA = Card(title: "title", backgroundImage: "http://img.abercrombie.com/is/image/anf/ANF-2024-060624-M-HP-NewArrivals-USCA-Mens.jpg", content: [contentItem], promoMessage: "USE CODE: 12345", topDescription: "A&F ESSENTIALS", bottomDescription: "*In stores & online. <a href=\"http://www.abercrombie.com/anf/media/legalText/viewDetailsText20160601_Shorts_US.html\">Exclusions apply. See Details</a>")
        let cardB = Card(title: nil, backgroundImage: nil, content: nil, promoMessage: nil, topDescription: nil, bottomDescription: nil)
        cardViewModelA = CardViewModel(card: cardA)
        cardViewModelB = CardViewModel(card: cardB)

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_cardViewModelA() {
        XCTAssert(cardViewModelA.displayImage == true)
        XCTAssert(cardViewModelA.displayTopDescriptionLabel == true)
        XCTAssert(cardViewModelA.displayTitleLabel == true)
        XCTAssert(cardViewModelA.displayPromoLabel == true)
        XCTAssert(cardViewModelA.displayBottomDescriptionButton == true)
        XCTAssert(cardViewModelA.displayContent == true)
        
        XCTAssert(cardViewModelA.topDescriptionText == "A&F ESSENTIALS")
        XCTAssert(cardViewModelA.titleText == "title")
        XCTAssert(cardViewModelA.promoText == "USE CODE: 12345")
        XCTAssert(cardViewModelA.bottomDescriptionText == "*In stores & online. Exclusions apply. See Details")
        XCTAssert(cardViewModelA.bottomDescriptionURLString == "http://www.abercrombie.com/anf/media/legalText/viewDetailsText20160601_Shorts_US.html")
        XCTAssert(cardViewModelA.bottomDescriptionContainsHyperLink == true)
        XCTAssert(cardViewModelA.contentItems.count == 1)
        XCTAssert(cardViewModelA.imageUrlString == "http://img.abercrombie.com/is/image/anf/ANF-2024-060624-M-HP-NewArrivals-USCA-Mens.jpg")
    }
    
    func test_cardViewModelB() {
        XCTAssert(cardViewModelB.displayImage == false)
        XCTAssert(cardViewModelB.displayTopDescriptionLabel == false)
        XCTAssert(cardViewModelB.displayTitleLabel == false)
        XCTAssert(cardViewModelB.displayPromoLabel == false)
        XCTAssert(cardViewModelB.displayBottomDescriptionButton == false)
        XCTAssert(cardViewModelB.displayContent == false)
        
        XCTAssert(cardViewModelB.topDescriptionText == "")
        XCTAssert(cardViewModelB.titleText == "")
        XCTAssert(cardViewModelB.promoText == "")
        XCTAssert(cardViewModelB.bottomDescriptionText == "")
        XCTAssert(cardViewModelB.bottomDescriptionURLString == "")
        XCTAssert(cardViewModelB.bottomDescriptionContainsHyperLink == false)
        XCTAssert(cardViewModelB.contentItems.count == 0)
        XCTAssert(cardViewModelB.imageUrlString == "")
    }

}
