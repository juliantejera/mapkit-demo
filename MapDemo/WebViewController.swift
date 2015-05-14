//
//  WebViewController.swift
//  MapDemo
//
//  Created by Julian Tejera on 5/14/15.
//  Copyright (c) 2015 Julian Tejera. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    var url: NSURL?
    
    @IBOutlet weak var webView: UIWebView! {
        didSet {
            webView?.delegate = self
        }
    }
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.hidesWhenStopped = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.startAnimating()
        loadWebsite()
    }
    
    func loadWebsite() {
        if let url = self.url {
            self.webView.loadRequest(NSURLRequest(URL: url))
        }
    }
    
    
    // MARK: - Web View Delegate
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicatorView.stopAnimating()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        activityIndicatorView.stopAnimating()
    }
}
