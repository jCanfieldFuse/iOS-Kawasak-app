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
class LocManager: NSObject, CLLocationManagerDelegate {
	//var locMan: CLLocationManager = CLLocationManager()
    //let s: Singleton! = Singleton.sharedInstance
  //var locMan: CLLocationManager = CLLocationManager()
//	let manager = CLLocationManager()
	
	lazy var locMan: CLLocationManager! = {
  let manager = CLLocationManager()
  manager.desiredAccuracy = kCLLocationAccuracyBest
  manager.delegate = self
  manager.requestAlwaysAuthorization()
		
  return manager
		}()
	//var timer = NSTimer()
	
	let distance: CLLocationDistance = 20  // distance in meters
	var locations: Dictionary<String, CLLocationCoordinate2D> = [
		"Fuse Interactive": CLLocationCoordinate2D(latitude: 33.5496793, longitude: -117.7799548),
		"Tivoli": CLLocationCoordinate2D(latitude: 33.5482667, longitude: -117.7821278),
		"Seven Degrees": CLLocationCoordinate2D(latitude: 33.5502499, longitude: -117.7790292),
		"Sawdust": CLLocationCoordinate2D(latitude: 33.5506119, longitude: -117.7787891)
	]
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "F7826DA6-4FA2-4E98-8024-BC5B71E0893E"), identifier: "Estimotes")
    
	override init(){
		super.init()
		locMan.delegate = self
			//	timer = NSTimer(timeInterval: 1.0, target: self, selector: "countUp", userInfo: nil, repeats: true)
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            locMan.requestWhenInUseAuthorization()
        }
        
        region.notifyOnEntry = true
        region.notifyOnExit = true
        region.notifyEntryStateOnDisplay = true
        locMan.startRangingBeaconsInRegion(region)
		
		

		//		self.locationManager.delegate = self
		locMan.desiredAccuracy = kCLLocationAccuracyBest
		locMan.requestWhenInUseAuthorization()
		
		locMan.requestAlwaysAuthorization()
		locMan.startUpdatingLocation()

		
		// make sure the user has allowed location services
		checkLocationAuthorization()
		
		// set up your regions for notifications
		// apps can only monitor 20 regions at a time
		for locationName: String in locations.keys {
		//	println(locationName)
			if locMan.monitoredRegions.count >= 20 {
				// we're full up on regiuons to monitor.
				
				
			} else {
				let location: CLLocationCoordinate2D = locations[locationName]!
				let region: CLCircularRegion = CLCircularRegion(center: location, radius: distance, identifier: locationName)
				
				// tell the system when you want notifications
				region.notifyOnEntry = true
				region.notifyOnExit = true
				
				// add the region to the location manager
				locMan.startMonitoringForRegion(region)
			}
		}
		
		
	}
	var isClosed = false
	var	beaconList:NSNumber?
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
			for test in beacons {
				beaconList = test.minor
			
				if isClosed {
						println("here are the beacons \(test.major)")
					if (test.major == 7181 || test.major == 30516){
						sendAlert(test.major)
					}
				}
			}
			let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        if (knownBeacons.count > 0) {

           // let closestBeacon = knownBeacons[0] as! CLBeacon
           // println(closestBeacon)
				
				

						// beaconButton.setTitle("\(String(closestBeacon.minor.integerValue)) distannce \(String(closestBeacon.proximity.rawValue)) " , forState: .Normal)
        }
			if UIApplication.sharedApplication().applicationState == .Active {
								isClosed = false
  //  mapView.showAnnotations(locations, animated: true)
			} else {
				println("App is backgrounded. New location is \(beaconList) ")
				isClosed = true
				println("hello")
				locMan.startUpdatingLocation()
				//NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
			 
			}
    }
	}

func countUp() {
	println("counting soon")
	//binaryCount += 0b0001
	
//	if (binaryCount == 0b10000) { binaryCount = 0b0000 }
	
//	updateText()
	
}


	func sendAlert(value: NSNumber){


		println("whats up!!!!")
		var localNotification = UILocalNotification()
		localNotification.fireDate = NSDate(timeIntervalSinceNow: 5)
		localNotification.alertBody = "KAWASAKI APP beacon \(value)"
		localNotification.timeZone = NSTimeZone.defaultTimeZone()
		localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
		
		UIApplication.sharedApplication().scheduleLocalNotification(localNotification)

	}
	func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
		CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
			if (error != nil) {
				return
			}
			
			if placemarks.count > 0 {
				let pm = placemarks[0] as! CLPlacemark
				println(pm.postalCode)
				//				self.currentLocation = pm.postalCode
//				self.getStore(pm.postalCode)
				//				count(self.currentLocation) != 0 && self.firstRun ?	self.getStore(self.currentLocation) : print("empty")
				//				self.firstRun = true
				//				self.displayLocationInfo(pm)
				//			}else {
				
			}
			
		})

	}

	
	// an app can expect to receive the appropriate region entered or region exited notification within 3 to 5 minutes on average, if not sooner.
	func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
		// called when we entered a region
		println("You've entered \(region)")
	}
	
	func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
		println("You've excited \(region)")
		// called when we exit a region
	}
	
	func locationManager(manager: CLLocationManager!, monitoringDidFailForRegion region: CLRegion!, withError error: NSError!) {
		// called when some error happens
	}
	
	func checkLocationAuthorization(){
		switch (CLLocationManager.authorizationStatus()){
		case .NotDetermined:
			// The user has not yet made a choice regarding whether this app can use location services.
			
			break
			
		case .Restricted:
			// This app is not authorized to use location services. The user cannot change this app’s status, possibly due to active restrictions such as parental controls being in place.
			
			break
			
		case .Denied:
			// The user explicitly denied the use of location services for this app or location services are currently disabled in Settings.
			
			break
			
		case .AuthorizedAlways:
			// This app is authorized to use location services.
			
			break
			
		case .AuthorizedWhenInUse:
			// This app is authorized to start most location services while running in the foreground. This authorization does not allow you to use APIs that could launch your app in response to an event, such as region monitoring and the significant location change services.
			
			break
		default: break
		}
	}
	


