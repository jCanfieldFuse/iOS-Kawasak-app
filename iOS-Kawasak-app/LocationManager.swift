//
//  LocationManager.swift
//  locationTest
//
//  Created by Garrett Woods on 7/28/15.
//  Copyright (c) 2015 gofuse. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

func == (lhs: Beacon, rhs: Beacon) -> Bool {
	return lhs.major == rhs.major && lhs.minor == rhs.minor
}

class Beacon: Equatable {
	var major: Int = 0
	var minor: Int = 0
	var name: String = ""
	var dealer: String = ""
	var range: Float = 0.0
	var idbeac: String = ""
	var nameDealer: String = ""
	var uniqueIdentifier: String { get { return ""+name+"::\(major)::\(minor)" } }
	
	init(maj: Int, min: Int, name: String, deal: String, rang: Float, idbeac: String , nameDealer: String ){
		self.major = maj
		self.minor = min
		self.name = name
		self.dealer = deal
		self.range = rang
		self.idbeac = idbeac
		self.nameDealer = nameDealer
		//	s.locationManager.beaconTimeCheck[self.uniqueIdentifier] = NSDate(timeIntervalSince1970: 0)
	}
}
let s:Singleton = Singleton.sharedInstance
let coreData: CoreDataModel = CoreDataModel()
var allowPush = false
class LocManager: NSObject, CLLocationManagerDelegate {
	var parentView:UIViewController!
	
	lazy var locMan: CLLocationManager! = {
		let manager = CLLocationManager()
		manager.desiredAccuracy = kCLLocationAccuracyBest
		manager.delegate = self
		manager.requestAlwaysAuthorization()
		
		return manager
		}()
	
	var productBeacons: Array<Beacon> = []
	var dealerBeacons: Array<Beacon> = []
	var enteredRegion = false
	let uniqueId: String = "F7826DA6-4FA2-4E98-8024-BC5B71E0893E"
	private var reg: CLBeaconRegion?
	var region: CLBeaconRegion {
		get {
			return CLBeaconRegion(proximityUUID: NSUUID(UUIDString: self.uniqueId)!, identifier: "Estimotes")
		}
	}
	
	
	override init(){
		super.init()
		//	dealerBeacons.append(Beacon(maj: 61190, min: 482, name: "Dealer", deal: "8FA6A833-2470-4F2E-B00E-5E6341D1670F", rang: 3, idbeac: "Rj8Q"))
		//	productBeacons.append(Beacon(maj: 35782, min: 37246, name: "2015-KFX50", deal: "8FA6A833-2470-4F2E-B00E-5E6341D1670F", rang: 0.5,idbeac: "9XOE"))
		
		
		locMan.delegate = self
		
		if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
			locMan.requestWhenInUseAuthorization()
		}
		
		region.notifyOnEntry = true
		region.notifyOnExit = true
		region.notifyEntryStateOnDisplay = true // show notifications if the device's display is on
		
		locMan.desiredAccuracy = kCLLocationAccuracyBest
		locMan.requestWhenInUseAuthorization()
		
		locMan.requestAlwaysAuthorization()
		
