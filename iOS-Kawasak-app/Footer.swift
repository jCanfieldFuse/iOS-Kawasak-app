//
//  foter.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 9/30/15.
//  Copyright © 2015 jon.canfield. All rights reserved.
//


import UIKit

class Footer: UIView {
	
	var screen = UIScreen.mainScreen().bounds
	var landingPage = false
	var parentView:UIViewController!
	override func willMoveToSuperview(newSuperview: UIView?) {
		
		self.frame = CGRectMake(0, screen.height - 40, screen.width, 60)
		self.backgroundColor = UIColor.blackColor()
		
		/*
		var kawFooterLabel = UILabel()
		kawFooterLabel.frame = CGRectMake(10, 0 ,70, self.frame.height)
		kawFooterLabel.text = "Kawasaki"
		kawFooterLabel.numberOfLines = 0
		kawFooterLabel.font = UIFont(name: kawFooterLabel.font.fontName, size: 15)
		kawFooterLabel.textColor = UIColor.whiteColor()
		self.addSubview(kawFooterLabel)
		*/
		/*
		var ConnectFooterLabel = UILabel()
		ConnectFooterLabel.frame = CGRectMake(kawFooterLabel.frame.width + 10 , 0 ,70, self.frame.height)
		ConnectFooterLabel.text = "/ connect"
		ConnectFooterLabel.numberOfLines = 0
		ConnectFooterLabel.font = UIFont(name: kawFooterLabel.font.fontName, size: 15)
		ConnectFooterLabel.textColor = UIColor.grayColor()
		self.addSubview(ConnectFooterLabel)
		*/
		if !landingPage{
			let kawaskiConnect = UIImageView()
			let kImage = UIImage(named: "KawasakiConnectLockUp_Footer")
			kawaskiConnect.image = kImage
			kawaskiConnect.frame = CGRectMake(10, 15, ((kImage?.size.width)! * 0.5), ((kImage?.size.height)! * 0.5))
			self.addSubview(kawaskiConnect)
		}else{

			let kawaskiConnect = UILabel()
			kawaskiConnect.userInteractionEnabled = true
			let recognizer = UITapGestureRecognizer(target: self, action:"legal:")
			kawaskiConnect.addGestureRecognizer(recognizer)
			kawaskiConnect.font = UIFont(name: kawaskiConnect.font.fontName, size: 10)
			let	text = "LEGAL TERMS & CONDITIONS"
			let kText:NSMutableAttributedString = NSMutableAttributedString(string: text)
			kText.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSRange(location: 0, length: text.characters.count))
			kawaskiConnect.attributedText = kText
			kawaskiConnect.textColor = UIColor.grayColor()
			kawaskiConnect.frame = CGRectMake(10, 15, kawaskiConnect.intrinsicContentSize().width, kawaskiConnect.intrinsicContentSize().height)
			self.addSubview(kawaskiConnect)

		}
		
		let helpIcon = UIImageView()
		let	helpImage = UIImage(named: "InstructionsIcon_Footer")
		helpIcon.image = helpImage
		helpIcon.frame = CGRectMake((self.frame.width - 10) - 15, 12, (helpImage?.size.width)! * 0.4, (helpImage?.size.height)! * 0.4)
		
		self.addSubview(helpIcon)
		
		let settingsIcon = UIImageView()
		let	settingsimage = UIImage(named: "SettingsIcon_Footer")
		settingsIcon.image = settingsimage
		settingsIcon.frame = CGRectMake( helpIcon.frame.origin.x - 40  ,12,(settingsimage?.size.width)! * 0.4, (settingsimage?.size.height)! * 0.4)
		self.addSubview(settingsIcon)
		
		
	}
	
	
	func legal(recognizer: AnyObject){
		let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Legal")
		parentView.presentViewController(viewController, animated: true, completion: nil)
	}

}


