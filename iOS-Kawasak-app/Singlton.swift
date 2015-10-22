//
//  Singlton.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 7/30/15.
//  Copyright (c) 2015 jon.canfield. All rights reserved.
//

import Foundation
import CoreLocation

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
	var currentStateOfV:Int = 0
	let offers = "https://mobileapp.fuse-review-kawasaki.com/mobiledealer/offers/"
	let myDealer = "https://mobileapp.fuse-review-kawasaki.com//mobiledealer/myDealer"
	let myFav = "https://mobileapp.fuse-review-kawasaki.com/userinfo/myfavoritevehicles"
	let myOwned = "https://mobileapp.fuse-review-kawasaki.com/userinfo/myownedVehicles"
	let exploreV = "https://mobileapp.fuse-review-kawasaki.com/mobileProduct/explorevehicles"
	let prodDetail = "https://mobileapp.fuse-review-kawasaki.com/mobileProduct/ProductDetail"
	let news = "https://mobileapp.fuse-review-kawasaki.com/mobileracing/news/"
	let schedule = "https://mobileapp.fuse-review-kawasaki.com/mobileracing/schedule"
	let newsDetails = "https://mobileapp.fuse-review-kawasaki.com/MobileRacing/NewsDetails/33"
	let privacy = "https://mobileapp.fuse-review-kawasaki.com/home/privacyPolicy"

	//fonts
	let signika = "Signika-Regular"
	let roboto = ""
	
	func setUpToolbar(){
		
		
	}
}
