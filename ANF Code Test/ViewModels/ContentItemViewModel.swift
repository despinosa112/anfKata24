//
//  ContentViewModel.swift
//  ANF Code Test
//
//  Created by Daniel Espinosa on 6/13/24.
//

import Foundation

class ContentItemViewModel {
    
    private var content: ContentItem?
    
    init(content: ContentItem? = nil) {
        self.content = content
    }
    
    var titleText: String {
        return content?.title ?? "TITLE"
    }
    
    var target: String {
        return content?.target ?? "TARGET"
    }
}

