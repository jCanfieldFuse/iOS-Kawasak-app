//
//  DealerInformation.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 9/2/15.
//  Copyright (c) 2015 jon.canfield. All rights reserved.
//

import UIKit
import CoreLocation
class DealerInformation: UIViewController, UIWebViewDelegate,CLLocationManagerDelegate {
	var dataPassed:String = ""
	
	@IBOutlet weak var dealerShipName: UILabel!
	@IBOutlet weak var city: UILabel!
	@IBOutlet weak var phoneNumber: UILabel!
	@IBOutlet weak var emailAddy: UILabel!
	@IBOutlet weak var hours: UILabel!
	

	override func viewDidLoad() {
		super.viewDidLoad()
		println(dataPassed)
		getStore(dataPassed)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func getStore(zipcode: String){
		
	//	var endpoint = NSURL(string: "http://www.fuse-review-kawasaki.com/mobileappjsonapi/GetDealerByZip?zipCode=\(zipcode)")
	//	var data = NSData(contentsOfURL: endpoint!)
	
	//	if let json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary, let items = json["Dealerships"] as? NSArray {
	//		for item in items {
				
	//			if let lat = item["Latitude"] as? CLLocationDegrees, long = item["Longitude"] as? CLLocationDegrees, store = item["Name"] as? String, postalCode =  item["PostalCode"] as? String{
		//			passedInfo = postalCode
					dealerShipName.text = dataPassed
		
			//	}
		//	}
	//	}
	}
}