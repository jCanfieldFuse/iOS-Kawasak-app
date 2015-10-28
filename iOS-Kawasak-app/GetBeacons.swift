//
//  GetBeacons.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 10/22/15.
//  Copyright © 2015 jon.canfield. All rights reserved.
//

import Foundation
import UIKit

class GetBeacons{
	let s:Singleton = Singleton.sharedInstance
	
	
	func getList(){
		dispatch_async(dispatch_get_main_queue(),{
			let url = "https://kawasakimobileapp.gofuse.com/api/BeaconListByStatus/true"
			let endpoint = NSURL(string: url)
			//self.s.locationManager.dealerBeacons.append(Beacon(maj: 61190, min: 482, name: "Dealer", deal: "1", rang: 0.5))
			//	self.s.locationManager.productBeacons.append(Beacon(maj: 35782, min: 37246, name: "Product",deal: "1", rang: 0.5))
			//	return
			if let data = NSData(contentsOfURL: endpoint!){
				//	var firstLoc = true
				if let json: NSDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as? //
					NSDictionary {
						if let items = json["AssignedBeaconList"] as? NSArray {
							for item in items {
								if let dealID = item["DealerUid"] as? String {
									let major = Int(item["Major"] as! String) ?? 0
									let minor = Int(item["Minor"] as! String) ?? 0
									let range = item["Range"] as! Float
									if let urlKey = item["UrlKey"] as? String {
										if let beaconID = item["BeaconId"]as? String {
											if let dealerName = item["DealerName"]as? String {
												if let beaconType = item["BeaconType"] as? String {
													let b = Beacon(maj: major, min: minor, name: urlKey, deal: dealID, rang: range, idbeac: beaconID, nameDealer: dealerName)
													if beaconType.lowercaseString == "dealer"{
													self.s.locationManager.dealerBeacons.append(b)
													}else{
														self.s.locationManager.productBeacons.append(b)
													}
												}
											}
										}
									}
								}
							}
						}
				}
			}
			}
		)
	}
}



