//
//  DealerWelcome.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 9/30/15.
//  Copyright © 2015 jon.canfield. All rights reserved.
//

import UIKit
import AVFoundation


class DealerWelcome: UIViewController  {
	var screen = UIScreen.mainScreen().bounds
	var locDealer:LocateDealerHeader = LocateDealerHeader()
	var welcomeLabel = UILabel()
	var centerView = UIView()
	var dealerName = UILabel()
	var kawasakiButton = UIButton()
	let buttonSize:CGFloat = 100
	let threeButtonXpos:CGFloat =  20
	var textWidth:CGFloat = 150
	var textHeight:CGFloat = 50
	var topRightContainer = UIView()
	var textTop = UILabel()
	let smButtonWidth:CGFloat = 50
	let fontSizeRight: CGFloat = 20
	let smButtonHeight:CGFloat = 57
	var buttonTop = UIButton()
	var mainContainer = UIView()
	var buttonMiddle = UIButton()
	var lineTop = UIImageView()
	var textMiddle = UILabel()
	var middleTitle = UILabel()
	var buttonBottom = UIButton()
	var textBottom = UILabel()
	let bButtonWidth:CGFloat = 110
	let bButtonHeight:CGFloat = 127
	let fontSize:CGFloat = 20
	//var footer:Footer = Footer()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.navigationBarHidden = true
		mainContainer.frame = CGRectMake(0, 0, screen.width, screen.height)
		
		self.view.addSubview(mainContainer)
		
		centerView.frame = CGRectMake(0, screen.height * 0.5 - (bButtonHeight * 0.5) , screen.width, screen.width * 0.4)
		self.view.addSubview(centerView)
		var topRightContainer = UIView()
		
		self.view.addSubview(topRightContainer)
		
		
		welcomeLabel.text = "Welcome!"
		welcomeLabel.font = UIFont(name: "Signika-Bold", size: fontSize + 2)
		welcomeLabel.textColor = UIColor.whiteColor()
		welcomeLabel.frame = CGRectMake(20, 25, welcomeLabel.intrinsicContentSize().width, welcomeLabel.intrinsicContentSize().height)
		welcomeLabel.textAlignment = NSTextAlignment.Left
		self.centerView.addSubview(welcomeLabel)
		
		
		dealerName.text = "Mission Hills Kawasaki"
		dealerName.font = UIFont(name: "Signika-light", size: fontSize)
		dealerName.frame = CGRectMake(20, welcomeLabel.frame.origin.y + 10 ,  dealerName.intrinsicContentSize().width * 0.8, dealerName.intrinsicContentSize().height * 3)
		dealerName.numberOfLines = 0
		dealerName.textColor = UIColor.whiteColor()
		dealerName.textAlignment = NSTextAlignment.Left
		self.centerView.addSubview(dealerName)
		
		kawasakiButton.frame = CGRectMake((screen.width  - (buttonSize + 35) ), 5, bButtonWidth , bButtonHeight)
		kawasakiButton.setBackgroundImage(UIImage(named: "KC_SplashPage_MainHexes_Iddle"), forState: .Normal)
		kawasakiButton.setBackgroundImage(UIImage(named: "KC_SplashPage_MainHexes_Pressed"), forState: UIControlState.Highlighted)
		kawasakiButton.setTitle("Explore Vehicles", forState: UIControlState.Normal)
		kawasakiButton.addTarget(self, action: "explore:", forControlEvents: UIControlEvents.TouchUpInside)
		kawasakiButton.titleLabel?.font = UIFont(name:"Signika-Light" , size: fontSize)
		kawasakiButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		kawasakiButton.titleEdgeInsets =  UIEdgeInsets(top:0 , left: 0, bottom: 0, right: 0)
		kawasakiButton.contentHorizontalAlignment = .Center
		kawasakiButton.titleLabel!.numberOfLines = 0
		//		kawasakiButton.titleLabel?.font = UIFont(name: (kawasakiButton.titleLabel?.font.fontName)!, size: fontSize)
		//kawasakiButton.addTarget(self, action: "buttonsTop:", forControlEvents: UIControlEvents.TouchUpInside)
		self.centerView.addSubview(kawasakiButton)
		
		//these are the buttons on the top right
		topRightContainer.frame = CGRectMake(screen.width * 0.4 , (centerView.frame.origin.y + centerView.frame.height + 10 )  , screen.width, (screen.height * 0.3))
		buttonTop.frame = CGRectMake(0, 0, smButtonWidth, smButtonHeight)
		buttonTop.setBackgroundImage(UIImage(named: "KC_SplashPage_MainHexes_Iddle"), forState: .Normal)
		buttonTop.setBackgroundImage(UIImage(named: "KC_SplashPage_MainHexes_Pressed"), forState: UIControlState.Highlighted)
		buttonTop.addTarget(self, action: "sequeTop:", forControlEvents: UIControlEvents.TouchUpInside)
		buttonTop.alpha = 1
		topRightContainer.addSubview(buttonTop)
		
