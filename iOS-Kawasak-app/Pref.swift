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
		print("registering")
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		defaults.setObject(id, forKey: "uuid")
		defaults.synchronize()
	}
	
	func isReg() -> Bool{
		
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		if let loggedInNotNil = defaults.objectForKey("uuid") as? String {
			print("isReg")
			print(loggedInNotNil)
			return true
		}else{
			return false
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
	
	func loadlogInfo(){
		let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		if let loggedInNotNil = defaults.objectForKey("loggedIn") as? String {
			print(loggedInNotNil)
			//	self.firstNameTextField.text = defaults.objectForKey("firstName") as String
		}
		
	}
	

	
	
}