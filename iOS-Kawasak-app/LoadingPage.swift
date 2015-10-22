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
	var segueView = "no"
	
	override func viewDidLoad() {
		self.navigationController?.navigationBarHidden = true

		self.view.backgroundColor = UIColor.blackColor()
	/*
  	let mainImage =  UIImage(named: "")
		let centerImage:UIImageView = UIImageView(image:mainImage)
		centerImage.frame = CGRectMake(20, (screen.height * 0.5) - 10, (mainImage?.size.width)!	, (mainImage?.size.height)!)
		centerImage.center = self.view.center
		self.view.addSubview(centerImage)
		*/
		s.locationManager.parentView = self
		let legalAcc = legalAccept.getLegal() as! Int
		print(legalAcc)
		if legalAcc == 1 {
					performSegueWithIdentifier("toGenericDealer", sender: self)
		}else{
					performSegueWithIdentifier("toLegal", sender: self)
		}
	}
	
	override func viewDidAppear(animated: Bool) {
		print(segueView)
		if segueView != "no"{
			performSegueWithIdentifier(segueView, sender: self)
		}

	}
	override func prefersStatusBarHidden() -> Bool {
		return true
	}
}