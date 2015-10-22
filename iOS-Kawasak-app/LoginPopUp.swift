//
//  MyLogin.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 10/14/15.
//  Copyright © 2015 jon.canfield. All rights reserved.
//

import UIKit

class LoginPopUp: UIView,UITextFieldDelegate  {
	var screen = UIScreen.mainScreen().bounds
	let padding:CGFloat = 40
	let topPadding:CGFloat = 10
	let color:hexColor = hexColor()
	let fontSize:CGFloat = 15
	let username = UITextField()
	let c:hexColor = hexColor()
	var parentView:UIViewController!
	let fadeCountainer = UIView()
	let mainContainer = UIView()

	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		
		
		self.frame = CGRectMake(0, 0, screen.width, screen.height)
		fadeCountainer.frame  = CGRectMake(0, 0, screen.width, screen.height)
		fadeCountainer.backgroundColor = UIColor.blackColor()
		self.addSubview(fadeCountainer)
		fadeCountainer.alpha = 0
		
		
		mainContainer.frame = CGRectMake(20, 60, screen.size.width - 40, screen.size.height - 140)
		mainContainer.backgroundColor = UIColor.blackColor()
		mainContainer.userInteractionEnabled = true
		self.addSubview(mainContainer)
		
		mainContainer.frame = CGRectMake(20, 60, screen.size.width - 40, screen.size.height - 140)
		mainContainer.backgroundColor =  c.rgbColor(0x161719)
		self.addSubview(mainContainer)
		mainContainer.userInteractionEnabled = true
		
		
		
		
		
