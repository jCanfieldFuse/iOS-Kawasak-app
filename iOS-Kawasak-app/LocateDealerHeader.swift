//
//  LocateDealerHeader.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 9/30/15.
//  Copyright © 2015 jon.canfield. All rights reserved.
//

import UIKit

class LocateDealerHeader: UIView {
	
	var screen = UIScreen.mainScreen().bounds
	var parentView:UIViewController?
	var locate:Bool = true
	override func willMoveToSuperview(newSuperview: UIView?) {
		//var locateDealerView = UIView()
		self.frame = CGRectMake(0, 0, screen.width * 0.5, screen.width * 0.3)
		
		let dealerRecognizer = UITapGestureRecognizer(target: self, action:"dealer:")
		self.addGestureRecognizer(dealerRecognizer)
		if locate{
			let background = UIImageView()
			background.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
			background.image = UIImage(named: "LocateDealerIcon_TopLeft_Splash")
			self.addSubview(background)
		/*
			let locateDearText = UILabel()
			locateDearText.text = "Locate \nDealer"
			locateDearText.frame = CGRectMake(10, 0, locateDearText.intrinsicContentSize().width, locateDearText.intrinsicContentSize().height * 2)
			locateDearText.backgroundColor = UIColor.redColor()

			locateDearText.numberOfLines = 0
			locateDearText.font = UIFont(name: locateDearText.font.fontName, size: 10)
			locateDearText.textColor = UIColor.whiteColor()
			self.addSubview(locateDearText)
			
			let locateDearImage = UIImageView()
			locateDearImage.image = UIImage(named: "search_icon")
			locateDearImage.frame = CGRectMake(self.frame.width - 50, (self.frame.height * 0.5) - 10, 20, 20)
			//locateDearImage.frame =  CGRectMake(locateDealerView.frame.width - locateDearImage.frame.width, (locateDealerView.frame.height * 0.5) - (locateDearImage.frame.height * 0.5), locateDealerView.frame.width * 0.5, locateDealerView.frame.height)
			self.addSubview(locateDearImage)*/
		}
		else{
			let background = UIImageView()
			background.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
			background.image = UIImage(named: "CloseFindDealerOverlay_Button")
			self.addSubview(background)
		}
		
	}
	
	func dealer(sender: AnyObject!){
		//print(locate)
		//	if let sup = 	self.superview as? UIViewController{
		if locate {
		parentView?.performSegueWithIdentifier("toFindDealer", sender: self)
		//	}
		}else{
			//print("dasdas")
		parentView?.navigationController?.popViewControllerAnimated(true)
//		parentView?.performSegueWithIdentifier("toFindDealer", sender: self)
		}
	}
	
	
}