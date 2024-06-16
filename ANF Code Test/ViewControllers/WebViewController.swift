//
//  WebViewController.swift
//  ANF Code Test
//
//  Created by Daniel Espinosa on 6/14/24.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var webView: WKWebView!

    // Initialize with a URL string
    init(urlString: String) {
        super.init(nibName: nil, bundle: nil)
        webView = WKWebView(frame: view.bounds)
        view.addSubview(webView)
        guard let validUrl = URL(string: urlString) else { return }
        let request = URLRequest(url: validUrl)

        // TODO: avoid runtime thread warnings
        DispatchQueue.main.async {
            self.webView.load(request)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
