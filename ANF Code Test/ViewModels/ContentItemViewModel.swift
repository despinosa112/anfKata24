//
//  ContentViewModel.swift
//  ANF Code Test
//
//  Created by Daniel Espinosa on 6/13/24.
//

import Foundation

class ContentItemViewModel {
    
    private var contentItem: ContentItem?
    
    init(contentItem: ContentItem? = nil) {
        self.contentItem = contentItem
    }
    
    var titleText: String {
        return contentItem?.title ?? ""
    }
    
    var target: String {
        return contentItem?.target ?? ""
    }
}

