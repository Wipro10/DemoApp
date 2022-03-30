//
//  WebLinkViewController.swift
//  BankDemo
//
//  Created by Santanu on 28/03/2022.
//

import UIKit
import WebKit

class WebLinkViewController: UIViewController, WKNavigationDelegate {
    var weblink : String?
    
    @IBOutlet weak private var newsWebView: WKWebView!
    
    @IBOutlet weak private var loadingIndicator: UIActivityIndicatorView!
    
    init?(coder: NSCoder, websiteLink: String) {
        self.weblink = websiteLink
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use `init(coder:link:)` to initialize an `WebLinkViewController` instance.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNewsWebkit()
    }
    
    // MARK: - Setup LoadNewsWebkit
    func loadNewsWebkit()  {
        newsWebView.accessibilityLabel = AccessibilityLabel.newsWebView
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = Strings.webLink
        newsWebView.navigationDelegate = self
        newsWebView.allowsBackForwardNavigationGestures = true
        loadingIndicator.startAnimating()
        guard let webURL = weblink else { return }
        let newsUrl = URL(string:webURL)
        guard let newsUrl = newsUrl else { return }
        newsWebView.load(URLRequest(url: newsUrl))
    }
    
}
extension WebLinkViewController {
    // MARK: - WKWebView Delegates
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loadingIndicator.stopAnimating()
    }
}
