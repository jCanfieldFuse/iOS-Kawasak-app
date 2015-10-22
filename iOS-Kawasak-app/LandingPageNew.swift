//
//  LandingPageNew.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 9/28/15.
//  Copyright © 2015 jon.canfield. All rights reserved.
//

import UIKit
import AVFoundation


class LandingPageNew: UIViewController  {
	var screen = UIScreen.mainScreen().bounds
	let buttonWidth:CGFloat = 100
	let buttonHeight:CGFloat = 115
	
	let smButtonWidth:CGFloat = 50
	let smButtonHeight:CGFloat = 57
	
	let bButtonWidth:CGFloat = 110
	let bButtonHeight:CGFloat = 127
	var halfButton:CGFloat?
	let offset:CGFloat = 35
	let fontSize:CGFloat = 20
	let fontSizeRight: CGFloat = 20
	var mainContainer = UIView()
	var buttonTop = UIButton()
	var buttonMiddle = UIButton()
	var buttonBottom = UIButton()
	var backButton = UIButton()
	var kawasakiButton = UIButton()
	var racingButton = UIButton()
	var exploreButton = UIButton()
	var MyKawButton = UIButton()
	
	var textTop = UILabel()
	var textMiddle = UILabel()
	var textBottom = UILabel()
	var middleTitle = UILabel()
	var topRightContainer = UIView()
	var lineTop = UIImageView()
	var currentState = ""
	
	var currentSelectState:String = "none"
	let leftOffset:CGFloat = 16
	let yOffest:CGFloat = 5
	var textWidth:CGFloat = 80
	var textHeight:CGFloat = 50
	var threeButtonXpos:CGFloat =  20
	var buttonPos:CGFloat = 0
	
	var s:Singleton = Singleton.sharedInstance
	var video:VideoPlayer = VideoPlayer()
	var sequeState:Int?
	var locDealer:LocateDealerHeader = LocateDealerHeader()
	var legalCheck: CoreDataModel = CoreDataModel()
	
	var oDealer: OopsDealer = OopsDealer()
	var oOwned: OopsOwned = OopsOwned()
	var oVehicle: OopsVehicles = OopsVehicles()
	var oFav: OopsFavVehicles = OopsFavVehicles()
	var logDel:LoginPopUp = LoginPopUp()
	var testBool = false
	var dataPassed = 0
	var url = ""

	var playerLayer:AVPlayerLayer = {
		
		let path = NSBundle.mainBundle().pathForResource("video", ofType: "mp4")
		let tmpPath = NSURL(fileURLWithPath: path!)
		let player = AVPlayer(URL:  tmpPath)
		
		player.muted = true
		player.allowsExternalPlayback = false
		player.appliesMediaSelectionCriteriaAutomatically = false
		var error:NSError?
		
		// This is needed so it would not cut off users audio (if listening to music etc.
		do {
			try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
		} catch var error1 as NSError {
			error = error1
		} catch {
			fatalError()
		}
		if error != nil {
			print(error)
		}
		
		var playerLayer = AVPlayerLayer(player: player)
		
		playerLayer.videoGravity = "AVLayerVideoGravityResizeAspectFill"
		playerLayer.backgroundColor = UIColor.blackColor().CGColor
		player.play()
		
		return playerLayer
		}()
	
