//
//  Legal.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 10/7/15.
//  Copyright © 2015 jon.canfield. All rights reserved.
//

import UIKit

class Legal: UIViewController  {
	var screen = UIScreen.mainScreen().bounds
	let marginRight:CGFloat = 20
	let marginLeft:CGFloat = 20
	let legalAccept: CoreDataModel = CoreDataModel()
	let s:Singleton = Singleton.sharedInstance
	var	bodyCopy = UIScrollView()
	let color:hexColor = hexColor()
	override func viewDidLoad() {
		
		//	self.navigationController?.navigationBarHidden = true
		self.view.backgroundColor = UIColor.blackColor()
		
		
		let racingHeader = UIView()
		racingHeader.frame = CGRectMake(0, 0, screen.width, 60)
		racingHeader.backgroundColor = UIColor.blackColor()
		self.view.addSubview(racingHeader)
		
		
		let headerText = UILabel()
		headerText.text = "Kawasaki"
		headerText.textColor = UIColor.whiteColor()
		//	var	myMutableString = NSMutableAttributedString(string: myText, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 18.0)!])
		//	myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.grayColor(), range: NSRange(location:7,length:9))
		//	headerText.attributedText = myMutableString
		headerText.frame = CGRectMake(marginLeft, 15, screen.width , 30)
		racingHeader.addSubview(headerText)
		
		let racingWebView = UIWebView()
		let url = NSURL (string: s.privacy);
		let requestObj = NSURLRequest(URL: url!);
		racingWebView.frame = CGRectMake(0, racingHeader.frame.height, screen.width, screen.height)
		racingWebView.loadRequest(requestObj);
		racingWebView.backgroundColor = UIColor.blackColor()
		self.view.addSubview(racingWebView)
		
		let bottomButtonContainer = UIView()
		bottomButtonContainer.frame = CGRectMake(0, screen.height - 80, screen.width, 80)
		bottomButtonContainer.backgroundColor = UIColor.blackColor()
		self.view.addSubview(bottomButtonContainer)
		
		/*
		let exitButton = UIButton()
		exitButton.frame = CGRectMake(marginRight, 10, (bottomButtonContainer.frame.width * 0.5) - (10 + marginRight), 50)
		exitButton.addTarget(self, action: "exit:", forControlEvents: UIControlEvents.TouchUpInside)
		exitButton.setImage(UIImage(named: "PrivacyPolicy_EXit_Button"), forState: .Normal)
		bottomButtonContainer.addSubview(exitButton)
		exitButton.backgroundColor = UIColor.redColor()
		*/
		
		let acceptButton = UIButton()
		acceptButton.frame = CGRectMake(20, 15, screen.width - 40, 50)
		acceptButton.setTitle("Accept", forState: UIControlState.Normal)
		acceptButton.addTarget(self, action: "accept:", forControlEvents: UIControlEvents.TouchUpInside)
		acceptButton.titleLabel?.font = UIFont(name:"Signika-Light" , size: 18)
		
		acceptButton.backgroundColor = color.rgbColor(0x02c102)
		bottomButtonContainer.addSubview(acceptButton)
		
		let fadeBL = UIView()
		fadeBL.frame = CGRectMake(0, bottomButtonContainer.frame.origin.y - 20
			, screen.width, 20)
		fadeBL.alpha = 0.5
		fadeBL.backgroundColor = UIColor.blackColor()
		//	self.view.addSubview(fadeBL)
	}
	
	func exit(sender: UIButton!){
		//	UIApplication.sharedApplication().openURL(NSURL(string:"https://www.Kawasaki.com")!)
		
	}
	override func viewDidAppear(animated: Bool) {
	self.navigationController?.toolbarHidden = true
	}
	
	func accept(sender: UIButton!){
		legalAccept.setLegal(true)
		NSUserDefaults.standardUserDefaults().setBool(true, forKey: "GoeSwitchState")
//		s.prefs.setGeoTracking(true)
		s.locationManager.turnOnpush()
		s.locationManager.turnOngeo()
		performSegueWithIdentifier("toNonDealerLanding", sender: self)
		
	}
	override func prefersStatusBarHidden() -> Bool {
		return true
	}
}