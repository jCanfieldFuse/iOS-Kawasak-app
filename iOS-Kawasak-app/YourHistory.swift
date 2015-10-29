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
	let smButtonWidth:CGFloat = 37
	let smButtonHeight:CGFloat = 42
	var burger: BurgerMenu = BurgerMenu()
	var coreData: CoreDataModel = CoreDataModel()
	let c:hexColor = hexColor()
	var passIn = 0
	var de: NoDealer = NoDealer()
	var vh: NoVH = NoVH()
	var url = ""
	override func viewDidLoad() {
	//	self.navigationController?.navigationBarHidden = true
		self.view.backgroundColor = c.rgbColor(0x161719)

		burger.parentView = self
		let racingHeader = UIView()
		racingHeader.frame = CGRectMake(0, 0, screen.width, 60)
		racingHeader.backgroundColor = UIColor.blackColor()
		self.view.addSubview(racingHeader)
	//	coreData.setDealersVisited(11 as Int)
	//	coreData.setVehiclesExplored(1 as Int)

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
		
		let headerText = UILabel()
		let myText  = "Explore Vehicles"
		headerText.textColor = UIColor.whiteColor()
		let	myMutableString = NSMutableAttributedString(string: myText, attributes: [NSFontAttributeName:UIFont(name: "Signika-Light", size: 25.0)!])
		myMutableString.addAttribute(NSForegroundColorAttributeName, value: c.rgbColor(0x7d7e80), range: NSRange(location:7,length:9))
		headerText.attributedText = myMutableString
		headerText.frame = CGRectMake(hamburger.frame.width + 35, 15, screen.width - hamburger.frame.width, 30)
		racingHeader.addSubview(headerText)

		//marginLeft = screen.width

		let copyContainer = UIView()
		copyContainer.frame = CGRectMake(marginLeft, screen.width * 0.67, screen.width - (marginRight * 2), screen.height * 0.2)

		self.view.addSubview(copyContainer)
		
		let yourHistory = UILabel()
		yourHistory.text = "Your History"
		yourHistory.font = UIFont(name: "Signika-Light", size: 25)
		yourHistory.frame = CGRectMake(0, 0, yourHistory.intrinsicContentSize().width, yourHistory.intrinsicContentSize().height)
		yourHistory.textAlignment = NSTextAlignment.Left
		yourHistory.textColor = UIColor.whiteColor()
		copyContainer.addSubview(yourHistory)
		
		let copyBody = UILabel()
		copyBody.textColor = c.rgbColor(0x7d7e80)
		let myFont = UIFont(name: "Signika-Bold", size: 15)
		let textBody = "Through In-Store you can keep a \nrecord of vehicles explored at the \nshowrooms as well as detailed list \nof dealers you have been visiting"
		let	myMutableStringBody = NSMutableAttributedString(string: textBody, attributes: [NSFontAttributeName:UIFont(name: "Signika-Light", size: 15.0)!])
		myMutableStringBody.addAttribute(NSFontAttributeName, value: myFont!, range: NSRange(location:7,length:9))
		copyBody.attributedText = myMutableStringBody
		copyBody.numberOfLines = 4
		copyBody.frame = CGRectMake(0,  yourHistory.frame.origin.y + yourHistory.intrinsicContentSize().height - 5, copyContainer.frame.width , 100)
		copyContainer.addSubview(copyBody)
		
		
		let topRightContainer = UIView()
		topRightContainer.frame = CGRectMake((copyContainer.frame.origin.x + copyContainer.frame.width) - 220 , copyContainer.frame.origin.y + copyContainer.frame.height + 45 , 220, copyBody.frame.height)

		self.view.addSubview(topRightContainer)
		
		
		let buttonTop = UIButton()
		buttonTop.frame = CGRectMake(0, 0, smButtonWidth, smButtonHeight)
		buttonTop.setImage(UIImage(named: "KC_SplashPage_MainHexes_Iddle"), forState: .Normal)
		buttonTop.setTitle("Button", forState: UIControlState.Normal)
		buttonTop.addTarget(self, action: "vehiclesVisited:", forControlEvents: UIControlEvents.TouchUpInside)
		topRightContainer.addSubview(buttonTop)
		
		let textTop = UILabel()
		textTop.text = "Vehicles Explored"
		textTop.frame =  CGRectMake(buttonTop.frame.width + 15, 5, textTop.intrinsicContentSize().width,	textTop.intrinsicContentSize().height)
		let recognizer = UITapGestureRecognizer(target: self, action:"vehiclesVisited:")
		textTop.addGestureRecognizer(recognizer)
		textTop.userInteractionEnabled = true
		textTop.textColor = UIColor.whiteColor()
		textTop.textAlignment = NSTextAlignment.Right
		topRightContainer.addSubview(textTop)
		
		let vehicles = coreData.getVehiclesExplored()
		let lineTop = UIImageView()
		lineTop.frame = CGRectMake(0, textTop.frame.height + 5 , textTop.frame.width, 1)
		lineTop.image = UIImage(named: "line2")
		textTop.addSubview(lineTop)
		
		let redTopView = UIView()
		redTopView.frame = CGRectMake(textTop.frame.origin.x + textTop.intrinsicContentSize().width + 10, 5, 20, 20)
		topRightContainer.addSubview(redTopView)
		
		let redTop = UIImageView()
		redTop.frame = CGRectMake(0, 0, 20, 20)
		redTop.image = UIImage(named: "YouHaveActivityRedDot_HistorySectionpsb")
		redTopView.addSubview(redTop)
		
		let redCountTop = UILabel()
		redCountTop.frame = CGRectMake(0, 0, 20, 20)
		redCountTop.font = UIFont(name: "Signika-Light", size: 12)
		redCountTop.textColor = UIColor.whiteColor()
		redCountTop.text = "\(vehicles.count)"
		redCountTop.textAlignment = NSTextAlignment.Center
		redTopView.addSubview(redCountTop)
		
		
		let buttonMiddle = UIButton()
		buttonMiddle.frame = CGRectMake(buttonTop.frame.origin.x + (buttonTop.frame.width * 0.5)  ,  32, smButtonWidth, smButtonHeight)
		buttonMiddle.setImage(UIImage(named: "KC_SplashPage_MainHexes_Iddle"), forState: .Normal)
		buttonMiddle.setTitle("Button", forState: UIControlState.Normal)
		buttonMiddle.addTarget(self, action: "dealersVisited:", forControlEvents: UIControlEvents.TouchUpInside)
		topRightContainer.addSubview(buttonMiddle)
		
		let textMiddle = UILabel()
		textMiddle.text = "Dealers Visited"
		let recognizerV = UITapGestureRecognizer(target: self, action:"dealersVisited:")
		textTop.addGestureRecognizer(recognizerV)
		textMiddle.frame =  CGRectMake(textTop.frame.origin.x + 20,  44, textMiddle.intrinsicContentSize().width, textMiddle.intrinsicContentSize().height)
		textMiddle.textColor = UIColor.whiteColor()
		textMiddle.textAlignment = NSTextAlignment.Right
		topRightContainer.addSubview(textMiddle)
		
		let dealers = coreData.getDealersExploredCount()
		let lineMiddle = UIImageView()
		lineMiddle.frame = CGRectMake(0, textMiddle.frame.height + 5, textMiddle.frame.width, 1)
		lineMiddle.image = UIImage(named: "line2")
		textMiddle.addSubview(lineMiddle)
		
		let redBottomView = UIView()
		redBottomView.frame = CGRectMake(textMiddle.frame.origin.x + textMiddle.intrinsicContentSize().width + 10,  44, 20,20)
		topRightContainer.addSubview(redBottomView)
		
		let redBottom = UIImageView()
		redBottom.frame = CGRectMake(0, 0, 20, 20)
		redBottom.image = UIImage(named: "YouHaveActivityRedDot_HistorySectionpsb")
		redBottomView.addSubview(redBottom)
		
		
		
		let redCountBottom = UILabel()
		redCountBottom.frame = CGRectMake(0, 0, 20, 20)
		redCountBottom.textColor = UIColor.whiteColor()
		redCountBottom.font = UIFont(name: "Signika-Light", size: 12)
		redCountBottom.text =  "\(dealers.count)"
		redCountBottom.textAlignment = NSTextAlignment.Center
		redBottomView.addSubview(redCountBottom
		)

		self.view.addSubview(de)
		self.view.addSubview(vh)
		
	}


	 	override func viewWillAppear(animated: Bool) {
					self.view.addSubview(burger)
	}
	func openMenu(sender: UIButton!){
		burger.openMenu()
		
	}
	
	func vehiclesVisited(sender: AnyObject){
		let vehicles = coreData.getVehiclesExplored()
		
		if vehicles.count != 0{
			self.url = "https://Kawasakimobileappapi.gofuse.com/mobileproduct/productslist/\(s.prefs.getAppID())/\(s.prefs.getPhID())/\(vehicles.values)"
			self.performSegueWithIdentifier("toExploredVehicles", sender: self)
		}else{
				self.vh.showMessage()
		}
		
	}
	
	func dealersVisited(sender: AnyObject){
		let dealers = coreData.getDealersExploredCount()
		if dealers.count != 0{
		self.url = "https://Kawasakimobileappapi.gofuse.com/mobileappapi/GetDealersDetails/\(s.prefs.getAppID())/\(s.prefs.getPhID())/\(dealers.values)"
			print(url)
			self.performSegueWithIdentifier("toDealersVisited", sender: self)
		}else{
				self.de.showMessage()
		}
	}

override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	if (segue.identifier == "toDealersVisited") {
		let svc = segue.destinationViewController as! VisitedDealers
		svc.passedURL = self.url
	}
	if (segue.identifier == "toExploredVehicles") {
		let svc = segue.destinationViewController as! VisitedProducts
		svc.passedURL = self.url
	}
}



}