//
//  MyLogin.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 10/14/15.
//  Copyright © 2015 jon.canfield. All rights reserved.
//

import UIKit

class MyLogin: UIViewController,UITextFieldDelegate  {
	var screen = UIScreen.mainScreen().bounds
	let padding:CGFloat = 40
	let topPadding:CGFloat = 10
	let burger: BurgerMenu = BurgerMenu()
	let color:hexColor = hexColor()
	let fontSize:CGFloat = 15
	let username = UITextField()
	let c:hexColor = hexColor()
	override func viewDidLoad() {
		self.navigationController?.navigationBarHidden = true
		self.view.backgroundColor =  c.rgbColor(0x161719)
		burger.parentView = self
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

		
		let mainContainer = UIView()
		mainContainer.frame = CGRectMake(0, racingHeader.frame.height, screen.size.width, screen.size.height)
		mainContainer.backgroundColor = UIColor.blackColor()
		self.view.addSubview(mainContainer)
		
		let titleLable = UILabel()
		let myText = "My Kawasaki"
		titleLable.textColor = UIColor.whiteColor()
		let	myMutableString = NSMutableAttributedString(string: myText, attributes: [NSFontAttributeName:UIFont(name: "Signika-Light", size: 30.0)!])
		myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.grayColor(), range: NSRange(location:3,length:8))
		titleLable.attributedText = myMutableString
		titleLable.frame = CGRectMake(mainContainer.frame.origin.x + padding, mainContainer.frame.origin.y + topPadding - 20, titleLable.intrinsicContentSize().width, titleLable.intrinsicContentSize().height)


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
		myContinue.backgroundColor = color.rgbColor(0x02c102)

		mainContainer.addSubview(myContinue)
		
		let createAccount = UILabel()
	  let text = "Don't have a My Kawasaki account yet? \nCreate one"
		createAccount.numberOfLines = 2
		let kText:NSMutableAttributedString = NSMutableAttributedString(string: text)
		kText.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSRange(location: 0, length: text.characters.count))
		createAccount.attributedText = kText
		createAccount.frame = CGRectMake(titleLable.frame.origin.x, myContinue.frame.origin.y + (myContinue.frame.height + 20), mainContainer.frame.width - (padding * 2), 35 )
		createAccount.textColor = UIColor.grayColor()
		createAccount.font = UIFont(name: "Signika-Light", size: fontSize - 5)
		mainContainer.addSubview(createAccount)
		
		let forgot = UIButton()
		let myImage = UIImage(named: "Forgot-Password_Button_KawasakiConnect_LogIn")
		forgot.frame = CGRectMake((screen.width * 0.5) - 60, createAccount.frame.origin.y + (createAccount.frame.height + 20), 120, 30 )
		forgot.setBackgroundImage(myImage, forState: .Normal)
		mainContainer.addSubview(forgot)
		self.view.addSubview(burger)
	}
	

	func openMenu(sender: UIButton!){
		burger.openMenu()
		
	}

	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
		view.endEditing(true)
	
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
}