		textTop.frame =  CGRectMake((buttonTop.frame.origin.x) + 50, 0, textWidth, textHeight)
		let topRecognizer = UITapGestureRecognizer(target: self, action:"sequeTop:")
		textTop.addGestureRecognizer(topRecognizer)
		textTop.userInteractionEnabled = true
		textTop.textColor = UIColor.whiteColor()
		textTop.font = UIFont(name: "Signika-Light", size: fontSizeRight)
		textTop.text = "See Offers"
		textTop.textAlignment = NSTextAlignment.Right
		topRightContainer.addSubview(textTop)
		
		lineTop.frame = CGRectMake(0, textTop.frame.height - 10, textTop.frame.width, 1)
		lineTop.image = UIImage(named: "line2")
		textTop.addSubview(lineTop)
		
		buttonMiddle.frame = CGRectMake(buttonTop.frame.origin.x + (buttonTop.frame.width * 0.5)  ,  43, smButtonWidth, smButtonHeight)
		buttonMiddle.setBackgroundImage(UIImage(named: "KC_SplashPage_MainHexes_Iddle"), forState: .Normal)
		buttonMiddle.setBackgroundImage(UIImage(named: "KC_SplashPage_MainHexes_Pressed"), forState: UIControlState.Highlighted)
		buttonMiddle.addTarget(self, action: "sequeMiddle:", forControlEvents: UIControlEvents.TouchUpInside)
		topRightContainer.addSubview(buttonMiddle)
		textMiddle.frame =  CGRectMake(textTop.frame.origin.x,  39, textWidth, 50)
		
		let MiddleRecognizer = UITapGestureRecognizer(target: self, action:"sequeMiddle:")
		textMiddle.userInteractionEnabled = true
		textMiddle.addGestureRecognizer(MiddleRecognizer)
		textMiddle.textColor = UIColor.whiteColor()
		textMiddle.font = UIFont(name: "Signika-Light", size: fontSizeRight)
		textMiddle.text = "Racing"
		textMiddle.textAlignment = NSTextAlignment.Right
		topRightContainer.addSubview(textMiddle)
		
		
		let lineMiddle = UIImageView()
		lineMiddle.frame = CGRectMake(0, textMiddle.frame.height - 10, textMiddle.frame.width, 1)
		lineMiddle.image = UIImage(named: "line2")
		textMiddle.addSubview(lineMiddle)
		
		buttonBottom.frame = CGRectMake(buttonTop.frame.origin.x, buttonMiddle.frame.origin.y + 43, smButtonWidth, smButtonHeight)
		buttonBottom.setBackgroundImage(UIImage(named: "KC_SplashPage_MainHexes_Iddle"), forState: .Normal)
		buttonBottom.setBackgroundImage(UIImage(named: "KC_SplashPage_MainHexes_Pressed"), forState: UIControlState.Highlighted)
		buttonBottom.addTarget(self, action: "sequeButtom:", forControlEvents: UIControlEvents.TouchUpInside)
		topRightContainer.addSubview(buttonBottom)
		
		textBottom.frame =  CGRectMake(textTop.frame.origin.x, buttonMiddle.frame.origin.y + 43, textWidth, textHeight)
		let bottomRecognizer = UITapGestureRecognizer(target: self, action:"sequeButtom:")
		textBottom.addGestureRecognizer(bottomRecognizer)
		textBottom.font = UIFont(name: "Signika-Light", size: fontSizeRight)
		textBottom.userInteractionEnabled = true
		textBottom.textColor = UIColor.whiteColor()
		textBottom.textAlignment = NSTextAlignment.Right
		textBottom.text = "My Kawasaki™"
		topRightContainer.addSubview(textBottom)
		
		let lineBottom = UIImageView()
		lineBottom.frame = CGRectMake(0, textBottom.frame.height - 10, textBottom.frame.width, 1)
		lineBottom.image = UIImage(named: "line2")
		textBottom.addSubview(lineBottom)
		//	topRightContainer.frame = CGRectMake(screen.width + 50, (self.kawasakiButton.frame.origin.y + self.kawasakiButton.frame.width * 0.5)  + 10 - ((buttonBottom.frame.origin.y + buttonBottom.frame.height) * 0.5), screen.width, (buttonBottom.frame.origin.y + buttonBottom.frame.height))
		
		
		//self.view.addSubview(footer)
  self.view.addSubview(topRightContainer)
		
	}
	
	func explore(sender: UIButton!){
		//print("seg top")
		
	}
	
	func sequeTop(sender: UIButton!){
		//print("seg top")
		
	}
	
	func sequeMiddle(sender: UIButton!){
		//print("seg middle")
		
	}
	
	func sequeButtom(sender: UIButton!){
		//print("seg botton")
	}
	
	
}