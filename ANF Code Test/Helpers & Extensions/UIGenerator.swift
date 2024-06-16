//
//  UIGenerator.swift
//  ANF Code Test
//
//  Created by Daniel Espinosa on 6/15/24.
//

import UIKit

class UIGenerator: NSObject {
    
    static func createContentButton(title: String, targetUrl: String) -> LinkButton {
        let button = LinkButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.0
        button.targetURLString = targetUrl
        return button
    }

}
