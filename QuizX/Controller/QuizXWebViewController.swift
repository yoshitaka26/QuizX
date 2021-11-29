//
//  QuizXWebViewController.swift
//  QuizX
//
//  Created by Yoshitaka Tanaka on 2021/11/28.
//  Copyright © 2021 Yoshitaka. All rights reserved.
//

import UIKit
import WebKit

class QuizXWebViewController: UIViewController {
    
    @IBOutlet weak var webViewContainer: UIView!
    
    var webView: WKWebView!
    
    required init?(coder: NSCoder) {
        // 2 WKWebViewConfiguration の生成
        let configuration = WKWebViewConfiguration()
        
        configuration.applicationNameForUserAgent = "Version/1.0 ShinyBrowser/1.0"
        // 3 WKWebView に Configuration を引き渡し initialize
        webView = WKWebView(frame: .zero, configuration: configuration)

        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 4 WKUIDelegate の移譲先として self を登録
        webView.uiDelegate = self
        // 5 WKNavigationDelegate の移譲先として self を登録
        webView.navigationDelegate = self
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        // 7 URLオブジェクトを生成
        let myURL = URL(string:"https://quizx.net")
        // 8 URLRequestオブジェクトを生成
        let myRequest = URLRequest(url: myURL!)
        
        webViewContainer.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.widthAnchor.constraint(equalTo: webViewContainer.widthAnchor),
            webView.heightAnchor.constraint(equalTo: webViewContainer.heightAnchor)
        ])
        
        // 9 URLを WebView にロード
        webView.load(myRequest)
    }
}

// MARK: - 10 WKWebView ui delegate
extension QuizXWebViewController: WKUIDelegate {
    // delegate
}

// MARK: - 11 WKWebView WKNavigation delegate
extension QuizXWebViewController: WKNavigationDelegate {
    // delegate
}
