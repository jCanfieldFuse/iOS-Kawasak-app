//
//  Pref.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 10/22/15.
//  Copyright © 2015 jon.canfield. All rights reserved.
//

import Foundation

class Pref: AnyObject {
	
	
	
	func registerID(id: String){
		//print("registering")
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		defaults.setObject(id, forKey: "uuid")
		defaults.synchronize()
	}
	
	func isReg() -> Bool{
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		if let loggedInNotNil = defaults.objectForKey("uuid") as? String {
			return true
		}else{
			return false
		}
	}
	
	func getPhID() -> String{
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		if let firstRun = defaults.objectForKey("uuid") as? String {
			return firstRun
		}else{
			return	""
		}
	}

	
	func logIn(sender: AnyObject){
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		defaults.setObject("true", forKey: "loggedIn")
		defaults.synchronize()
	}
	
	func logOut(sender: AnyObject){
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		defaults.setObject("false", forKey: "loggedIn")
		defaults.synchronize()
	}
	
	func isLoggedIn() -> Bool{
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		return (defaults.objectForKey("loggedIn") as? Bool)!
	

	}
	
	func firstRun () -> Bool{
			let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
			if let firstRun = defaults.objectForKey("phID") as? String {

				return true
			}else{
				return false
			}
	}
	
	func saveAppID(){

		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		defaults.setObject("E7A9B1A8-241A-40DE-BAD1-330C7FF9C1A4", forKey: "appID")
		defaults.synchronize()
	}

	func getAppID() -> String{
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		if let firstRun = defaults.objectForKey("appID") as? String {

			return firstRun
		}else{
		return	""
		}
	}

	func loadlogInfo(){
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		if let loggedInNotNil = defaults.objectForKey("loggedIn") as? String {

			//	self.firstNameTextField.text = defaults.objectForKey("firstName") as String
		}
		
	}
	
	func setValidUser(user:Bool){

		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		defaults.setObject(user, forKey: "alidUser")
		defaults.synchronize()
	}
	
	func setHasFavorites(fav:Bool){
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		defaults.setObject(fav, forKey: "HasFavorites")
		defaults.synchronize()
	}
	
	func sethasOwned(owned:Bool){
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		defaults.setObject(owned, forKey: "hasOwned")
		defaults.synchronize()
	}
	func setprefDealer(de:Bool){
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		defaults.setObject(de, forKey: "prefDealer")
		defaults.synchronize()
	}
	
	func setDealerBeacon(dealer: String){
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		defaults.setObject(dealer, forKey: "beaconDealer")
		defaults.synchronize()
	}
	
	func getBeaconDealer() -> String{
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		if let firstRun = defaults.objectForKey("beaconDealer") as? String {
			return firstRun
		}else{
			return ""
		}

	}
	func getValidUser() ->Bool{
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		if let ret = defaults.objectForKey("alidUser") as? Bool {
			return ret
		}
		return false

	}
	
	func getHasFavorites() ->Bool{
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		return (defaults.objectForKey("HasFavorites") as? Bool)!
	}
	
	func gethasOwned() ->Bool{
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		return (defaults.objectForKey("hasOwned") as? Bool)!
	}
	
	func getprefDealer() ->Bool{
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		return (defaults.objectForKey("prefDealer") as? Bool)! 
		
	}

	func foundDealerBeacon(id:Bool){

		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		defaults.setObject(id, forKey: "dealerBeacon")
		defaults.synchronize()
	}

	func hasSeenDealerBeacon() -> Bool{

		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		
		if let firstRun = defaults.objectForKey("dealerBeacon") as? Bool {
			(s.mainScreen as! LandingPageNew).updateDealerStatus(firstRun)
			return firstRun
		}else{
			(s.mainScreen as! LandingPageNew).updateDealerStatus(false)
			return false
		}
	}
	
	func dealerID(id:String){

		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		defaults.setObject(id, forKey: "dealerID")
		defaults.synchronize()
	}

	func getDealerID() -> String{
		
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		if let firstRun = defaults.objectForKey("dealerID") as? String {
			return firstRun
		}else{
			return ""
		}
	}
	func setGeoTracking(value: Bool){

		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		defaults.setObject(value, forKey: "GeoTrack")
		defaults.synchronize()
	}
	
	func setPushNotif(value: Bool){
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		defaults.setObject(value, forKey: "PushNot")
		defaults.synchronize()
	}
	func isGeoTrak() -> Bool{

		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		if let firstRun = defaults.objectForKey("GeoTrack") as? Bool {

			return firstRun
		}else{
			return false
		}
		
	}
	func isPush() -> Bool{

		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		if let firstRun = defaults.objectForKey("PushNot") as? Bool {

			return firstRun
		}else{

			return false
		}
		
	}
	
	
	func username(value: String){
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		defaults.setObject(value, forKey: "username")
		defaults.synchronize()
	}

	func getUsername() -> String{
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		if let firstRun = defaults.objectForKey("username") as? String {
			return firstRun
		}else{
			return ""
		}
		
	}

	func password(value: String){

		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		defaults.setObject(value, forKey: "password")
		defaults.synchronize()
	}
	
	func getPassword() -> String{
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		if let firstRun = defaults.objectForKey("password") as? String {
			return firstRun
		}else{
			return ""
		}
		
	}

	
		
}