		let close = UIImageView()
		let kImage = UIImage(named: "CLOSE_BUTTON_AllInstances")
		close.image = kImage
		close.userInteractionEnabled = true
		let tap1: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "exit:")
		close.addGestureRecognizer(tap1)
		close.frame = CGRectMake((screen.width * 0.5) - 20, 10, 20, 20)
		mainContainer.addSubview(close)

		
		let titleLable = UILabel()
		let myText = "My Kawasaki"
		titleLable.textColor = UIColor.whiteColor()
		let	myMutableString = NSMutableAttributedString(string: myText, attributes: [NSFontAttributeName:UIFont(name: "Signika-Light", size: 30.0)!])
		myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.grayColor(), range: NSRange(location:3,length:8))
		titleLable.attributedText = myMutableString
		titleLable.frame = CGRectMake(mainContainer.frame.origin.x + 20 , mainContainer.frame.origin.y + topPadding - 20, titleLable.intrinsicContentSize().width, titleLable.intrinsicContentSize().height)
		
		mainContainer.addSubview(titleLable)
		
		let subTitle = UILabel()
		subTitle.text = "Please Log in to continue"
		subTitle.frame = CGRectMake(titleLable.frame.origin.x ,titleLable.frame.origin.y + (titleLable.intrinsicContentSize().height + 12), subTitle.intrinsicContentSize().width, subTitle.intrinsicContentSize().height)
		subTitle.textColor = UIColor.whiteColor()
		subTitle.font = UIFont(name: "Signika-Light", size: fontSize)
		mainContainer.addSubview(subTitle)
		
		
		username.delegate = self
		username.frame = CGRectMake(titleLable.frame.origin.x, subTitle.frame.origin.y + (subTitle.intrinsicContentSize().height + 25), mainContainer.frame.width - (padding * 2), 25 )
		username.backgroundColor = UIColor.whiteColor()
		username.placeholder = "E-Mail"
		username.font = UIFont(name: "Signika-Light", size: fontSize)
		mainContainer.addSubview(username)
		
		
		let password = UITextField()
		password.frame = CGRectMake(titleLable.frame.origin.x, username.frame.origin.y + (username.frame.height + 20), mainContainer.frame.width - (padding * 2), 25 )
		password.placeholder = "password"
		password.font = UIFont(name: "Signika-Light", size: fontSize)
		password.backgroundColor = UIColor.whiteColor()
		mainContainer.addSubview(password)
		
		let myContinue = UIButton()
		myContinue.frame = CGRectMake(titleLable.frame.origin.x, password.frame.origin.y + (password.frame.height + 27), mainContainer.frame.width - (padding * 2), 40 )
		myContinue.contentHorizontalAlignment = .Center
		myContinue.titleLabel?.font = UIFont(name:"Signika-Light" , size: fontSize)
		myContinue.setTitle("Continue", forState: UIControlState.Normal)
		myContinue.addTarget(self, action: "exit:", forControlEvents: UIControlEvents.TouchUpInside)
		myContinue.backgroundColor = color.rgbColor(0x02c102)
		
		mainContainer.addSubview(myContinue)
		
		let createAccount = UILabel()
		let text = "Don't have a My Kawasaki account yet? \nCreate one"
		createAccount.numberOfLines = 2
		let kText:NSMutableAttributedString = NSMutableAttributedString(string: text)
		createAccount.userInteractionEnabled = true
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "creatPassword:")
		createAccount.addGestureRecognizer(tap)
		kText.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSRange(location: 0, length: text.characters.count))
		createAccount.attributedText = kText
		createAccount.frame = CGRectMake(titleLable.frame.origin.x, myContinue.frame.origin.y + (myContinue.frame.height + 20), mainContainer.frame.width - (padding * 2), 35 )
		createAccount.textColor = UIColor.grayColor()
		createAccount.font = UIFont(name: "Signika-Light", size: fontSize - 5)
		mainContainer.addSubview(createAccount)
		
		let forgot = UIButton()
		let myImage = UIImage(named: "Forgot-Password_Button_KawasakiConnect_LogIn")
		forgot.addTarget(self, action: "forgotPassword:", forControlEvents: UIControlEvents.TouchUpInside)
		forgot.frame = CGRectMake((screen.width * 0.5) - 80, createAccount.frame.origin.y + (createAccount.frame.height + 20), 120, 30 )
		forgot.setBackgroundImage(myImage, forState: .Normal)
		mainContainer.addSubview(forgot)
		
		self.alpha = 0
		//		self.addSubview(burger)
	}
	
	/*
	func openMenu(sender: UIButton!){
	burger.openMenu()
	
	}
	*/
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
		self.endEditing(true)
		
		super.touchesBegan(touches, withEvent: event)
	}
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		
		return true;
	}
	
	func textFieldDidEndEditing(textField: UITextField) {
		
	}
	
	func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
		
		return true
	}
	
	
	func forgotPassword(sender: AnyObject){
				UIApplication.sharedApplication().openURL(NSURL(string:"https://m.kawasaki.com/account/forgotPassword")!)
	}
	
	func creatPassword(sender: AnyObject){
				UIApplication.sharedApplication().openURL(NSURL(string:"https://m.kawasaki.com/account/register")!)
	}
	
	func showMessage(){
		self.alpha = 1
		UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
			self.fadeCountainer.alpha = 0.8
			}, completion: { finished in
				self.mainContainer.alpha = 1
				//				self.turnButtonsOn()
		})
		
		
	}
	
	func continueLoged (sender: UIButton){


//				self.parentView.myKawasakiText()
	}
	
	
	func exit(sender: AnyObject){
		
		UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
			self.alpha = 0
			self.fadeCountainer.alpha = 0
			}, completion: { finished in
				self.mainContainer.alpha = 0
				//				self.turnButtonsOn()
		})
	}
	
	func accept(sender: AnyObject){
 	self.parentView?.performSegueWithIdentifier("toFindDealer", sender: self)
		UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
			self.alpha = 1
			self.fadeCountainer.alpha = 1
			}, completion: { finished in
				UIApplication.sharedApplication().openURL(NSURL(string:"http://www.apple.com")!)
				self.mainContainer.alpha = 0
				self.alpha = 0
				self.fadeCountainer.alpha = 0
				//				self.turnButtonsOn()
		})
		
		
	}
}