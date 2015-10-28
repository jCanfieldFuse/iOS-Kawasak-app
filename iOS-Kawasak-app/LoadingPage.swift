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
	var beacon: GetBeacons = GetBeacons()
	var segueView = "no"
	
	override func viewDidLoad() {
		self.navigationController?.navigationBarHidden = true
		UIApplication.sharedApplication().applicationIconBadgeNumber = 0
		beacon.getList()
		self.view.backgroundColor = UIColor.blackColor()
		if !s.prefs.isReg(){
			s.prefs.setPushNotif(true)
			s.prefs.setGeoTracking(true)
			s.prefs.registerID(UIDevice.currentDevice().identifierForVendor!.UUIDString)
			s.prefs.saveAppID()
			
			let url = NSURL(string: "https://Kawasakimobileappapi.gofuse.com/api/MobileAppInstall/\(UIDevice.currentDevice().identifierForVendor!.UUIDString)/v2")
			let request = NSURLRequest(URL: url!)
			NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
				
			}
		}
		
		if !s.prefs.isGeoTrak(){
			s.locationManager.turnOffgeo()
		}else{
			s.locationManager.turnOngeo()
		}
		if !s.prefs.isPush(){
			s.locationManager.turnOffpush()
		}else{
			s.locationManager.turnOnpush()
		}
		
	}
	
	override func viewDidAppear(animated: Bool) {
		let legalAcc = legalAccept.getLegal() as! Int
		if legalAcc == 1 {
			
			performSegueWithIdentifier("toGenericDealer", sender: self)
		}else{
			performSegueWithIdentifier("toLegal", sender: self)
		}
		if segueView != "no"{
			performSegueWithIdentifier(segueView, sender: self)
		}
		
	}
	override func prefersStatusBarHidden() -> Bool {
		return true
	}
}