//
//  ShowMyConnect.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 10/23/15.
//  Copyright © 2015 jon.canfield. All rights reserved.
//

import Foundation
import UIKit

class ShowMyConnect: UIViewController {
	
	var screen = UIScreen.mainScreen().bounds
	var racingHeader = UIView()
	var hamburger = UIButton()

	//	var footer:Footer = Footer()
	var burger: BurgerMenu = BurgerMenu()

	var passedURL: String = ""
	var passIn:Int = 0
	
	
	let imageView = UIImageView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		burger.pickView = 2
		burger.parentView = self
		self.navigationController?.navigationBarHidden = true
	
		
		
		
		
		let racingHeader = UIView()
		racingHeader.frame = CGRectMake(0, 0, screen.width, 60)
		racingHeader.backgroundColor = UIColor.blackColor()
		self.view.addSubview(racingHeader)
		

		
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
		
		let image = UIImageView()
		image.frame = CGRectMake(0, 0, screen.width, screen.height)
		image.image = UIImage(named: "connect")
		self.view.addSubview(image)
		
		self.view.addSubview(racingHeader)
		racingHeader.addSubview(hamburger)
		racingHeader.addSubview(headerText)

		self.view.addSubview(burger)
		//	self.view.addSubview(footer)
		
		
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


