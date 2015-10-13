//
//  loadingPage.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 10/5/15.
//  Copyright © 2015 jon.canfield. All rights reserved.
//

import UIKit


class LoadingPage: UIViewController  {
	var screen = UIScreen.mainScreen().bounds
	var s:Singleton = Singleton.sharedInstance
	let legalAccept: CoreDataModel = CoreDataModel()
	override func viewDidLoad() {

		self.view.backgroundColor = UIColor.blackColor()
		let mainText = UILabel()
		mainText.frame = CGRectMake(0, screen.width * 0.5, screen.width, 40)
		mainText.text = "LOADING PLEASE WAIT"
		mainText.textColor = UIColor.whiteColor()
		mainText.textAlignment = NSTextAlignment.Center
		self.view.addSubview(mainText)
		s.locationManager.parentView = self
		let legalAcc = legalAccept.getLegal() as! Int
		print(legalAcc)
		if legalAcc == 1{
					performSegueWithIdentifier("toGenericDealer", sender: self)
		}else{
					performSegueWithIdentifier("toLegal", sender: self)
		}
	}
}