	override func prefersStatusBarHidden() -> Bool {
		return true;
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		if !s.prefs.isReg(){
			s.prefs.registerID(UIDevice.currentDevice().identifierForVendor!.UUIDString)
		}
		//isReg()
		locDealer.locate = true
		locDealer.parentView = self
		logDel.parentView = self
		s.locationManager.parentView = self
		//self.navigationController?.navigationBarHidden = true
		halfButton = buttonHeight * 0.5
		self.view.layer.addSublayer(self.playerLayer)
		playerLayer.frame = self.view.frame
		NSNotificationCenter.defaultCenter().addObserver(self, selector:"playerDidReachEnd", name:AVPlayerItemDidPlayToEndTimeNotification, object:nil)
		
		mainContainer.frame = CGRectMake(0, 0, screen.width, screen.height)
		let overLay = UIImageView()
		overLay.frame = CGRectMake(0, 0, screen.width, screen.height)
		overLay.image = UIImage(named: "SPLASHPAGES_VIGNETTE-OVER_VIDEO")
		self.view.addSubview(overLay)
		self.view.addSubview(mainContainer)
		//locate dealer view
		topRightContainer = UIView()
		self.view.addSubview(topRightContainer)
		buttonPos = screen.width * 0.52
		
		//buttons
		kawasakiButton.frame = CGRectMake(buttonPos - (halfButton! + 9), (screen.height * 0.5) - (halfButton! + 15), bButtonWidth  , bButtonHeight )
		kawasakiButton.setBackgroundImage(UIImage(named: "KC_SplashPage_LogoHex_"), forState: .Normal)
		kawasakiButton.setBackgroundImage(UIImage(named: "KC_SplashPage_LogoHex_"), forState: UIControlState.Highlighted)
		//kawasakiButton.addTarget(self, action: "buttonsTop:", forControlEvents: UIControlEvents.TouchUpInside)
		mainContainer.addSubview(kawasakiButton)
		
		
		racingButton.frame = CGRectMake(buttonPos + (offset - 27) - leftOffset, ((screen.height * 0.5) - buttonWidth) - (offset + 11) - yOffest, buttonWidth, buttonHeight)
		racingButton.setBackgroundImage(UIImage(named: "KC_SplashPage_MainHexes_Iddle"), forState: .Normal)
		racingButton.setTitle("Racing", forState: UIControlState.Normal)
		racingButton.setBackgroundImage(UIImage(named: "KC_SplashPage_MainHexes_Pressed"), forState: UIControlState.Highlighted)
		racingButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		racingButton.titleEdgeInsets =  UIEdgeInsets(top:0 , left: 0, bottom: 0, right: 0)
		racingButton.contentHorizontalAlignment = .Center
		racingButton.titleLabel?.font = UIFont(name:"Signika-Light" , size: fontSize)
		racingButton.addTarget(self, action: "racingText:", forControlEvents: UIControlEvents.TouchUpInside)
		mainContainer.addSubview(racingButton)
		
		
		exploreButton.frame = CGRectMake(buttonPos + (halfButton! ) - leftOffset, (screen.height * 0.5) - (halfButton! + 3) - yOffest, buttonWidth, buttonHeight)
		exploreButton.setBackgroundImage(UIImage(named: "KC_SplashPage_MainHexes_Iddle"), forState: .Normal)
		exploreButton.setBackgroundImage(UIImage(named: "KC_SplashPage_MainHexes_Pressed"), forState: UIControlState.Highlighted)
		exploreButton.setTitle("Explore Vehicles", forState: UIControlState.Normal)
		exploreButton.titleLabel!.numberOfLines = 0
		exploreButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		exploreButton.titleEdgeInsets =  UIEdgeInsets(top:0 , left: 0, bottom: 0, right: 0)
		exploreButton.contentHorizontalAlignment = .Center
		exploreButton.titleLabel?.font = UIFont(name: "Signika-Light", size: fontSize)
		exploreButton.addTarget(self, action: "exploreText:", forControlEvents: UIControlEvents.TouchUpInside)
		mainContainer.addSubview(exploreButton)
		
		
		MyKawButton.frame = CGRectMake(buttonPos + (offset - 27) - leftOffset, ((screen.height * 0.5) + (halfButton!)) - (offset - 2 ) - yOffest, buttonWidth, buttonHeight)
		MyKawButton.setBackgroundImage(UIImage(named: "KC_SplashPage_MainHexes_Iddle"), forState: .Normal)
		MyKawButton.setBackgroundImage(UIImage(named: "KC_SplashPage_MainHexes_Pressed"), forState: UIControlState.Highlighted)
		//		let	myMutableString = NSMutableAttributedString(string: "      My Kawasaki", attributes: [NSFontAttributeName:UIFont(name: "Signika-Light", size: fontSize)!])
		//	myMutableString.addAttribute(NSForegroundColorAttributeName, value: "™", range: NSRange(location:2,length:3))
		//MyKawButton.titleLabel?.attributedText = myMutableString
		
		MyKawButton.setTitle("      My Kawasaki™", forState: UIControlState.Normal)
		MyKawButton.titleLabel!.numberOfLines = 0
		MyKawButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		MyKawButton.titleEdgeInsets =  UIEdgeInsets(top:0 , left: 10, bottom: 0, right: 10)
		MyKawButton.contentHorizontalAlignment = .Center
		//	MyKawButton.titleLabel?.font = UIFont(name: "Signika-Light", size: fontSize)
		MyKawButton.addTarget(self, action: "loginD:", forControlEvents: UIControlEvents.TouchUpInside)
		mainContainer.addSubview(MyKawButton)
		
		
		
		//these are the buttons on the top right
		topRightContainer.frame = CGRectMake(screen.width + 50, (self.kawasakiButton.frame.origin.y + self.kawasakiButton.frame.width * 0.5)  + 10 - ((screen.height * 0.3) * 0.5), screen.width, (screen.height * 0.3))
		buttonTop.frame = CGRectMake(topRightContainer.frame.width * 0.4 - (self.kawasakiButton.frame.width * 0.5), 0, smButtonWidth, smButtonHeight)
		buttonTop.setBackgroundImage(UIImage(named: "KC_SplashPage_MainHexes_Iddle"), forState: .Normal)
		buttonTop.setBackgroundImage(UIImage(named: "KC_SplashPage_MainHexes_Pressed"), forState: UIControlState.Highlighted)
		buttonTop.addTarget(self, action: "sequeTop:", forControlEvents: UIControlEvents.TouchUpInside)
		buttonTop.alpha = 1
		topRightContainer.addSubview(buttonTop)
		
		textTop.frame =  CGRectMake((mainContainer.frame.width - 110) - (self.kawasakiButton.frame.width * 0.5), 0, textWidth, textHeight)
		
		let topRecognizer = UITapGestureRecognizer(target: self, action:"sequeTop:")
		textTop.addGestureRecognizer(topRecognizer)
		textTop.userInteractionEnabled = true
		textTop.textColor = UIColor.whiteColor()
		textTop.font = UIFont(name: "Signika-Light", size: fontSizeRight)
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
		textMiddle.textAlignment = NSTextAlignment.Right
		topRightContainer.addSubview(textMiddle)
		
		
		let lineMiddle = UIImageView()
		lineMiddle.frame = CGRectMake(0, textMiddle.frame.height - 10, textMiddle.frame.width, 1)
		lineMiddle.image = UIImage(named: "line2")
		textMiddle.addSubview(lineMiddle)
		
		
		middleTitle.frame =  CGRectMake(-15 ,  39, 150, 50)
		middleTitle.text = "Racing"
		middleTitle.font = UIFont(name: "Signika-Light", size: fontSizeRight)
		middleTitle.numberOfLines = 0
		middleTitle.textColor = UIColor.whiteColor()
		middleTitle.textAlignment = NSTextAlignment.Left
		topRightContainer.addSubview(middleTitle)
		
		
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
		topRightContainer.addSubview(textBottom)
		
		let lineBottom = UIImageView()
		lineBottom.frame = CGRectMake(0, textBottom.frame.height - 10, textBottom.frame.width, 1)
		lineBottom.image = UIImage(named: "line2")
		textBottom.addSubview(lineBottom)
		topRightContainer.frame = CGRectMake(screen.width + 50, (self.kawasakiButton.frame.origin.y + self.kawasakiButton.frame.width * 0.5)  + 10 - ((buttonBottom.frame.origin.y + buttonBottom.frame.height) * 0.5), screen.width, (buttonBottom.frame.origin.y + buttonBottom.frame.height))
		/*
		backButton.frame = CGRectMake(0, 25, 80,80)
		backButton.setTitle("<", forState: UIControlState.Normal)
		backButton.titleLabel!.numberOfLines = 0
		backButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		backButton.contentHorizontalAlignment = .Center
		backButton.titleLabel?.font = UIFont(name: (kawasakiButton.titleLabel?.font.fontName)!, size: 25)
		backButton.addTarget(self, action: "goBack:", forControlEvents: UIControlEvents.TouchUpInside)
		topRightContainer.addSubview(backButton)
		*/
		self.view.addSubview(locDealer)
		self.view.addSubview(oDealer)
		self.view.addSubview(oOwned)
		self.view.addSubview(oFav)
		self.view.addSubview(logDel)
		oDealer.parentView = self
		print("DATA PASSED\(dataPassed)")
		
		if(dataPassed == 1){
		racingSetup()
		}
		if(dataPassed == 2){
			exploreSetup()
		}
		if(dataPassed == 3){
			myKawasakiSetup()
		}
	}
	
