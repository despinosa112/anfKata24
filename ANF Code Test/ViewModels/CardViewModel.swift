//
//  CardViewModel.swift
//  ANF Code Test
//
//  Created by Daniel Espinosa on 6/13/24.
//

import Foundation
import SwiftSoup
import UIKit


class CardViewModel {
    
    private var card: Card?
    private var bottomDescription: HyperLinkObject?
    
    init(card: Card? = nil) {
        self.card = card
        parseBottomDescription()
    }
    
    //Display Labels
    var displayImage: Bool {
        return card?.backgroundImage != nil ? true : false
    }
    
    var displayTopDescriptionLabel: Bool {
        return card?.topDescription != nil ? true : false
    }
    
    var displayTitleLabel: Bool {
        return card?.title != nil ? true : false
    }
    
    var displayPromoLabel: Bool {
        return card?.promoMessage != nil ? true : false
    }
    
    var displayBottomDescriptionButton: Bool {
        return card?.bottomDescription != nil ? true : false
    }
    
    var displayContent: Bool {
        return card?.content != nil ? true : false
    }
    
    //Label Text
    var topDescriptionText: String {
        return card?.topDescription ?? ""
    }
    
    var titleText: String {
        return card?.title ?? ""
    }
    
    var promoText: String {
        return card?.promoMessage ?? ""
    }

    var bottomDescriptionText: String {
        return bottomDescription?.message ?? ""
    }
    
    var bottomDescriptionURLString: String {
        return bottomDescription?.hyperlink ?? ""
    }
        
    var bottomDescriptionContainsHyperLink: Bool {
        return bottomDescription?.hyperlink != nil ? true : false
    }
    
    //BottomDescription
    //TODO: Update this function to be more flexible
    private func parseBottomDescription(){
        guard let bottomDescription = card?.bottomDescription else { return }
        
        let textBeforeLink = extractText(before: "<a href=", from: bottomDescription) ?? ""
        
        do {
            let doc: Document = try SwiftSoup.parse(bottomDescription)
            
            if let link = try doc.select("a").first() {
                //NOTE: Expectation that API sends valid href
                let href = try link.attr("href")
                let message = try link.text()
                let bottomDescriptionMessage = "\(String(describing: textBeforeLink))\(message)"
                let hyperLinkObject = HyperLinkObject(hyperlink: href, message: bottomDescriptionMessage)
                self.bottomDescription = hyperLinkObject
            }
        } catch let error {
            print("Error parsing HTML: \(error)")
        }
    }
    
    private func extractText(before target: String, from input: String) -> String? {
        if let range = input.range(of: target) {
            let beforeStr = input[..<range.lowerBound]
            return String(beforeStr)
        }
        return nil
    }
    
    
    //Content
    var contentItems: [ContentItem] {
        let content = card?.content ?? [ContentItem]()
        return content
    }
    
    //Image
    var imageUrlString: String {
        return card?.backgroundImage ?? ""
    }
        
}

