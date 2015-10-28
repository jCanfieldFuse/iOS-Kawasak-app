//
//  raceResults.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 9/1/15.
//  Copyright (c) 2015 jon.canfield. All rights reserved.
//

import UIKit

class FoundBeaconProduct: UIViewController, UIWebViewDelegate {
	
	var screen = UIScreen.mainScreen().bounds
	var racingHeader = UIView()
	var hamburger = UIButton()
	var racingWebView = UIWebView()
	var burger: BurgerMenu = BurgerMenu()
	var fadeView = UIView()
	var passedURL: String = ""
	var passIn:Int = 0
	var closeURL = ""
	
	let imageTest = UIImageView()
		var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
	override func viewDidLoad() {
		super.viewDidLoad()
		burger.pickView = 1
		burger.parentView = self
		self.navigationController?.navigationBarHidden = true
		racingWebView.delegate = self
		fadeView.frame = CGRectMake(0, 0, screen.width, screen.height)
		fadeView.backgroundColor = UIColor.blackColor()
		fadeView.alpha = 0.8
		
		let hamburgerV = UIView()
		hamburgerV.frame = CGRectMake(20, 15, 40,40)
		hamburgerV.backgroundColor = UIColor.blackColor()
		let topRecognizer = UITapGestureRecognizer(target: self, action:"openMenu:")
		hamburgerV.addGestureRecognizer(topRecognizer)
		hamburgerV.userInteractionEnabled = true
		racingHeader.addSubview(hamburgerV)
		
		
//		let url = NSURL (string: passedURL)

		let urlParse = passedURL.characters.split{$0 == "*"}.map(String.init)
		closeURL = urlParse[1] as String
		let tmpUrl = urlParse[0] as String
		let url = NSURL (string: tmpUrl)
		let requestObj = NSURLRequest(URL: url!)
		racingWebView.frame = CGRectMake(0, 0, screen.width, screen.height)
		racingWebView.loadRequest(requestObj);
		racingWebView.backgroundColor = UIColor.blackColor()
		
		self.view.addSubview(racingWebView)
		self.view.addSubview(fadeView)
		

		
		let background = UIButton()
		background.frame = CGRectMake(0, 0, screen.width * 0.5, screen.width * 0.3)
		background.addTarget(self, action: "close:", forControlEvents: .TouchUpInside)
		background.setBackgroundImage(UIImage(named: "CloseFindDealerOverlay_Button"), forState: .Normal)
		self.view.addSubview(background)
		actInd.frame = CGRectMake((screen.width * 0.5) - 20, (screen.height * 0.5) - 20, 40.0, 40.0);
		actInd.hidesWhenStopped = true
		actInd.activityIndicatorViewStyle =	UIActivityIndicatorViewStyle.WhiteLarge
		self.view.addSubview(actInd)
	}
	
	func webViewDidStartLoad(webView: UIWebView) {
				actInd.startAnimating()

		
	}
	
	func close (sender: AnyObject){
		// closeURL push stop
		let url = NSURL(string: "https://Kawasakimobileappapi.gofuse.com/api/BeaconMetric/\(closeURL)")!
		let request = NSURLRequest(URL: url)
		NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
		}
		self.dismissViewControllerAnimated(true, completion: {})
	}
	
	func webViewDidFinishLoad(webView: UIWebView) {
		actInd.stopAnimating()
		UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
			self.fadeView.alpha = 0
			}, completion: { finished in
		})
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func openMenu(sender: UIButton!){
		burger.openMenu()
		
	}
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if (segue.identifier == "toLanding") {
			let svc = segue.destinationViewController as! LandingPageNew
			svc.dataPassed = passIn
		}
	}
	
}


