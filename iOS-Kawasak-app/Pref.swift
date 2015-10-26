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
			//print("isReg")
			//print(loggedInNotNil)
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
		//print("logging out")
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
				//print("isReg")
				//print(firstRun)
				return true
			}else{
				return false
			}
	}
	
	func saveAppID(){
		//print("saving app")
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		defaults.setObject("E7A9B1A8-241A-40DE-BAD1-330C7FF9C1A4", forKey: "appID")
		defaults.synchronize()
	}

	func getAppID() -> String{
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		if let firstRun = defaults.objectForKey("appID") as? String {
			//print(firstRun)
			return firstRun
		}else{
		return	""
		}
	}

	func loadlogInfo(){
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		if let loggedInNotNil = defaults.objectForKey("loggedIn") as? String {
			//print(loggedInNotNil)
			//	self.firstNameTextField.text = defaults.objectForKey("firstName") as String
		}
		
	}
	
	func setValidUser(user:Bool){
		//print("setting valid user \(user)")
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
		//print("found dealer beacon \(id)")
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		defaults.setObject(id, forKey: "dealerBeacon")
		defaults.synchronize()
	}

	func hasSeenDealerBeacon() -> Bool{

		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		if let firstRun = defaults.objectForKey("dealerBeacon") as? Bool {
			return firstRun
		}else{
			return false
		}
	}
	
	func dealerID(id:String){
		//print("found dealer beacon \(id)")
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
		//print("setting geo track \(value)")
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		defaults.setObject(value, forKey: "GeoTrack")
		defaults.synchronize()
	}
	
	func setPushNotif(value: Bool){
		print(value)
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		defaults.setObject(value, forKey: "PushNot")
		defaults.synchronize()
	}
	func isGeoTrak() -> Bool{
		//print("checking to see is geo track okay")
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		if let firstRun = defaults.objectForKey("GeoTrack") as? Bool {
			//print("from prefs geo \(firstRun)")
			return firstRun
		}else{
			return false
		}
		
	}
	func isPush() -> Bool{
		print("checking for push")
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		if let firstRun = defaults.objectForKey("PushNot") as? Bool {
			print("bbb")
			return firstRun
		}else{
			print("aaaa")
			return false
		}
		
	}
	
	
	func username(value: String){
		//print("setting geo track \(value)")
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
		//print("setting geo track \(value)")
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		defaults.setObject(value, forKey: "password")
		defaults.synchronize()
	}
	
	func getPassword() -> String{
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		if let firstRun = defaults.objectForKey("getPassowrd") as? String {
			return firstRun
		}else{
			return ""
		}
		
	}

	
		
}