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

	var closeBurger = UIButton()
	var homeContainer = UIView()
	var racingWebView = UIWebView()
	let threeButtonXpos:CGFloat =  20
	var textWidth:CGFloat = 120
	var textHeight:CGFloat = 50
	let rightMargin:CGFloat = 30
	let smButtonWidth:CGFloat = 50
	let smButtonHeight:CGFloat = 57
	var rightView = UIView()
	var parentView:UIViewController!
	let leftOffset:CGFloat = 16
	let yOffest:CGFloat = 5
	override func didMoveToSuperview() {
		super.didMoveToSuperview()

		self.frame = CGRectMake(0, 0, screen.width, 60)
		self.backgroundColor = UIColor.blackColor()
		self.frame = CGRectMake(-(screen.width * 0.8), 0, screen.width * 0.8, screen.height)
		
		
		rightView.frame = CGRectMake(screen.width - (screen.width * 0.2)  , 0, screen.width, screen.height)
		rightView.backgroundColor = UIColor.blackColor()
		self.addSubview(rightView)
		rightView.alpha = 0
		
		closeBurger.frame = CGRectMake(0, 20, 40, 40)
		closeBurger.setTitle("X", forState: UIControlState.Normal)
		closeBurger.addTarget(self, action: "closeMenu:", forControlEvents: UIControlEvents.TouchUpInside)
		self.addSubview(closeBurger)
		
		homeContainer.frame = CGRectMake((self.frame.width - rightMargin) - (self.frame.width * 0.3),  90, self.frame.width * 0.3, 30)
		homeContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "goHome:"))

		self.addSubview(homeContainer)
		
		let homeText = UILabel()
		homeText.text = "Home"
		homeText.frame =  CGRectMake(homeContainer.frame.width - homeText.intrinsicContentSize().width ,0 , 80, 15)
		homeText.textColor = UIColor.whiteColor()
		homeContainer.addSubview(homeText)
		
		let homeIcon = UIImageView()
		homeIcon.frame = CGRectMake(homeText.frame.origin.x - 15, 2, 10, 10)
		homeIcon.image = UIImage(named: "home-icon")
		homeContainer.addSubview(homeIcon)
		
		var topRightContainer = UIView()
		topRightContainer = UIView(frame: CGRectMake(rightMargin, 160, self.frame.width - rightMargin, (self.frame.height * 0.3)))
		self.addSubview(topRightContainer)
		
		let buttonTop = UIButton()
		buttonTop.frame = CGRectMake(leftOffset, threeButtonXpos - 4, smButtonWidth, smButtonHeight)
		buttonTop.setImage(UIImage(named: "KC_SplashPage_MainHexes_Iddle"), forState: .Normal)
		buttonTop.setTitle("Button", forState: UIControlState.Normal)
		buttonTop.addTarget(self, action: "topButton:", forControlEvents: UIControlEvents.TouchUpInside)
		buttonTop.alpha = 1
		topRightContainer.addSubview(buttonTop)
		
		let textTop = UILabel()
		textTop.frame =  CGRectMake(buttonTop.frame.width + 15, threeButtonXpos , textWidth, textHeight)
		textTop.text = "Explore Vehicles"
		textTop.userInteractionEnabled = true
		textTop.textColor = UIColor.whiteColor()
		textTop.textAlignment = NSTextAlignment.Right
		topRightContainer.addSubview(textTop)
		
		let buttonMiddle = UIButton()
		buttonMiddle.frame = CGRectMake(buttonTop.frame.origin.x + (buttonTop.frame.width * 0.5)  , threeButtonXpos + 39, smButtonWidth, smButtonHeight)
		buttonMiddle.setImage(UIImage(named: "KC_SplashPage_MainHexes_Iddle"), forState: .Normal)
		buttonMiddle.setTitle("Button", forState: UIControlState.Normal)
		buttonMiddle.addTarget(self, action: "topButton:", forControlEvents: UIControlEvents.TouchUpInside)
		topRightContainer.addSubview(buttonMiddle)
		
		let textMiddle = UILabel()
		textMiddle.frame =  CGRectMake(textTop.frame.origin.x, threeButtonXpos + 39, textWidth, 50)
		textMiddle.text = "Racing"
		textMiddle.textColor = UIColor.whiteColor()
		textMiddle.textAlignment = NSTextAlignment.Right
		topRightContainer.addSubview(textMiddle)
		
		
		let buttonBottom = UIButton()
		buttonBottom.frame = CGRectMake(buttonTop.frame.origin.x, buttonMiddle.frame.origin.y + 43, smButtonWidth, smButtonHeight)
		buttonBottom.setImage(UIImage(named: "KC_SplashPage_MainHexes_Iddle"), forState: .Normal)
		buttonBottom.setTitle("Button", forState: UIControlState.Normal)
		buttonBottom.addTarget(self, action: "topButton:", forControlEvents: UIControlEvents.TouchUpInside)
		topRightContainer.addSubview(buttonBottom)
		
		let textBottom = UILabel()
		textBottom.frame =  CGRectMake(textTop.frame.origin.x, buttonMiddle.frame.origin.y + 39, textWidth, textHeight)
		textBottom.text = "My Kawasaki"
		textBottom.textColor = UIColor.whiteColor()
		textBottom.textAlignment = NSTextAlignment.Right
		topRightContainer.addSubview(textBottom)
		
		let logoutButton = UIButton()
		logoutButton.frame = CGRectMake((self.frame.width - rightMargin) - 80	, topRightContainer.frame.origin.y + topRightContainer.frame.width - 60, 80, 24)
		//logoutButton.backgroundColor = UIColor.grayColor()
		//logoutButton.titleLabel?.textColor = UIColor.whiteColor()
		logoutButton.setImage(UIImage(named: "LOG-OUT_Button_FlyOutMenuOpen"), forState: .Normal)
		logoutButton.setTitle("Logout", forState: UIControlState.Normal)
		self.addSubview(logoutButton)
		
		let subText = UILabel()
		subText.frame =  CGRectMake(self.frame.width - rightMargin - (textWidth + 10) , topRightContainer.frame.origin.y + topRightContainer.frame.height + 20, textWidth + 10, textHeight + 10)
		subText.text = "Get Savings Get Savings Get Savings Get Savings Get Savings Get Savings"
		subText.numberOfLines = 0
		subText.font =  UIFont(name: (subText.font.fontName), size: 10)
		subText.textColor = UIColor.grayColor()
		subText.textAlignment = NSTextAlignment.Right
		self.addSubview(subText)
		
		let subKawasaki = UILabel()
		subKawasaki.text = "Kawasaki.com"
		subKawasaki.frame =  CGRectMake(self.frame.width - rightMargin - (subKawasaki.intrinsicContentSize().width) ,subText.frame.origin.y + subText.intrinsicContentSize().height + 40, subKawasaki.intrinsicContentSize().width, subKawasaki.intrinsicContentSize().height )
		subKawasaki.font =  UIFont(name: (subText.font.fontName), size: 10)
		subKawasaki.textColor = UIColor.whiteColor()
		subKawasaki.textAlignment = NSTextAlignment.Right
		self.addSubview(subKawasaki)
		
		
		let locateDealerView = UIView()
		locateDealerView.frame = CGRectMake(self.frame.width - rightMargin - (50), subKawasaki.frame.origin.y + 40, 50, 50)
		self.addSubview(locateDealerView)
		
		let locateDealerButton = UIButton()
		locateDealerButton.frame = CGRectMake(0, 0, locateDealerView.frame.width, locateDealerView.frame.height)
		locateDealerButton.setImage(UIImage(named: "hexagonG"), forState: .Normal)
		locateDealerView.addSubview(locateDealerButton)
		
		let searchImage = UIImageView()
		searchImage.frame = CGRectMake((locateDealerView.frame.width * 0.5) - 5, 5, 10, 10)
		searchImage.image = UIImage(named: "search_icon")
		locateDealerView.addSubview(searchImage)
		
		let searchText = UILabel()
		searchText.frame = CGRectMake(10, 10, 40, 40)
		searchText.text = "LOCATE DEALER"
		searchText.numberOfLines = 0
		searchText.textColor = UIColor.whiteColor()
		searchText.font =  UIFont(name: (subText.font.fontName), size: 8)
		
		locateDealerView.addSubview(searchText)

	}
	func openMenu(){
		UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
			self.frame.origin.x = 0
			self.rightView.alpha = 0.8
	////		self.tintView.alpha = 0.8
			}, completion: { finished in
				print("DUDE")
		})
		
	}
	func closeMenu(sender: UIButton!){
		UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
			self.frame.origin.x = -(self.screen.width * 0.8)
	self.rightView.alpha = 0
			self.racingWebView.alpha = 1
			}, completion: { finished in
				print("hey buddy")
		})
		
	}
	
	func goHome(sender: UITapGestureRecognizer){
		print("GO HOME")
		let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LandingPageNew") as! UIViewController
		parentView.presentViewController(viewController, animated: true, completion: nil)
		
	}
	
}





