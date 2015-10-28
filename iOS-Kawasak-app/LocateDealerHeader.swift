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

		}
		else{
			let background = UIImageView()
			background.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
			background.image = UIImage(named: "CloseFindDealerOverlay_Button")
			self.addSubview(background)
		}
		
	}
	
	func dealer(sender: AnyObject!){
		if locate {
		parentView?.performSegueWithIdentifier("toFindDealer", sender: self)
		}else{
		parentView?.navigationController?.popViewControllerAnimated(true)
		}
	}
	
	func openDealerFinder(){
		s.currentStateOfV = 0
		parentView?.performSegueWithIdentifier("toFindDealer", sender: self)
	}
}