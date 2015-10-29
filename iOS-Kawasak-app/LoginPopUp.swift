//
//  MyLogin.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 10/14/15.
//  Copyright © 2015 jon.canfield. All rights reserved.
//

import UIKit

class LoginPopUp: UIView, UITextFieldDelegate  {
	var screen = UIScreen.mainScreen().bounds
	let padding:CGFloat = 40
	let topPadding:CGFloat = 10
	let color:hexColor = hexColor()
	let fontSize:CGFloat = 15
	let username: UITextField = UITextField()
	let c:hexColor = hexColor()
	var parentView:UIViewController!
	let fadeCountainer = UIView()
	let mainContainer = UIView()
	let password = UITextField()
	let s:Singleton = Singleton.sharedInstance
	
	
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
		let myText = "My Kawasaki™"
		titleLable.textColor = UIColor.whiteColor()
		let	myMutableString = NSMutableAttributedString(string: myText, attributes: [NSFontAttributeName:UIFont(name: "Signika-Light", size: 30.0)!])
		myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.grayColor(), range: NSRange(location:3,length:9))
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
		
		
		
		password.frame = CGRectMake(titleLable.frame.origin.x, username.frame.origin.y + (username.frame.height + 20), mainContainer.frame.width - (padding * 2), 25 )
		password.placeholder = "Password"
		password.secureTextEntry = true
		password.font = UIFont(name: "Signika-Light", size: fontSize)
		password.backgroundColor = UIColor.whiteColor()
		mainContainer.addSubview(password)
		
		let myContinue = UIButton()
		myContinue.frame = CGRectMake(titleLable.frame.origin.x, password.frame.origin.y + (password.frame.height + 27), mainContainer.frame.width - (padding * 2), 40 )
		myContinue.contentHorizontalAlignment = .Center
		myContinue.titleLabel?.font = UIFont(name:"Signika-Light" , size: fontSize)
		myContinue.setTitle("Continue", forState: UIControlState.Normal)
		myContinue.addTarget(self, action: "continueLoged:", forControlEvents: UIControlEvents.TouchUpInside)
		myContinue.backgroundColor = color.rgbColor(0x02c102)
		
		mainContainer.addSubview(myContinue)
		
		let createAccount = UILabel()
		let text = "Don't have a My Kawasaki account yet? \nClick here to create one"
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
	
	func continueLoged(sender: UIButton){
					print("fff")		
		if let user = username.text, passwd = password.text {
			
			let url = "https://Kawasakimobileappapi.gofuse.com/mobileappapi/AuthenticateAppUser/\(user)/\(passwd)/\(s.prefs.getAppID())/\(s.prefs.getPhID())"
			let endpoint = NSURL(string: url)
			if let data = NSData(contentsOfURL: endpoint!){
				if let json: NSDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as? NSDictionary, let items = json["Login"] as? NSArray {
					for item in items {
						if let valid = item["isValidUser"] as? Bool, hasFav = item["hasFavorites"] as? Bool, hasOwned = item["hasOwned"] as? Bool, hasPref = item["hasPreferredDealer"] as? Bool{
							self.s.prefs.setValidUser(valid)
							self.s.prefs.setHasFavorites(hasFav)
							self.s.prefs.sethasOwned(hasOwned)
							self.s.prefs.setprefDealer(hasPref)
							if valid{
								login()
								s.prefs.username(user)
								s.prefs.password(passwd)
								print("what")
							}else{
							//	print("not valid")
							//	bad.showMessage()
							}
						}
					}
				}else{
					let alertView = UIAlertController(title: "Oops", message: "our username and or passeord you entered was incorrect", preferredStyle: .Alert)
					alertView.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
					parentView.presentViewController(alertView, animated: true, completion: nil)
				}
			}
		}
	}

	func login(){
		s.prefs.setValidUser(true)

		UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
			self.alpha = 0
			self.endEditing(true)
			self.fadeCountainer.alpha = 0
			}, completion: { finished in
				self.mainContainer.alpha = 0
		})
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
				UIApplication.sharedApplication().openURL(NSURL(string:"http://www.kawasak.com")!)
				self.mainContainer.alpha = 0
				self.alpha = 0
				self.fadeCountainer.alpha = 0
				//				self.turnButtonsOn()
		})
		
		
	}
}
