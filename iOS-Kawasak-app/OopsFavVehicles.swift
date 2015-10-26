//
//  OopsDealer.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 10/19/15.
//  Copyright © 2015 jon.canfield. All rights reserved.
//

import UIKit

class OopsFavVehicles: UIView {
	var screen = UIScreen.mainScreen().bounds
	var padding:CGFloat = 20
	var marginRight:CGFloat = 25
	let mainCountainer = UIView()
	var parentView:UIViewController!
	var fadeCountainer = UIView()
	let c:hexColor = hexColor()
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		
		
		self.frame = CGRectMake(0, 0, screen.width, screen.height)
		fadeCountainer.frame  = CGRectMake(0, 0, screen.width, screen.height)
		fadeCountainer.backgroundColor = UIColor.blackColor()
		self.addSubview(fadeCountainer)
		fadeCountainer.alpha = 0
		
		//self.backgroundColor = UIColor.blackColor()
		mainCountainer.frame = CGRectMake(0, screen.height * 0.5 - ( screen.height * 0.25) , screen.width, screen.height * 0.4)
		mainCountainer.backgroundColor =  c.rgbColor(0x161719)
		self.addSubview(mainCountainer)
		mainCountainer.userInteractionEnabled = true
		let title = UILabel()
		title.text = "OOPS!"
		title.font = UIFont(name: "Signika-Light", size: 25)
		title.frame = CGRectMake(0, padding, screen.width, title.intrinsicContentSize().height)
		title.textColor = UIColor.whiteColor()
		title.textAlignment = NSTextAlignment.Center
		mainCountainer.addSubview(title)
		
		let body = UILabel()
		body.text = "You do no have any favorite vehicles \nfor this account. Do you want to go to \nMyKawasaki.com to browse vehicles?"
		body.numberOfLines = 3
		body.textAlignment = NSTextAlignment.Center
		body.font = UIFont(name: "Signika-Light", size: 15)
		body.frame = CGRectMake(padding * 3 - 10, title.frame.origin.y + padding * 2.5, screen.width - (padding * 5) , body.intrinsicContentSize().height)
		body.textColor = c.rgbColor(0x7d7e80)
		mainCountainer.addSubview(body)
		
		
		let exitButton = UIButton()
		exitButton.frame = CGRectMake(marginRight, mainCountainer.frame.height - 90, 127,60)
		exitButton.addTarget(self, action: "exit:", forControlEvents: UIControlEvents.TouchUpInside)
		exitButton.setImage(UIImage(named: "cancel"), forState: .Normal)
		mainCountainer.addSubview(exitButton)
		
		let acceptButton = UIButton()
		acceptButton.frame = CGRectMake(mainCountainer.frame.width - (exitButton.frame.width + marginRight), mainCountainer.frame.height - 90, 127,60)
		acceptButton.addTarget(self, action: "accept:", forControlEvents: UIControlEvents.TouchUpInside)
		acceptButton.setImage(UIImage(named: "ok-button"), forState: .Normal)
		mainCountainer.addSubview(acceptButton)
		mainCountainer.alpha = 0
		self.alpha = 0
		
	}
	
	func showMessage(){
		self.alpha = 1
		UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
			
			self.fadeCountainer.alpha = 0.8
			}, completion: { finished in
				self.mainCountainer.alpha = 1
				//				self.turnButtonsOn()
		})
		
		
	}
	
	func exit(sender: AnyObject){
		
		UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
			self.alpha = 0
			self.fadeCountainer.alpha = 0
			}, completion: { finished in
				self.mainCountainer.alpha = 0
				//				self.turnButtonsOn()
		})
	}
	
	func accept(sender: AnyObject){
 	self.parentView?.performSegueWithIdentifier("toFindDealer", sender: self)
		UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
			self.alpha = 1
			self.fadeCountainer.alpha = 1
			}, completion: { finished in
				UIApplication.sharedApplication().openURL(NSURL(string:"http://www.kawasaki.com")!)
				self.mainCountainer.alpha = 0
				self.alpha = 0
				self.fadeCountainer.alpha = 0
				//				self.turnButtonsOn()
		})
		
		
	}
}
