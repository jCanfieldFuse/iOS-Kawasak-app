//
//  burgerMenu.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 10/5/15.
//  Copyright © 2015 jon.canfield. All rights reserved.
//

import UIKit

class BurgerMenu: UIView {

	var screen = UIScreen.mainScreen().bounds


	var homeContainer = UIView()
	var racingWebView = UIWebView()
	let threeButtonXpos:CGFloat =  20
	var textWidth:CGFloat = 120
	var textHeight:CGFloat = 35
	let rightMargin:CGFloat = 30
	let smButtonWidth:CGFloat = 37
	let smButtonHeight:CGFloat = 42
	var rightView = UIView()
	var parentView:UIViewController!
	let leftOffset:CGFloat = 16
	let yOffest:CGFloat = 5
	let fontSize:CGFloat =  18
	var BuildOnce = true
	var lineTop = UIImageView()
	let c:hexColor = hexColor()
	var s:Singleton! = Singleton.sharedInstance
	var pickView = 0
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		
		print(s.currentStateOfV)
		s.prefs.loadlogInfo()
		
	}
	
	
	func buildScreen(){
	//	self.frame = CGRectMake(0, 0, screen.width, 60)
		self.backgroundColor =  c.rgbColor(0x161719)
		self.frame = CGRectMake(-(screen.width * 0.8), 0, screen.width * 0.8, screen.height)
		
		
		rightView.frame = CGRectMake(screen.width - (screen.width * 0.2)  , 0, screen.width, screen.height)
		rightView.backgroundColor = UIColor.blackColor()
		self.addSubview(rightView)
		rightView.alpha = 0
	
		
		let closeBurgerV = UIView()
		closeBurgerV.frame = CGRectMake(20, 20, 40, 40)

		let topRecognizerV = UITapGestureRecognizer(target: self, action:"closeMenu:")
		closeBurgerV.addGestureRecognizer(topRecognizerV)
		closeBurgerV.userInteractionEnabled = true
		self.addSubview(closeBurgerV)
		
		let closeBurger = UIButton()
		closeBurger.frame = CGRectMake(30, 30, 20, 20)
		closeBurger.setBackgroundImage(UIImage(named: "CLOSE_BUTTON_AllInstances"), forState: .Normal)
		closeBurger.addTarget(self, action: "closeMenu:", forControlEvents: UIControlEvents.TouchUpInside)
		self.addSubview(closeBurger)
		
		homeContainer.frame = CGRectMake((self.frame.width - rightMargin) - (self.frame.width * 0.3),  110, self.frame.width * 0.3, 30)
		homeContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "goHome:"))
		self.addSubview(homeContainer)
		
		let homeText = UILabel()
		homeText.text = "Home"
		homeText.font = UIFont(name: "Signika-Light", size: fontSize)
		homeText.frame =  CGRectMake(homeContainer.frame.width - homeText.intrinsicContentSize().width ,5 , 80, 15)
		homeText.textColor = UIColor.whiteColor()
		homeContainer.addSubview(homeText)
		
		let homeIcon = UIImageView()
		homeIcon.frame = CGRectMake(homeText.frame.origin.x - 20, 5, 14, 14)
		homeIcon.image = UIImage(named: "home-icon")
		homeContainer.addSubview(homeIcon)
		
		// three hex
		var topRightContainer = UIView()
		topRightContainer = UIView(frame: CGRectMake(rightMargin, 160, self.frame.width - rightMargin, (self.frame.height * 0.3)))

		self.addSubview(topRightContainer)
		
		let buttonTop = UIButton()
		buttonTop.frame = CGRectMake(-5, threeButtonXpos + 13, smButtonWidth, smButtonHeight)
		buttonTop.setImage(UIImage(named: "KC_SplashPage_MainHexes_Iddle"), forState: .Normal)
		buttonTop.setTitle("Button", forState: UIControlState.Normal)
		buttonTop.addTarget(self, action: "exploreVehicles:", forControlEvents: UIControlEvents.TouchUpInside)
		buttonTop.alpha = 1
		topRightContainer.addSubview(buttonTop)
		
		let textTop = UILabel()
		let topRecognizer = UITapGestureRecognizer(target: self, action:"exploreVehicles:")
		textTop.addGestureRecognizer(topRecognizer)
		textTop.userInteractionEnabled = true
		textTop.text = "Explore Vehicles"
		textTop.font = UIFont(name: "Signika-Light", size: fontSize)
		textTop.frame =  CGRectMake(topRightContainer.frame.width - topRightContainer.frame.origin.x - rightMargin - textTop.intrinsicContentSize().width  , threeButtonXpos + 10 , textTop.intrinsicContentSize().width, textHeight)
		textTop.textColor = UIColor.whiteColor()
		textTop.textAlignment = NSTextAlignment.Right
		topRightContainer.addSubview(textTop)

		lineTop.frame = CGRectMake(0, textTop.frame.height , textTop.frame.width, 1)
		lineTop.image = UIImage(named: "line2")
		textTop.addSubview(lineTop)
		
		
		let buttonMiddle = UIButton()
		buttonMiddle.frame = CGRectMake(buttonTop.frame.origin.x + (buttonTop.frame.width * 0.5)  , threeButtonXpos + 45, smButtonWidth, smButtonHeight)
		buttonMiddle.setImage(UIImage(named: "KC_SplashPage_MainHexes_Iddle"), forState: .Normal)
		buttonMiddle.setTitle("Button", forState: UIControlState.Normal)
		buttonMiddle.addTarget(self, action: "racing:", forControlEvents: UIControlEvents.TouchUpInside)
		topRightContainer.addSubview(buttonMiddle)
		
		let textMiddle = UILabel()
		let topRecognizerM = UITapGestureRecognizer(target: self, action:"racing:")
		textMiddle.addGestureRecognizer(topRecognizerM)
		textMiddle.userInteractionEnabled = true
		textMiddle.frame =  CGRectMake(textTop.frame.origin.x, threeButtonXpos + 39, textTop.intrinsicContentSize().width , 50)
		textMiddle.text = "Racing"
		textMiddle.font = UIFont(name: "Signika-Light", size: fontSize)
		textMiddle.textColor = UIColor.whiteColor()
		textMiddle.textAlignment = NSTextAlignment.Right
		topRightContainer.addSubview(textMiddle)
		
		let lineMiddle = UIImageView()
		lineMiddle.frame = CGRectMake(0, textMiddle.frame.height - 10, textMiddle.frame.width, 1)
		lineMiddle.image = UIImage(named: "line2")
		textMiddle.addSubview(lineMiddle)
		
		let buttonBottom = UIButton()

		buttonBottom.frame = CGRectMake(buttonTop.frame.origin.x, buttonMiddle.frame.origin.y + 32, smButtonWidth, smButtonHeight)
		buttonBottom.setImage(UIImage(named: "KC_SplashPage_MainHexes_Iddle"), forState: .Normal)
		buttonBottom.setTitle("Button", forState: UIControlState.Normal)
		buttonBottom.addTarget(self, action: "myKawasaki:", forControlEvents: UIControlEvents.TouchUpInside)
		topRightContainer.addSubview(buttonBottom)
		
		let textBottom = UILabel()
		let topRecognizerB = UITapGestureRecognizer(target: self, action:"myKawasaki:")
		textBottom.addGestureRecognizer(topRecognizerB)
		textBottom.userInteractionEnabled = true
		textBottom.frame =  CGRectMake(textTop.frame.origin.x, buttonMiddle.frame.origin.y + 39, textTop.intrinsicContentSize().width , textHeight)
		textBottom.text = "My Kawasaki"
		textBottom.font = UIFont(name: "Signika-Light", size: fontSize)
		textBottom.textColor = UIColor.whiteColor()
		textBottom.textAlignment = NSTextAlignment.Right
		topRightContainer.addSubview(textBottom)
		

		
		let logoutButton = UIButton()
		let logoutImage = UIImage(named: "LOG-OUT_Button_FlyOutMenuOpen")
		logoutButton.frame = CGRectMake((self.frame.width - rightMargin) - ((logoutImage?.size.width)! * 0.5)	, topRightContainer.frame.origin.y + topRightContainer.frame.height - 45 , (logoutImage?.size.width)! * 0.5, (logoutImage?.size.height)! * 0.5)

		//logoutButton.titleLabel?.textColor = UIColor.whiteColor()
		logoutButton.addTarget(self, action: "logIn:", forControlEvents: UIControlEvents.TouchUpInside)
		logoutButton.setImage(UIImage(named: "LOG-OUT_Button_FlyOutMenuOpen"), forState: .Normal)
		logoutButton.setTitle("Logout", forState: UIControlState.Normal)
		self.addSubview(logoutButton)
		
		topRightContainer.frame =  CGRectMake(rightMargin * 2, 140, logoutButton.frame.origin.x + logoutButton.frame.width - (rightMargin * 2) , self.frame.height * 0.3)
		
		let locateDealerView = UIView()
		locateDealerView.frame = CGRect(x: (self.frame.width - rightMargin) - screen.width * 0.5 , y: logoutButton.frame.origin.y + logoutButton.frame.height + 10, width: screen.width * 0.5, height: 40)
		locateDealerView.userInteractionEnabled = true
		self.addSubview(locateDealerView)
		
		let dealCopy = UILabel()
		dealCopy.text = "Locate Dealer"
		dealCopy.font = UIFont(name: "Signika-Light", size: fontSize)
		dealCopy.frame = CGRectMake(locateDealerView.frame.width - dealCopy.intrinsicContentSize().width, 10, dealCopy.intrinsicContentSize().width, dealCopy.intrinsicContentSize().height)
		dealCopy.textColor = UIColor.whiteColor()
		locateDealerView.addSubview(dealCopy)
		
		let dealerIcon = UIImageView()
		let dealImage = UIImage(named: "SearchForDealer_Icon_Splash")
		dealerIcon.image = dealImage
		dealerIcon.frame = CGRectMake(dealCopy.frame.origin.x - ((dealImage?.size.width)! * 0.4) - 5, 14, (dealImage?.size.width)! * 0.4, (dealImage?.size.height)! * 0.4)
		locateDealerView.addSubview(dealerIcon)
		
		let subText = UILabel()
		subText.frame =  CGRectMake(self.frame.width - rightMargin - (textWidth + 10) , locateDealerView.frame.origin.y + locateDealerView.frame.height + 10 , textWidth + 10, textHeight + 10)
		subText.text = "You can always visit us to \nfind out more about your \nfavorite products"
		subText.numberOfLines = 0
		subText.font = UIFont(name: "Signika-Light", size: fontSize - 9)
		subText.textColor = UIColor.grayColor()
		subText.textAlignment = NSTextAlignment.Right
		self.addSubview(subText)
		
		let subKawasaki = UILabel()
		subKawasaki.text = "Kawasaki.com"
		subKawasaki.font = UIFont(name: "Signika-Light", size: fontSize)
		subKawasaki.userInteractionEnabled = true
		subKawasaki.frame =  CGRectMake(self.frame.width - rightMargin - (subKawasaki.intrinsicContentSize().width) ,subText.frame.origin.y + subText.intrinsicContentSize().height + 20 , subKawasaki.intrinsicContentSize().width, subKawasaki.intrinsicContentSize().height )
		let bottomRecognizer = UITapGestureRecognizer(target: self, action:"toKawasaki:")
		subKawasaki.addGestureRecognizer(bottomRecognizer)
		subKawasaki.textColor = UIColor.whiteColor()
		subKawasaki.textAlignment = NSTextAlignment.Right
		self.addSubview(subKawasaki)
	}
	
	func openMenu(){
		if BuildOnce{
			buildScreen()
			BuildOnce = false
		}
		UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
			self.frame.origin.x = 0
			self.rightView.alpha = 0.8
			}, completion: { finished in

		})
		
	}
	func closeMenu(sender: UIButton!){
		UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
			self.frame.origin.x = -(self.screen.width * 0.8)
	self.rightView.alpha = 0
			self.racingWebView.alpha = 1
			}, completion: { finished in

		})
		
	}
	
	func toKawasaki(sender:AnyObject){
						UIApplication.sharedApplication().openURL(NSURL(string:"https://www.kawasaki.com")!)
	}
	func goHome(sender: UITapGestureRecognizer){
			parentView?.navigationController?.popViewControllerAnimated(true)
		
	}
	func exploreVehicles(sender: AnyObject){
		//parentView?.navigationController?.popViewControllerAnimated(false)
		if pickView == 0{
		(parentView as? YourHistory)?.passIn = 1
		}else{
		(parentView as? RaceResults)?.passIn = 1
		}
		parentView?.performSegueWithIdentifier("toLanding", sender: self)

	}

	func racing(sender: AnyObject){
		//parentView?.navigationController?.popViewControllerAnimated(false)
		if pickView == 0{
		(parentView as? YourHistory)?.passIn = 2
		}else{
			(parentView as? RaceResults)?.passIn = 1
	}
		parentView?.performSegueWithIdentifier("toLanding", sender: self)
		
	}
	func myKawasaki(sender: AnyObject){
		//parentView?.navigationController?.popViewControllerAnimated(false)
		if pickView == 0{
		(parentView as? YourHistory)?.passIn = 3
		}else{
					(parentView as? RaceResults)?.passIn = 1
		}
		parentView?.performSegueWithIdentifier("toLanding", sender: self)
		
	}
	
	
}