	override func viewWillAppear(animated: Bool) {
		/*
		if(dataPassed == 1){
			racingSetup()
		}
		if(dataPassed == 2){
			exploreSetup()
		}
		if(dataPassed == 3){
			myKawasakiSetup()
			
		}
		else{
			goBack()
		}*/
		self.playerLayer.player!.play()
		
	}
	
	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)
		NSNotificationCenter.defaultCenter().removeObserver(self)
	}
	
	override func viewDidAppear(animated: Bool) {
	/*	if(dataPassed == 1){
			racingSetup()
		}
		if(dataPassed == 2){
		exploreSetup()
		}
		if(dataPassed == 3){
			myKawasakiSetup()		}
		else{
			goBack()
		}
		*/
		self.playerLayer.player!.play()
	}
	
	override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
		//	super.willAnimateRotationToInterfaceOrientation(toInterfaceOrientation, duration: duration)
		playerLayer.frame = self.view.frame
	}
	
	func playerDidReachEnd(){
		self.playerLayer.player!.seekToTime(kCMTimeZero)
		self.playerLayer.player!.play()
	}
	
	func buttonsTop() {
		UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
			//	self.mainContainer.frame = CGRectMake(-400, 0, self.screen.width, self.screen.height)
			self.kawasakiButton.frame = CGRectMake(-(self.bButtonWidth ) * 0.5, (self.screen.height * 0.5) - (self.halfButton! + 15), self.bButtonWidth , self.bButtonHeight )
			self.racingButton.frame = CGRectMake((self.screen.width * 0.5) + (self.offset - 24), ((self.screen.height * 0.5) - self.buttonWidth) - (self.offset + 2), 0, 0)
			self.exploreButton.frame = CGRectMake((self.screen.width * 0.5) + (self.halfButton! ), (self.screen.height * 0.5) - (self.halfButton! + 3), 0, 0)
			self.MyKawButton.frame = CGRectMake((self.screen.width * 0.5) + (self.offset - 24), ((self.screen.height * 0.5) + (self.halfButton!)) - (self.offset + 4), 0, 0)
			self.middleTitle.text = self.currentState
			}, completion: { finished in
				UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
					self.topRightContainer.frame.origin.x = self.kawasakiButton.frame.width * 0.5 + 20
					self.kawasakiButton.setBackgroundImage(UIImage(named: "GoBackToMainNavArrow_HexButton"), forState: .Normal)
					self.kawasakiButton.setBackgroundImage(UIImage(named: "GoBackToMainNavArrow_HexButton"), forState: .Highlighted)
					}, completion: { finished in
						UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
							self.textTop.alpha = 1
							self.textMiddle.alpha = 1
							self.textBottom.alpha = 1
							//	self.kawasakiButton.setTitle("<", forState: UIControlState.Normal)
							//	self.kawasakiButton.titleLabel?.font = UIFont(name: (self.kawasakiButton.titleLabel?.font.fontName)!, size: self.fontSize + 5)
							//	self.kawasakiButton.contentHorizontalAlignment = .Right
							//self.kawasakiButton.removeTarget(self, action: "buttonTop:", forControlEvents: UIControlEvents.TouchUpInside)
							self.kawasakiButton.addTarget(self, action: "callGoBack:", forControlEvents: UIControlEvents.TouchUpInside)
							//	self.kawasakiButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (self.buttonWidth - 60) * 0.5)
							}, completion: { finished in
								print("done")
						})
				})
				
  })
		
		
	}
	
	func goBack() {
		UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
			self.topRightContainer.frame.origin.x = self.screen.width + 50
			}, completion: { finished in
				UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
					self.kawasakiButton.frame = CGRectMake((self.buttonPos) - (self.halfButton! + 9), (self.screen.height * 0.5) - (self.halfButton! + 15), self.bButtonWidth  , self.bButtonHeight )
					self.racingButton.frame = CGRectMake((self.buttonPos) + (self.offset - 27) - self.leftOffset, ((self.screen.height * 0.5) - self.buttonWidth) - (self.offset + 11) - self.yOffest, self.buttonWidth, self.buttonHeight)
					self.exploreButton.frame = CGRectMake((self.buttonPos) + (self.halfButton! ) - self.leftOffset, (self.screen.height * 0.5) - (self.halfButton! + 3) - self.yOffest, self.buttonWidth, self.buttonHeight)
					self.MyKawButton.frame = CGRectMake((self.buttonPos) + (self.offset - 27) - self.leftOffset, ((self.screen.height * 0.5) + (self.halfButton!)) - (self.offset - 2 ) - self.yOffest, self.buttonWidth, self.buttonHeight)
					self.kawasakiButton.setBackgroundImage(UIImage(named: "KC_SplashPage_LogoHex_"), forState: .Normal)
					self.kawasakiButton.setBackgroundImage(UIImage(named: "KC_SplashPage_LogoHex_"), forState: .Highlighted)
					//		self.kawasakiButton.contentHorizontalAlignment = .Center
					//		self.kawasakiButton.titleLabel?.font = UIFont(name: (self.kawasakiButton.titleLabel?.font.fontName)!, size: self.fontSize)
					//	self.kawasakiButton.removeTarget(self, action: "callGoBack:", forControlEvents: UIControlEvents.TouchUpInside)
					//	self.kawasakiButton.addTarget(self, action: "buttonTop:", forControlEvents: UIControlEvents.TouchUpInside)
					//	self.kawasakiButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
					}, completion: { finished in
						UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
							
							self.textTop.alpha = 1
							self.textMiddle.alpha = 1
							self.textBottom.alpha = 1
							}, completion: { finished in
								self.turnButtonsOn()
						})
				})
				
  })
		
	}
	func segue(sender: UIButton!){
		let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PagedScrollViewController")
		self.presentViewController(viewController, animated: true, completion: nil)
	}
	
	func callGoBack(sender: UIButton!){
		goBack()
	}
	
	
	
	
	func racingText(sender: UIButton!){
		racingSetup()
	}
	
	func exploreText(sender: UIButton!){
		exploreSetup()
	}
	
	func myKawasakiText(sender: UIButton!){
		myKawasakiSetup()
		
	}
	
	func myKawasakiSetup(){
		currentSelectState = "myKawasaki"
		currentState = "My \nKawasaki™"
		textTop.text = ""
		textTop.text = "Favorites"
		textMiddle.text = "Owned"
		textBottom.text = "Dealer"
		buttonsTop()

	}
	func racingSetup(){
		currentSelectState = "racing"
		currentState = "racing"
		textTop.text = "News"
		textMiddle.text = "Results"
		textBottom.text = "Schedule"
		buttonsTop()
		
	}
	func exploreSetup(){
		currentSelectState = "explore"
		buttonTop.alpha = 0
		textTop.alpha = 0
		lineTop.alpha = 0
		currentState = "Explore \nVehicles"
		textTop.text = ""
		textMiddle.text = "Explore"
		textBottom.text = "History"
		buttonsTop()
	}
	
	func turnButtonsOn(){
		buttonBottom.alpha = 1
		lineTop.alpha = 1
		textBottom.alpha = 1
		buttonMiddle.alpha = 1
		textMiddle.alpha = 1
		buttonTop.alpha = 1
		textTop.alpha = 1
	}
	
	func opendODealer(recognizer: AnyObject){
		//	self.oDealer.showMessage()
		self.oOwned.showMessage()
	}
	
	func loginD(sender: AnyObject){
		if !testBool{
			self.logDel.showMessage()
			testBool = true
		}
		else{
			currentSelectState = "myKawasaki"
			currentState = "My \nKawasaki™"
			textTop.text = ""
			textTop.text = "Favorites"
			textMiddle.text = "Owned"
			textBottom.text = "Dealer"
			buttonsTop()
		}
	}
	
	func sequeTop(sender: UIButton!){
		
		switch currentSelectState {
		case "racing":
			self.url = s.news
			self.performSegueWithIdentifier("toRaceResults", sender: self)
		case "explore":
			self.performSegueWithIdentifier("toRaceResults", sender: self)
		case "myKawasaki":
						self.url = s.myFav
//			self.oFav.showMessage()
			//	self.performSegueWithIdentifier("toMyFavorites", sender: self)
		default: print("32")
		}
	}
	
	func sequeMiddle(sender: UIButton!){
		print("middle")
		switch currentSelectState {
		case "racing":
			self.url = s.newsDetails
			self.performSegueWithIdentifier("toRaceResults", sender: self)
		case "explore":
			self.url = s.exploreV
			self.performSegueWithIdentifier("toRaceResults", sender: self)
		case "myKawasaki":
				self.url = s.myOwned
//			self.oOwned.showMessage()
			//	self.performSegueWithIdentifier("toMyOwned", sender: self)
		default: print("32")
		}
	}
	
	func sequeButtom(sender: UIButton!){
		switch currentSelectState {
		case "racing":
		self.url =	s.schedule
			self.performSegueWithIdentifier("toRaceResults", sender: self)
		case "explore":
			self.performSegueWithIdentifier("toHistory", sender: self)
		case "myKawasaki":
			self.oDealer.showMessage()
			//	self.performSegueWithIdentifier("toRaceResults", sender: self)
		default: print("32")
		}
	}
	
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		print("dasdsa")
		if (segue.identifier == "toRaceResults") {
			let svc = segue.destinationViewController as! RaceResults
				svc.passedURL = self.url
			//	print("passing data\(passIn)")
		}
	}

	
	
	
	
}