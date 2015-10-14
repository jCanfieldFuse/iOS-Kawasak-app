//
//  youHistory.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 10/6/15.
//  Copyright © 2015 jon.canfield. All rights reserved.
//

import UIKit

class YourHistory: UIViewController  {
	var screen = UIScreen.mainScreen().bounds
	let marginRight:CGFloat = 40
	let marginLeft:CGFloat = 40
	let threeButtonXpos:CGFloat =  20
	let smButtonWidth:CGFloat = 50
	let smButtonHeight:CGFloat = 57
	var burger: BurgerMenu = BurgerMenu()
	var coreData: CoreDataModel = CoreDataModel()
	override func viewDidLoad() {
		self.navigationController?.navigationBarHidden = true
		self.view.backgroundColor = UIColor.blackColor()

		burger.parentView = self
		let racingHeader = UIView()
		racingHeader.frame = CGRectMake(0, 0, screen.width, 60)
		racingHeader.backgroundColor = UIColor.blackColor()
		self.view.addSubview(racingHeader)
		coreData.setDealersVisited(11 as Int)
		coreData.setVehiclesExplored(1 as Int)
		
		let hamburger = UIButton()
		hamburger.frame = CGRectMake(20, 15, 30,30)
		hamburger.setBackgroundImage(UIImage(named: "HamburgerMenu_Button_Top"), forState: .Normal)
		hamburger.contentHorizontalAlignment = .Center
		hamburger.addTarget(self, action: "openMenu:", forControlEvents: UIControlEvents.TouchUpInside)
		racingHeader.addSubview(hamburger)
		
		let headerText = UILabel()
		let myText  = "Explore Vehicles"
		headerText.textColor = UIColor.whiteColor()
		let	myMutableString = NSMutableAttributedString(string: myText, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 18.0)!])
		myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.grayColor(), range: NSRange(location:7,length:9))
		headerText.attributedText = myMutableString
		headerText.frame = CGRectMake(hamburger.frame.width + 35, 15, screen.width - hamburger.frame.width, 30)
		racingHeader.addSubview(headerText)

		

		let copyContainer = UIView()
		copyContainer.frame = CGRectMake(marginLeft, screen.width * 0.6, screen.width - (marginRight), screen.height * 0.2)
		
		self.view.addSubview(copyContainer)
		
		let yourHistory = UILabel()
		yourHistory.text = "Your History"
		yourHistory.frame = CGRectMake(0, 0, yourHistory.intrinsicContentSize().width, yourHistory.intrinsicContentSize().height)
		yourHistory.textAlignment = NSTextAlignment.Left
		yourHistory.textColor = UIColor.whiteColor()
		copyContainer.addSubview(yourHistory)
		
		let copyBody = UILabel()
		copyBody.text = "blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah "
		copyBody.numberOfLines = 4
		copyBody.textColor = UIColor.grayColor()
		copyBody.frame = CGRectMake(0,  yourHistory.frame.origin.y + yourHistory.intrinsicContentSize().height, copyContainer.frame.width - marginLeft, 100)
		copyContainer.addSubview(copyBody)
		
		
		
		let topRightContainer = UIView()
		topRightContainer.frame = CGRectMake(marginLeft, copyContainer.frame.origin.y + copyContainer.frame.height , yourHistory.intrinsicContentSize().width, yourHistory.intrinsicContentSize().height)
		self.view.addSubview(topRightContainer)
		
		
		let buttonTop = UIButton()
		buttonTop.frame = CGRectMake(0, threeButtonXpos, smButtonWidth, smButtonHeight)
		buttonTop.setImage(UIImage(named: "KC_SplashPage_MainHexes_Iddle"), forState: .Normal)
		buttonTop.setTitle("Button", forState: UIControlState.Normal)
		buttonTop.addTarget(self, action: "topButton:", forControlEvents: UIControlEvents.TouchUpInside)
		buttonTop.alpha = 1
		topRightContainer.addSubview(buttonTop)
		
		let textTop = UILabel()
		textTop.text = "Vehicles Explored"
		textTop.frame =  CGRectMake(buttonTop.frame.width + 15, threeButtonXpos + 15, textTop.intrinsicContentSize().width,	textTop.intrinsicContentSize().height)
		let recognizer = UITapGestureRecognizer(target: self, action:"test:")
		textTop.addGestureRecognizer(recognizer)
		textTop.userInteractionEnabled = true
		textTop.textColor = UIColor.whiteColor()
		textTop.textAlignment = NSTextAlignment.Right
		topRightContainer.addSubview(textTop)
		
		
		let lineTop = UIView()
		lineTop.frame = CGRectMake(0, textTop.frame.height , textTop.frame.width, 1)
		lineTop.backgroundColor = UIColor.grayColor()
		textTop.addSubview(lineTop)
		
		let redTopView = UIView()
		redTopView.frame = CGRectMake(textTop.frame.origin.x + textTop.intrinsicContentSize().width + 10, threeButtonXpos + 15, 20, 20)
		topRightContainer.addSubview(redTopView)
		
		let redTop = UIImageView()
		redTop.frame = CGRectMake(0, 0, 20, 20)
		redTop.image = UIImage(named: "YouHaveActivityRedDot_HistorySectionpsb")
		redTopView.addSubview(redTop)
		
		let redCountTop = UILabel()
		redCountTop.frame = CGRectMake(0, 0, 20, 20)
		redCountTop.textColor = UIColor.whiteColor()
		redCountTop.text = "\(coreData.getDealersExploredCount())"
		redCountTop.textAlignment = NSTextAlignment.Center
		redTopView.addSubview(redCountTop)
		
		
		let buttonMiddle = UIButton()
		buttonMiddle.frame = CGRectMake(buttonTop.frame.origin.x + (buttonTop.frame.width * 0.5)  , threeButtonXpos + 43, smButtonWidth, smButtonHeight)
		buttonMiddle.setImage(UIImage(named: "KC_SplashPage_MainHexes_Iddle"), forState: .Normal)
		buttonMiddle.setTitle("Button", forState: UIControlState.Normal)
		buttonMiddle.addTarget(self, action: "topButton:", forControlEvents: UIControlEvents.TouchUpInside)
		topRightContainer.addSubview(buttonMiddle)
		
		let textMiddle = UILabel()
		textMiddle.text = "Dealers Visited"
		textMiddle.frame =  CGRectMake(textTop.frame.origin.x + 20, threeButtonXpos + 55, textMiddle.intrinsicContentSize().width, textMiddle.intrinsicContentSize().height)
		textMiddle.textColor = UIColor.whiteColor()
		textMiddle.textAlignment = NSTextAlignment.Right
		topRightContainer.addSubview(textMiddle)
		
		let lineMiddle = UIView()
		lineMiddle.frame = CGRectMake(0, textMiddle.frame.height , textMiddle.frame.width, 1)
		lineMiddle.backgroundColor = UIColor.grayColor()
		textMiddle.addSubview(lineMiddle)
		
		let redBottomView = UIView()
		redBottomView.frame = CGRectMake(textMiddle.frame.origin.x + textMiddle.intrinsicContentSize().width + 10, threeButtonXpos + 55, 20,20)
		topRightContainer.addSubview(redBottomView)
		
		let redBottom = UIImageView()
		redBottom.frame = CGRectMake(0, 0, 20, 20)
		redBottom.image = UIImage(named: "YouHaveActivityRedDot_HistorySectionpsb")
		redBottomView.addSubview(redBottom)
		
		let redCountBottom = UILabel()
		redCountBottom.frame = CGRectMake(0, 0, 20, 20)
		redCountBottom.textColor = UIColor.whiteColor()
		redCountBottom.text = "\(coreData.getVehiclesExploredCount())"
		redCountBottom.textAlignment = NSTextAlignment.Center
		redBottomView.addSubview(redCountBottom
		)
		
		//	self.view.addSubview(burger)
		
	}
	override func viewWillAppear(animated: Bool) {
					self.view.addSubview(burger)
	}
	func openMenu(sender: UIButton!){
		burger.openMenu()
		
	}
}