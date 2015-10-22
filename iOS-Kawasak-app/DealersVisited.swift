//
//  raceResults.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 9/1/15.
//  Copyright (c) 2015 jon.canfield. All rights reserved.
//

import UIKit

class DealersVisited: UIViewController {
	
	var screen = UIScreen.mainScreen().bounds
	var racingHeader = UIView()
	var hamburger = UIButton()
	var racingWebView = UIWebView()
	var footer:Footer = Footer()
	var burger: BurgerMenu = BurgerMenu()
	var fadeView = UIView()
	override func viewDidLoad() {
		super.viewDidLoad()
		
		burger.parentView = self
		self.navigationController?.navigationBarHidden = true
		
		fadeView.frame = CGRectMake(0, 0, screen.width, screen.height)
		fadeView.backgroundColor = UIColor.blackColor()
		fadeView.alpha = 0
		
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
		let myText  = "Explore Vehicles"
		headerText.textColor = UIColor.whiteColor()
		let	myMutableString = NSMutableAttributedString(string: myText, attributes: [NSFontAttributeName:UIFont(name: "Signika-Light", size: 18.0)!])
		myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.grayColor(), range: NSRange(location:7,length:9))
		headerText.attributedText = myMutableString
		headerText.frame = CGRectMake(hamburger.frame.width + 35, 15, screen.width - hamburger.frame.width, 30)
		racingHeader.addSubview(headerText)
		
		let url = NSURL (string: "https://m.kawasaki.com/racing/sxmx");
		let requestObj = NSURLRequest(URL: url!);
		racingWebView.frame = CGRectMake(0, racingHeader.frame.height, screen.width, screen.height)
		racingWebView.loadRequest(requestObj);
		racingWebView.backgroundColor = UIColor.blackColor()
		
		self.view.addSubview(racingHeader)
		racingHeader.addSubview(hamburger)
		racingHeader.addSubview(headerText)
		self.view.addSubview(racingWebView)
		self.view.addSubview(fadeView)
		self.view.addSubview(burger)
		self.view.addSubview(footer)
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func openMenu(sender: UIButton!){
		burger.openMenu()
		
	}
	
	
	
	func goHome(sender:UITapGestureRecognizer){
		//	let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LandingPageNew") as! UIViewController
		//	self.presentViewController(viewController, animated: true, completion: nil)
		
	}
	
	
}


