//
//  Card.swift
//  ANF Code Test
//
//  Created by Daniel Espinosa on 6/13/24.
//

import Foundation

struct Card: Codable {
    
    let title: String?
    let backgroundImage: String?
    let content: [ContentItem]?
    let promoMessage: String?
    let topDescription: String?
    let bottomDescription: String?
}
