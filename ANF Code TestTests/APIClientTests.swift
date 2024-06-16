//
//  APIClientTests.swift
//  ANF Code TestTests
//
//  Created by Daniel Espinosa on 6/16/24.
//

import XCTest
@testable import ANF_Code_Test


final class APIClientTests: XCTestCase {
    
    var apiClient: APIClient!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        apiClient = APIClient()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func test_fetchExploreCards_fetches_10() {
        apiClient.fetchExploreCards { (result: Result<[Card], Error>) in
            switch result {
            case .success(let exploreCards):
                XCTAssert(exploreCards.count == 10)
            case .failure(let error):
                XCTFail("Error fetching content: \(error)")
            }
        }
    }
    
    func test_fetchExploreCards_first_card_is_correct() {
        apiClient.fetchExploreCards { (result: Result<[Card], Error>) in
            switch result {
            case .success(let exploreCards):
                
                let firstCard = exploreCards.first
                XCTAssert(firstCard!.title == "TOPS STARTING AT $12")
                XCTAssert(firstCard!.backgroundImage == "http://img.abercrombie.com/is/image/anf/ANF-2024-060624-M-HP-NewArrivals-USCA-Mens.jpg")
                XCTAssert(firstCard!.promoMessage == "USE CODE: 12345")
                XCTAssert(firstCard!.topDescription == "A&F ESSENTIALS")
                XCTAssert(firstCard!.bottomDescription == "*In stores & online. <a href=\\\"http://www.abercrombie.com/anf/media/legalText/viewDetailsText20160602_Tier_Promo_US.html\\\">Exclusions apply. See Details</a>")
                XCTAssert(firstCard!.content?.count == 2)
                XCTAssert(firstCard!.content![0].title == "Shop Men")
                XCTAssert(firstCard!.content![0].target == "https://www.abercrombie.com/shop/us/mens-new-arrivals")
                XCTAssert(firstCard!.content![0].elementType == nil)
                XCTAssert(firstCard!.content![1].title == "Shop Women")
                XCTAssert(firstCard!.content![1].target == "https://www.abercrombie.com/shop/us/womens-new-arrivals")
                XCTAssert(firstCard!.content![1].elementType == nil)
            case .failure(let error):
                XCTFail("Error fetching content: \(error)")
            }
        }
    }
    
    
    

}
