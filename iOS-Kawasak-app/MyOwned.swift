//
//  raceResults.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 9/1/15.
//  Copyright (c) 2015 jon.canfield. All rights reserved.
//

import UIKit

class MyOwned: UIViewController, UIWebViewDelegate {
	
	var screen = UIScreen.mainScreen().bounds
	var racingHeader = UIView()
	var hamburger = UIButton()
	var racingWebView = UIWebView()
	//	var footer:Footer = Footer()
	var burger: BurgerMenu = BurgerMenu()
	var fadeView = UIView()
	var passedURL: String = ""
	var passIn:Int = 0
	var spinner = UIActivityIndicatorView()
	override func viewDidLoad() {
		super.viewDidLoad()
		burger.pickView = 1
		burger.parentView = self
		self.navigationController?.navigationBarHidden = true
		racingWebView.delegate = self
		fadeView.frame = CGRectMake(0, 0, screen.width, screen.height)
		fadeView.backgroundColor = UIColor.blackColor()
		fadeView.alpha = 0.8
		
		
		
		let racingHeader = UIView()
		racingHeader.frame = CGRectMake(0, 0, screen.width, 60)
		racingHeader.backgroundColor = UIColor.blackColor()
		self.view.addSubview(racingHeader)
		
		let hamburgerV = UIView()
		hamburgerV.frame = CGRectMake(20, 15, 40,40)
		hamburgerV.backgroundColor = UIColor.blackColor()
		let topRecognizer = UITapGestureRecognizer(target: self, action:"openMenu:")
		hamburgerV.addGestureRecognizer(topRecognizer)
		hamburgerV.userInteractionEnabled = true
		racingHeader.addSubview(hamburgerV)
		
		let hamburger = UIButton()
		hamburger.frame = CGRectMake(20, 15, 30,30)
		hamburger.setBackgroundImage(UIImage(named: "HamburgerMenu_Button_Top"), forState: .Normal)
		hamburger.contentHorizontalAlignment = .Center
		hamburger.addTarget(self, action: "openMenu:", forControlEvents: UIControlEvents.TouchUpInside)
		racingHeader.addSubview(hamburger)
		let headerText = UILabel()
		
		let myText  = "My Owned"
		headerText.textColor = UIColor.whiteColor()
		let	myMutableString = NSMutableAttributedString(string: myText, attributes: [NSFontAttributeName:UIFont(name: "Signika-Light", size: 18.0)!])
		myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.grayColor(), range: NSRange(location:2,length:6))
		headerText.attributedText = myMutableString
		headerText.frame = CGRectMake(hamburger.frame.width + 35, 15, screen.width - hamburger.frame.width, 30)
		racingHeader.addSubview(headerText)
		
		let url = NSURL (string: passedURL)
		//print("passed url \(passedURL)")
		
		let requestObj = NSURLRequest(URL: url!)
		racingWebView.frame = CGRectMake(0, racingHeader.frame.height, screen.width, screen.height)
		racingWebView.loadRequest(requestObj);
		racingWebView.backgroundColor = UIColor.blackColor()
		
		spinner.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
		spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
		spinner.contentMode = .Center
		spinner.startAnimating()
		//		self.view.addSubview(spinner)
		
		self.view.addSubview(racingHeader)
		racingHeader.addSubview(hamburger)
		racingHeader.addSubview(headerText)
		self.view.addSubview(racingWebView)
		self.view.addSubview(fadeView)
		self.view.addSubview(burger)
		
	}
	func webViewDidStartLoad(webView: UIWebView) {
		
		//	animateImageView()
		
	}
	
	func webViewDidFinishLoad(webView: UIWebView) {
		//		imageView.removeFromSuperview()
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
	
	
	/*
	func goHome(sender:UITapGestureRecognizer){
	//	let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LandingPageNew") as! UIViewController
	//	self.presentViewController(viewController, animated: true, completion: nil)
	
	}
	
	*/
}


