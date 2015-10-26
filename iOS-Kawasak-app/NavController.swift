//
//  BottomNavController.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 10/13/15.
//  Copyright © 2015 jon.canfield. All rights reserved.
//

import Foundation
import UIKit

class  NavController: UINavigationController, UINavigationControllerDelegate{
var screen = UIScreen.mainScreen().bounds
	let padding:CGFloat = 30
	let BottomPadding:CGFloat = 50
	let topPadding:CGFloat = 50
	let burger: BurgerMenu = BurgerMenu()
	let color:hexColor = hexColor()
	let fontSize:CGFloat = 18
	let fontSizeTitle:CGFloat = 25
	var landingPage = false
	var segueName:String!
	let geoSwitch = UISwitch()
	let pushSwitch = UISwitch()
	let si:Singleton = Singleton.sharedInstance
	//self.navigationController.interactivePopGestureRecognizer.delegate = self

//	[self.navigationController.interactivePopGestureRecognizer setDelegate:nil];
	func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer!) -> Bool {
		return true;
	}
	func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {

		segueName = "text      "

		self.toolbar.hidden = false
		s.navCheck = true
  	landingPage = false
		switch viewController.stringName{
		case "Legal":
			s.navCheck = false
		case "LoadingPage", "Legal", "FindDealer":
			//	self.navigationController?.toolbarHidden = true
				self.toolbar.hidden = true
		case "LandingPageNew":
			landingPage = true
			navLanding()
		default: navGen()
		}
	
	}
	
 let bgView = UIView()
 let mainContainer = UIView()
 let howToContainer = UIView()
	override func viewDidLoad() {
		super.viewDidLoad()

		//self.navigationController?.interactivePopGestureRecognizer!.delegate = self
		self.delegate = self
		bgView.frame = CGRectMake(0, 0, screen.width, screen.height)
		bgView.backgroundColor = UIColor.blackColor()
		self.view.addSubview(bgView)
		//self.toolbar.frame = CGRectMake(0, screen.height - 800, screen.width, 800)

		mainContainer.frame = CGRectMake(padding, padding + 150, screen.width - (padding * 2), screen.height * 0.7)
		
		self.view.addSubview(mainContainer)
		
		let titleLable = UILabel()
		titleLable.text = "Your App Settings"
		titleLable.font = UIFont(name: "Signika-Light", size: fontSizeTitle)
		titleLable.frame = CGRectMake(0, mainContainer.frame.origin.y - 20 , titleLable.intrinsicContentSize().width, titleLable.intrinsicContentSize().height)
		titleLable.textColor = UIColor.whiteColor()
		mainContainer.addSubview(titleLable)
		
		let lineTop = UIImageView()
		lineTop.frame = CGRectMake(0, titleLable.frame.origin.y + (BottomPadding - 10 ), mainContainer.frame.width, 1)
		lineTop.image = UIImage(named: "line2")
		mainContainer.addSubview(lineTop)
		
		let pushLable = UILabel()
		pushLable.text = "Push Notifications"
		pushLable.font = UIFont(name: "Signika-Light", size: fontSize)
		pushLable.frame = CGRectMake(0, titleLable.frame.origin.y + BottomPadding, pushLable.intrinsicContentSize().width, pushLable.intrinsicContentSize().height)
		pushLable.textColor = UIColor.grayColor()
		mainContainer.addSubview(pushLable)
		
		let lineMiddle = UIImageView()
		lineMiddle.frame = CGRectMake(0, pushLable.frame.origin.y + topPadding - 10, mainContainer.frame.width, 1)
		lineMiddle.image = UIImage(named: "line2")
		mainContainer.addSubview(lineMiddle)


		pushSwitch.frame = CGRectMake(mainContainer.frame.width - (padding + 20) , titleLable.frame.origin.y + BottomPadding, 40, pushSwitch.intrinsicContentSize().height)
		pushSwitch.onTintColor = color.rgbColor(0x02c102)
		pushSwitch.setOn(true, animated: false)
		pushSwitch.addTarget(self, action: "pushSwitchValue:", forControlEvents: .ValueChanged);
		mainContainer.addSubview(pushSwitch)
		
		
		let GeoLable = UILabel()
		GeoLable.text = "Geo Tracking"
		GeoLable.font = UIFont(name: "Signika-Light", size: fontSize)
		GeoLable.frame = CGRectMake(0, pushLable.frame.origin.y + topPadding, GeoLable.intrinsicContentSize().width, pushLable.intrinsicContentSize().height)
		GeoLable.textColor = UIColor.grayColor()
		mainContainer.addSubview(GeoLable)
	
		let lineBottom = UIImageView()
		lineBottom.frame = CGRectMake(0,  GeoLable.frame.origin.y + topPadding - 10, mainContainer.frame.width, 1)
		lineBottom.image = UIImage(named: "line2")
		mainContainer.addSubview(lineBottom)
		

		geoSwitch.frame = CGRectMake(mainContainer.frame.width - (padding + 20)  , pushLable.frame.origin.y + BottomPadding, 40, pushLable.intrinsicContentSize().height)
		geoSwitch.addTarget(self, action: "geoSwitchValue:", forControlEvents: .ValueChanged)
		geoSwitch.onTintColor = color.rgbColor(0x02c102)
		geoSwitch.setOn(true, animated: false)
		mainContainer.addSubview(geoSwitch)
		
		let okButton = UIButton()
		okButton.frame = CGRectMake(0 , mainContainer.frame.height - 35 , mainContainer.frame.width, 45)
		okButton.setTitle("OK", forState: .Normal)
		okButton.addTarget(self, action: "submitOK:", forControlEvents: UIControlEvents.TouchUpInside)
		okButton.backgroundColor = color.rgbColor(0x02c102)
		mainContainer.addSubview(okButton)

	
		
		howToContainer.frame = CGRectMake(0,  0, screen.width, screen.height - 60)
		howToContainer.backgroundColor = UIColor.blackColor()
		self.view.addSubview(howToContainer)

		let closeButton = UIButton()
		closeButton.frame = CGRectMake(0, 0, screen.width, 60)
		closeButton.backgroundColor = UIColor.blackColor()
		closeButton.setTitle("X", forState: UIControlState.Normal)
		closeButton.contentHorizontalAlignment = .Center
		closeButton.titleLabel?.font = UIFont(name:"Signika-Light" , size: fontSize)
		closeButton.addTarget(self, action: "close:", forControlEvents: UIControlEvents.TouchUpInside)
		howToContainer.addSubview(closeButton)
		
		let helpImage = UIImageView()
		helpImage.frame = CGRectMake(0, 60, howToContainer.frame.width, howToContainer.frame.height)
		helpImage.image = UIImage(named: "howTO")
		howToContainer.addSubview(helpImage)
		
		howToContainer.frame.origin.y = screen.height
		bgView.frame.origin.y = screen.height
		mainContainer.frame.origin.y = screen.height
		
	}

	func pushSwitchValue(sender:UISwitch!){
		var defaults = NSUserDefaults.standardUserDefaults()


		if pushSwitch.on {
			defaults.setBool(true, forKey: "PushSwitchState")
			si.prefs.setPushNotif(true)
			si.locationManager.turnOnpush()
		} else {
			defaults.setBool(false, forKey: "PushSwitchState")
			si.prefs.setPushNotif(false)
			si.locationManager.turnOffpush()
		}
		
	}
	func geoSwitchValue(sender:UISwitch!){
		var defaults = NSUserDefaults.standardUserDefaults()
		
		if geoSwitch.on {
			defaults.setBool(true, forKey: "GoeSwitchState")
			si.prefs.setGeoTracking(true)
			si.locationManager.turnOngeo()
		} else {
			defaults.setBool(false, forKey: "GeoSwitchState")
			si.prefs.setGeoTracking(false)
			si.locationManager.turnOffgeo()
		}

	}
	func submitOK(sender:AnyObject){

		UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
			self.bgView.frame.origin.y = self.screen.height
			self.mainContainer.frame.origin.y = self.screen.height
					}, completion: { finished in
			})
		}
	func close(sender:AnyObject){
		UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
		self.howToContainer.frame.origin.y = self.screen.height
			}, completion: { finished in
		})

	}

	
	
	func navGen(){
	 clearSubViews()
		let kawaskiConnect = UIImageView()
		let kImage = UIImage(named: "KawasakiConnectLockUp_Footer")
		kawaskiConnect.image = kImage
		kawaskiConnect.frame = CGRectMake(10, 15, ((kImage?.size.width)! * 0.5), ((kImage?.size.height)! * 0.5))
		self.toolbar.addSubview(kawaskiConnect)
		let helpIcon = UIImageView()
		let	helpImage = UIImage(named: "InstructionsIcon_Footer")
		helpIcon.image = helpImage
		helpIcon.userInteractionEnabled = true
		let recognizerLegal1 = UITapGestureRecognizer(target: self, action:"help:")
		helpIcon.addGestureRecognizer(recognizerLegal1)

		helpIcon.frame = CGRectMake((self.toolbar.frame.width - 30) , 12, (helpImage?.size.width)! * 0.45, (helpImage?.size.height)! * 0.45)
		
		self.toolbar.addSubview(helpIcon)
		
		let settingsIcon = UIImageView()
		let	settingsimage = UIImage(named: "SettingsIcon_Footer")
		settingsIcon.image = settingsimage
		settingsIcon.userInteractionEnabled = true
		let recognizerLegal = UITapGestureRecognizer(target: self, action:"settings:")
		settingsIcon.addGestureRecognizer(recognizerLegal)
		settingsIcon.frame = CGRectMake( helpIcon.frame.origin.x - 40  ,12,(settingsimage?.size.width)! * 0.45, (settingsimage?.size.height)! * 0.45)
		self.toolbar.addSubview(settingsIcon)

		
	}
	func navLanding(){
		clearSubViews()
		self.toolbar.barTintColor = UIColor.blackColor()
		let kawaskiConnect = UILabel()
		kawaskiConnect.userInteractionEnabled = true
		let recognizer = UITapGestureRecognizer(target: self, action:"legal:")
		kawaskiConnect.addGestureRecognizer(recognizer)
		kawaskiConnect.font = UIFont(name: kawaskiConnect.font.fontName, size: 10)
		let	text = "LEGAL TERMS & CONDITIONS"
		let kText:NSMutableAttributedString = NSMutableAttributedString(string: text)
		kText.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSRange(location: 0, length: text.characters.count))
		kawaskiConnect.attributedText = kText
		kawaskiConnect.textColor = UIColor.grayColor()
		
		kawaskiConnect.frame = CGRectMake(10, 15, kawaskiConnect.intrinsicContentSize().width, kawaskiConnect.intrinsicContentSize().height)
		self.toolbar.addSubview(kawaskiConnect)
		
		let helpIcon = UIImageView()
		let	helpImage = UIImage(named: "InstructionsIcon_Footer")
		
		helpIcon.image = helpImage
		helpIcon.frame = CGRectMake((self.toolbar.frame.width - 30) , 12, (helpImage?.size.width)! * 0.45, (helpImage?.size.height)! * 0.45)
		helpIcon.userInteractionEnabled = true
		let recognizerLegal1 = UITapGestureRecognizer(target: self, action:"help:")
		helpIcon.addGestureRecognizer(recognizerLegal1)
		self.toolbar.addSubview(helpIcon)
		
		let settingsIcon = UIImageView()
		let	settingsimage = UIImage(named: "SettingsIcon_Footer")
		settingsIcon.image = settingsimage
		settingsIcon.userInteractionEnabled = true
		let recognizerLegal = UITapGestureRecognizer(target: self, action:"settings:")
		settingsIcon.addGestureRecognizer(recognizerLegal)
		settingsIcon.frame = CGRectMake( helpIcon.frame.origin.x - 50  ,12,(settingsimage?.size.width)! * 0.45, (settingsimage?.size.height)! * 0.45)
		self.toolbar.addSubview(settingsIcon)

	}
	func clearSubViews(){
		let subViews = self.toolbar.subviews
		var count = 0
		for subview in subViews{
		//	//print(subview)
			if count > 1{
			subview.removeFromSuperview()
			}
			count++
		}
	}
	
	
	
	func legal(recognizer: AnyObject){
		
			self.popToRootViewControllerAnimated(false)
		self.viewControllers[0].performSegueWithIdentifier("toLegal", sender: self)
	}
	
	func settings(recognizer: AnyObject){
		print("push settings \(s.prefs.isPush())")
			geoSwitch.setOn(s.prefs.isGeoTrak(), animated: false)
			pushSwitch.setOn(s.prefs.isPush() , animated: false)

		UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
			self.bgView.frame.origin.y = 0
			self.mainContainer.frame.origin.y = 0
			}, completion: { finished in
				
		})
		//	//print("dasdas")
	//	self.popToRootViewControllerAnimated(false)
	//	self.viewControllers[0].performSegueWithIdentifier("goToSettings", sender: self)
	
	}
	func help(sender:AnyObject){
		
			UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
			
				self.howToContainer.frame.origin.y = 0
				}, completion: { finished in
					
			})
			
			
	}
	

}

extension NSObject {
	var stringName: String {
		return NSStringFromClass(self.dynamicType).componentsSeparatedByString(".").last!
	}
}
