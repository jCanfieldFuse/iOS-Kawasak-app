//
//  login.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 7/28/15.
//  Copyright (c) 2015 jon.canfield. All rights reserved.
//

import UIKit

class Login: UIViewController, UIWebViewDelegate{
	
	@IBOutlet weak var username: UITextField!
	@IBOutlet weak var password: UITextField!
	
	@IBOutlet weak var myWebView: UIWebView!
	@IBOutlet weak var submitButton: UIButton!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//Looks for single or multiple taps.
		var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
		view.addGestureRecognizer(tap)
		
		
	}
	
	//Calls this function when the tap is recognized.
	func DismissKeyboard(){
		//Causes the view (or one of its embedded text fields) to resign the first responder status.
		view.endEditing(true)
	}
	
	@IBAction func resetPassword(sender: AnyObject) {
		UIApplication.sharedApplication().openURL(NSURL(string: "http://m.kawasaki.com/account/forgotPassword")!)
		
	}
	
	@IBAction func submitButton(sender: AnyObject) {
		//        let userNameInput = username.text
		//       let passwordInput = password.text
		var usernameVal:NSString = username.text
		var passwordVal:NSString = password.text
		
		if ( usernameVal.isEqualToString("") || passwordVal.isEqualToString("") ) {
			
			var alertView:UIAlertView = UIAlertView()
			alertView.title = "Sign in Failed!"
			alertView.message = "Please enter Username and Password"
			alertView.delegate = self
			alertView.addButtonWithTitle("OK")
			alertView.show()
		} else {
			
			var post:NSString = "username=\(usernameVal)&password=\(passwordVal)"
			
			NSLog("PostData: %@",post);
			
			var url:NSURL = NSURL(string: "http://www.fuse-review-kawasaki.com/mobileappjsonapi/logInApiRequest")!
			//	var url:NSURL = NSURL(string: "https://dipinkrishna.com/jsonlogin2.php")!
			var postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
			
			var postLength:NSString = String( postData.length )
			
			var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
			request.HTTPMethod = "POST"
			println("POST DATA!!!!!! \(postData))")
			request.HTTPBody = postData
			request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
			request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
			request.setValue("application/json", forHTTPHeaderField: "Accept")
			
			println("POST DATA!!!!!! \(postData))")
			var reponseError: NSError?
			var response: NSURLResponse?
			
			var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&reponseError)
			println(" THE URL DATA\(urlData)")
			if ( urlData != nil ) {
				let res = response as! NSHTTPURLResponse!;
				
				NSLog("Response code: %ld", res.statusCode);
				
				if (res.statusCode >= 200 && res.statusCode < 300)
				{
					var responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
					
					NSLog("Response ==> %@", responseData);
					
					var error: NSError?
					
					let jsonData:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &error) as! NSDictionary
					
					
					let success:NSInteger = jsonData.valueForKey("success")as! NSInteger
					
					//[jsonData[@"success"] integerValue];
					
					NSLog("Success: %ld", success);
					
					if(success == 1)
					{
						println(jsonData)
						//							NSLog("Login SUCCESS");
						//
						//							var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
						//							prefs.setObject(username, forKey: "USERNAME")
						//							prefs.setInteger(1, forKey: "ISLOGGEDIN")
						//							prefs.synchronize()
						//
						//							self.dismissViewControllerAnimated(true, completion: nil)
					} else {
						var error_msg:NSString
						
						if jsonData["error_message"] as? NSString != nil {
							error_msg = jsonData["error_message"] as! NSString
						} else {
							error_msg = "Unknown Error"
						}
						var alertView:UIAlertView = UIAlertView()
						alertView.title = "Sign in Failed!"
						alertView.message = error_msg as String
						alertView.delegate = self
						alertView.addButtonWithTitle("OK")
						alertView.show()
						
					}
					
				} else {
					var alertView:UIAlertView = UIAlertView()
					alertView.title = "Sign in Failed!"
					alertView.message = "Connection Failed"
					alertView.delegate = self
					alertView.addButtonWithTitle("OK")
					alertView.show()
				}
			} else {
				var alertView:UIAlertView = UIAlertView()
				alertView.title = "Sign in Failed!"
				alertView.message = "Connection Failure"
				if let error = reponseError {
					alertView.message = (error.localizedDescription)
				}
				alertView.delegate = self
				alertView.addButtonWithTitle("OK")
				alertView.show()
			}
		}
		
	}
}

/*
// set up the base64-encoded credentials
let username = "user"
let password = "pass"
let loginString = NSString(format: "%@:%@", username, password)
let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)
let base64LoginString = loginData.base64EncodedStringWithOptions(nil)

// create the request
let url = NSURL(string: "http://www.example.com/")
let request = NSMutableURLRequest(URL: url)
request.HTTPMethod = "POST"
request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")

// fire off the request
// make sure your class conforms to NSURLConnectionDelegate
let urlConnection = NSURLConnection(request: request, delegate: self)
*/