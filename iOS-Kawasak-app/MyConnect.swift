//
//  myConnect.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 10/7/15.
//  Copyright © 2015 jon.canfield. All rights reserved.
//

import UIKit

class MyConnect: UIViewController  {
	var screen = UIScreen.mainScreen().bounds
	let marginRight:CGFloat = 40
	let marginLeft:CGFloat = 40
	var mainImage = UIImageView()
//	var footer:Footer = Footer()
	override func viewDidLoad() {
		self.navigationController?.navigationBarHidden = true
		self.view.backgroundColor = UIColor.blackColor()
		glowImage()
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
		hamburger.setBackgroundImage(UIImage(named: "hexagon"), forState: .Normal)
		hamburger.contentHorizontalAlignment = .Center
		hamburger.addTarget(self, action: "openMenu:", forControlEvents: UIControlEvents.TouchUpInside)
		racingHeader.addSubview(hamburger)
		
		let headerText = UILabel()
		_  = "Explore"
		headerText.text = "Explore"
		headerText.textColor = UIColor.whiteColor()
	//	var	myMutableString = NSMutableAttributedString(string: myText, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 18.0)!])
	//	myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.grayColor(), range: NSRange(location:7,length:9))
	//	headerText.attributedText = myMutableString
		headerText.frame = CGRectMake(hamburger.frame.width + 30, 15, screen.width - hamburger.frame.width, 30)
		racingHeader.addSubview(headerText)
		
		
		let copyContainer = UIView()
		copyContainer.frame = CGRectMake(marginLeft, screen.width * 0.3, screen.width - (marginRight * 2), screen.height * 0.2)
		self.view.addSubview(copyContainer)
		
		let yourHistory = UILabel()
		yourHistory.text = "Connect!"
		yourHistory.frame = CGRectMake(0, 0, yourHistory.intrinsicContentSize().width, yourHistory.intrinsicContentSize().height)
		yourHistory.textAlignment = NSTextAlignment.Left
		yourHistory.textColor = UIColor.whiteColor()
		copyContainer.addSubview(yourHistory)
		
		let copyBody = UILabel()
		copyBody.text = "blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah "
		copyBody.numberOfLines = 4
		copyBody.textColor = UIColor.grayColor()
		copyBody.frame = CGRectMake(0,  yourHistory.frame.origin.y + yourHistory.intrinsicContentSize().height,screen.width - (marginRight * 2), 100)
		copyContainer.addSubview(copyBody)

		
		mainImage.frame = CGRectMake(marginLeft, copyContainer.frame.origin.y + copyContainer.frame.height, copyContainer.frame.width - (marginLeft), screen.height * 0.4)
		mainImage.image = UIImage(named: "connect-image.png")
		mainImage.contentMode = UIViewContentMode.ScaleAspectFit
		
		self.view.addSubview(mainImage)
		
		let bottomCopy = UILabel()
		bottomCopy.frame = CGRectMake(marginLeft, mainImage.frame.origin.y + mainImage.frame.height - 80, screen.width - (marginRight * 2), screen.height * 0.4)
		bottomCopy.text = "blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah"
		bottomCopy.textColor = UIColor.grayColor()

		bottomCopy.numberOfLines = 0
		self.view.addSubview(bottomCopy)

		//self.view.addSubview(footer)

	}

	
	func glowImage() {
	
				UIView.animateWithDuration(0.4, delay: 0.0, options: .CurveEaseOut, animations: {
					self.mainImage.alpha = 0.5
					}, completion: { finished in
						UIView.animateWithDuration(0.4, delay: 0.0, options: .CurveEaseOut, animations: {
	  						self.mainImage.alpha = 1
							}, completion: { finished in
								self.glowImage()
							})
						})
		}

	
}
