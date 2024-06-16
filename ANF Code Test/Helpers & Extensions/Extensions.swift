//
//  Extensions.swift
//  ANF Code Test
//
//  Created by Daniel Espinosa on 6/14/24.
//

import Foundation
import UIKit

extension UIView {
    static func spacer(size: CGFloat = 10, for axis: NSLayoutConstraint.Axis = .horizontal) -> UIView {
        let spacer = UIView()
        if axis == .horizontal {
            spacer.widthAnchor.constraint(equalToConstant: size).isActive = true
        } else {
            spacer.heightAnchor.constraint(equalToConstant: size).isActive = true
        }
        return spacer
    }
}

extension UIImage {
    func scaleToFitScreen() -> UIImage? {
        guard let window = UIApplication.shared.windows.first else { return nil }
        let screenSize = window.bounds.size

        let imageAspectRatio = size.width / size.height
        let screenAspectRatio = screenSize.width / screenSize.height

        var newSize: CGSize
        if imageAspectRatio > screenAspectRatio {
            // Image is wider than the screen
            newSize = CGSize(width: screenSize.width, height: screenSize.width / imageAspectRatio)
        } else {
            // Image is taller than the screen
            newSize = CGSize(width: screenSize.height * imageAspectRatio, height: screenSize.height)
        }

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        draw(in: CGRect(origin: .zero, size: newSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return scaledImage
    }
}
