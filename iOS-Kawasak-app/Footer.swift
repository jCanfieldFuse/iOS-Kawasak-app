//
//  foter.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 9/30/15.
//  Copyright © 2015 jon.canfield. All rights reserved.
//


import UIKit

class Footer: UIView {
	
	var screen = UIScreen.mainScreen().bounds

	override func willMoveToSuperview(newSuperview: UIView?) {

	self.frame = CGRectMake(0, screen.height - 40, screen.width, 40)
	self.backgroundColor = UIColor.blackColor()

	
	var kawFooterLabel = UILabel()
	kawFooterLabel.frame = CGRectMake(10, 0 ,70, self.frame.height)
	kawFooterLabel.text = "Kawasaki"
	kawFooterLabel.numberOfLines = 0
	kawFooterLabel.font = UIFont(name: kawFooterLabel.font.fontName, size: 15)
	kawFooterLabel.textColor = UIColor.whiteColor()
	self.addSubview(kawFooterLabel)
	
	var ConnectFooterLabel = UILabel()
	ConnectFooterLabel.frame = CGRectMake(kawFooterLabel.frame.width + 10 , 0 ,70, self.frame.height)
	ConnectFooterLabel.text = "/ connect"
	ConnectFooterLabel.numberOfLines = 0
	ConnectFooterLabel.font = UIFont(name: kawFooterLabel.font.fontName, size: 15)
	ConnectFooterLabel.textColor = UIColor.grayColor()
	self.addSubview(ConnectFooterLabel)
	
	var helpIcon = UIImageView()
	helpIcon.image = UIImage(named: "helpIcon")
	helpIcon.frame = CGRectMake((self.frame.width - 10) - 15, self.frame.height - 30, 15, 15)

	self.addSubview(helpIcon)
	
	var settingsIcon = UIImageView()
	settingsIcon.image = UIImage(named: "settings-icon")
	print(helpIcon.frame.origin.x)
	settingsIcon.frame = CGRectMake( helpIcon.frame.origin.x - 25  , self.frame.height - 30, 15, 15)
	self.addSubview(settingsIcon)
	
	
	}
}