		locMan.startRangingBeaconsInRegion(region)
		locMan.startUpdatingLocation()
		
		
		// make sure the user has allowed location services
		checkLocationAuthorization()
	}
	
	func turnOffgeo(){
		
		locMan.stopRangingBeaconsInRegion(region)
		locMan.stopMonitoringForRegion(region)
	}
	
	func turnOngeo(){
		
		locMan.startRangingBeaconsInRegion(region)
		locMan.startMonitoringForRegion(region)
	}
	
	
	func turnOffpush(){
		allowPush = false
	}
	
	func turnOnpush(){
		allowPush = true
		
	}
	
	func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
		
		switch status{
			
		case .AuthorizedAlways:
			
			locMan.startMonitoringForRegion(region)
			locMan.startRangingBeaconsInRegion(region)
			locMan.requestStateForRegion(region)
			
		case .Denied:
			
			let alert = UIAlertController(title: "Warning", message: "You've disabled location update which is required for Kawasaki Connect.", preferredStyle: UIAlertControllerStyle.Alert)
			let alertAction = UIAlertAction(title: "OK!", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in }
			alert.addAction(alertAction)
			
			s.didGoTOBg()
			
			//display error message if location updates are declined
			
		default:
			print("default case")
			
		}
		
	}
	
	/*
	func getDealerName(dealer:String) {
	print("Getting DealerName")
	dispatch_async(dispatch_get_main_queue(),{
	let url = "https://Kawasakimobileappapi.gofuse.com/MobileAppAPI/GetDealerInfo/\(s.prefs.getAppID())/\(s.prefs.getPhID())/\(dealer)"
	print(url)
	let endpoint = NSURL(string: url)
	
	if let data = NSData(contentsOfURL: endpoint!){
	//	var firstLoc = true
	if let json: NSDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as? //
	NSDictionary {
	if let items = json["Dealer"] as? NSArray {
	for item in items {
	print(item)
	if let dName = item["DealerName"] as? String {
	s.dealerName = dName
	print(dName)
	}
	}}
	}
	}
	}
	)
	}
	*/
	/*
	func locationManager(manager: CLLocationManager, didDetermineState state: CLRegionState, forRegion region: CLRegion) {
	
	switch state {
	
	case .Unknown:
	print("unknown")
	
	case .Inside:
	
	var text = "Tap here to start coding."
	
	if enteredRegion {
	text = "Welcome to the best co-working space on the planet."
	}
	
	let notification: UILocalNotification = UILocalNotification()
	notification.timeZone = NSTimeZone.defaultTimeZone()
	
	let dateTime = NSDate()
	notification.fireDate = dateTime
	notification.alertBody = text
	UIApplication.sharedApplication().scheduleLocalNotification(notification)
	print(text)
	case .Outside:
	
	var text = "Why aren't you here? :("
	
	if !enteredRegion {
	text = "Wait! Don't go into the light."
	}
	print(text)
	let notification: UILocalNotification = UILocalNotification()
	notification.timeZone = NSTimeZone.defaultTimeZone()
	
	let dateTime = NSDate()
	notification.fireDate = dateTime
	notification.alertBody = text
	UIApplication.sharedApplication().scheduleLocalNotification(notification)
	
	}
	}
	*/
	
	var isClosed = false
	var runclosed = false
	var test1 = true
	var	beaconList:NSNumber?
	private var beaconTimeCheck: Dictionary<String, NSDate> = [:]
	private var dealerBeaconTimeCheck: Dictionary<String, NSDate> = [:]
	private var beaconTimeout: NSTimeInterval = 6 // 10 mins in seconds
	
	func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
		if beacons.isEmpty { return }
		var foundProductBeacons: Array<Beacon> = []
		var foundDealerBeacons: Array<Beacon> = []
		for b: CLBeacon in beacons {
			
			// find product beacons
			for knownBeacon in self.productBeacons {
				
				if b.major == knownBeacon.major && b.minor == knownBeacon.minor && (b.proximity == .Immediate) { // immediate is within 6 inches
					// only add to the list if we haven't seen this beacon within the time interval
					if let timeLastSeen: NSDate = beaconTimeCheck[knownBeacon.uniqueIdentifier] {
						let interval: NSTimeInterval = NSDate().timeIntervalSinceDate(timeLastSeen) // # seconds since we last saw the beacon
						if interval > beaconTimeout {
							foundProductBeacons.append(knownBeacon)
							s.prefs.foundDealerBeacon(false)
							beaconTimeCheck[knownBeacon.uniqueIdentifier] = NSDate()
						}
					} else {
						foundProductBeacons.append(knownBeacon)
					}
				}
			}
			
			// find dealer beacons
			for dealerBeacon in self.dealerBeacons {
				if b.major == dealerBeacon.major && b.minor == dealerBeacon.minor {
					//	if let _: NSDate = dealerBeaconTimeCheck[dealerBeacon.uniqueIdentifier] {
					// only report the dealer beacon if we haven't seen it before in this app launch
					//	} else {
					foundDealerBeacons.append(dealerBeacon)
					dealerBeaconTimeCheck[dealerBeacon.uniqueIdentifier] = NSDate()
					//}
				}
			}
		}
		
		// foundProductBeacons is the list of beacons that the phone is basically sitting on
		// foundDealerBeacons is the list of beacons found that belong to the dealer
		let viewController = FoundBeaconProduct()
		
		if foundDealerBeacons.count > 0 {
			
			if s.navCheck && !s.prefs.hasSeenDealerBeacon() {
				s.prefs.foundDealerBeacon(true)
				s.prefs.dealerID(foundDealerBeacons[0].dealer)
				s.prefs.setDealerBeacon(foundDealerBeacons[0].nameDealer)
				coreData.setDealersVisited(foundDealerBeacons[0].dealer)
				let url = NSURL(string: "https://Kawasakimobileappapi.gofuse.com/api/BeaconMetric/\(s.prefs.getPhID())/\(foundDealerBeacons[0].idbeac)/start")!
				let request = NSURLRequest(URL: url)
				NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
				}
				if allowPush{
					
					let localNotification = UILocalNotification()
					localNotification.fireDate = NSDate(timeIntervalSinceNow: 15)
					localNotification.alertBody = "Welcome to \(s.prefs.getBeaconDealer())"
					localNotification.timeZone = NSTimeZone.defaultTimeZone()
					localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
					UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
				}
				//	viewController.passedURL = "https://Kawasakimobileappapi.gofuse.com/mobileDealer/DealerDetails/\(s.prefs.getAppID())/\(s.prefs.getPhID())/\(foundDealerBeacons[0].dealer)*/\(s.prefs.getPhID())/\(foundDealerBeacons[0].idbeac)/stop"
				//		parentView.presentViewController(viewController, animated: true, completion: nil)
			} else {
				if foundProductBeacons.count > 0 {
					
					let url = NSURL(string: "https://Kawasakimobileappapi.gofuse.com/api/BeaconMetric/\(s.prefs.getPhID())/\(productBeacons[0].idbeac)/start")!
					let request = NSURLRequest(URL: url)
					NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
					}
					viewController.passedURL = "https://Kawasakimobileappapi.gofuse.com/mobileProduct/ProductDetailByURLKey/\(s.prefs.getAppID())/\(s.prefs.getPhID())/\(foundProductBeacons[0].name)/true*/\(s.prefs.getPhID())/\(foundProductBeacons[0].idbeac)/stop"
					print("https://Kawasakimobileappapi.gofuse.com/mobileProduct/ProductDetailByURLKey/\(s.prefs.getAppID())/\(s.prefs.getPhID())/\(foundProductBeacons[0].name)")
					coreData.setVehiclesExplored(foundProductBeacons[0].name)
					parentView.presentViewController(viewController, animated: true, completion: nil)
				}
			}
		}
		if UIApplication.sharedApplication().applicationState == .Active {
			
		}else{
			
		}
	}
	func locationManager(manager: CLLocationManager, didDetermineState state: CLRegionState, forRegion region: CLRegion) {
		
		switch state {
			
		case .Unknown:
			print("unknown")
			
		case .Inside:
			
			//	var text = "Tap here to start coding."
			
			if enteredRegion {
				if s.prefs.hasSeenDealerBeacon() {
					let localNotification = UILocalNotification()
					localNotification.fireDate = NSDate(timeIntervalSinceNow: 15)
					localNotification.alertBody = "Welcome to \(s.prefs.getBeaconDealer())"
					localNotification.timeZone = NSTimeZone.defaultTimeZone()
					localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
					UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
				}
			}
			
		case .Outside:
			
			//	var text = "Why aren't you here? :("
			
			if !enteredRegion {
				if s.prefs.hasSeenDealerBeacon() {
					let localNotification = UILocalNotification()
					localNotification.fireDate = NSDate(timeIntervalSinceNow: 15)
					localNotification.alertBody = "Welcome to \(s.prefs.getBeaconDealer())"
					localNotification.timeZone = NSTimeZone.defaultTimeZone()
					localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
					UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
				}
			}
			//	Notifications.display(text)
			
		}
	}
	
	
	
	func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
		enteredRegion = true
	}
	
	func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
		enteredRegion = false
	}
	
	
	func sendAlert(value: NSNumber){
		
	}
	
	
	func checkLocationAuthorization(){
		let p: Pref = Pref()
		switch (CLLocationManager.authorizationStatus()){
		case .NotDetermined:
			// The user has not yet made a choice regarding whether this app can use location services.
			
			break
			
		case .Restricted:
			// This app is not authorized to use location services. The user cannot change this app’s status, possibly due to active restrictions such as parental controls being in place.
			
			break
			
		case .Denied:
			p.hasTurnedOffLoc(true)
			break
			
		case .AuthorizedAlways:
			p.hasTurnedOffLoc(false)
			// This app is authorized to use location services.
			
			break
			
		case .AuthorizedWhenInUse:
			// This app is authorized to start most location services while running in the foreground. This authorization does not allow you to use APIs that could launch your app in response to an event, such as region monitoring and the significant location change services.
			break
		}
		
	}
}
