//
//  Singlton.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 7/30/15.
//  Copyright (c) 2015 jon.canfield. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class Singleton {
    class var sharedInstance: Singleton {
        struct Static {
            static var instance: Singleton?
            static var token: dispatch_once_t = 0
        }
       
        dispatch_once(&Static.token) {
            Static.instance = Singleton()
        }
        return Static.instance!
    }
    //put shit here
  var locationManager: LocManager = LocManager()
	var prefs:Pref = Pref()
	var navCheck = false
	var locationOff = false
//	var getListBeacon:GetBeacons = GetBeacons()
	var currentStateOfV:Int = 0
	var mainScreen: UIViewController? = nil
	var dealerName = ""
	var dealerID = ""
	// ....appid/deviceID  or appid/deviceID

	let privacy = "https://kawasakimobileappapi.gofuse.com/home/privacyPolicy/E7A9B1A8-241A-40DE-BAD1-330C7FF9C1A4/7df108ef-3c1c-4a75-af54-219ca8c0ce65"


	
	func didGoTOBg(){
		prefs.foundDealerBeacon(false)
		self.mainScreen?.navigationController?.popToRootViewControllerAnimated(false)
		
	}
	
	}
