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

	var landingPage = false
	
	func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {

		if 	viewController.stringName == "LoadingPage"{
			self.toolbar.hidden = true
		}

		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.delegate = self
		//self.toolbar.barTintColor = UIColor.blackColor()
	
		if !landingPage{
			let kawaskiConnect = UIImageView()
			let kImage = UIImage(named: "KawasakiConnectLockUp_Footer")
			kawaskiConnect.image = kImage
			kawaskiConnect.frame = CGRectMake(10, 15, ((kImage?.size.width)! * 0.5), ((kImage?.size.height)! * 0.5))
			self.toolbar.addSubview(kawaskiConnect)
		}else{
			
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
		//self.addSubview(kawaskiConnect)
			
		}
		
		let helpIcon = UIImageView()
		let	helpImage = UIImage(named: "InstructionsIcon_Footer")
	
		helpIcon.image = helpImage
		helpIcon.frame = CGRectMake((self.toolbar.frame.width - 10) - 15, 12, (helpImage?.size.width)! * 0.4, (helpImage?.size.height)! * 0.4)
		
			self.toolbar.addSubview(helpIcon)
		
		let settingsIcon = UIImageView()
		let	settingsimage = UIImage(named: "SettingsIcon_Footer")
		settingsIcon.image = settingsimage
		settingsIcon.frame = CGRectMake( helpIcon.frame.origin.x - 40  ,12,(settingsimage?.size.width)! * 0.4, (settingsimage?.size.height)! * 0.4)
			self.toolbar.addSubview(settingsIcon)
		
	}
	
	func legal(recognizer: AnyObject){
			self.popToRootViewControllerAnimated(false)
		self.viewControllers[0].performSegueWithIdentifier("toLegal", sender: self)
	}
	
}


extension NSObject {
	var stringName: String {
		return NSStringFromClass(self.dynamicType).componentsSeparatedByString(".").last!
	}
}
