//
//  myKawasakiDetails.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 7/29/15.
//  Copyright (c) 2015 jon.canfield. All rights reserved.
//

import UIKit

class MyKawasakiDetails: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var myWebView: UIWebView!

    @IBOutlet weak var mylabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        myWebView.delegate = self
        let url = NSURL (string: "http://m.fuse-review-kawasaki.com/racing/sxmx/resultsRaw");
        let requestObj = NSURLRequest(URL: url!);
        myWebView.backgroundColor = UIColor.blackColor()
        myWebView.loadRequest(requestObj);
        mylabel.layer.cornerRadius = 8

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        //print("Webview fail with error \(error)");
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    return true;
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        spinner.startAnimating()
    
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
     //   spinner.stopAnimating()
     fadeOut()
    
    }
    
    func fadeOut(){
      
        UIView.animateWithDuration(0.5, animations: {
            self.spinner.alpha = 0
              self.mylabel.alpha = 0
//            self.spinner.hidden = true
  //          self.mylabel.hidden = true
        })
    }
}

