//
//  dealer.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 7/29/15.
//  Copyright (c) 2015 jon.canfield. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class Dealer: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate{
	
	let locationManager = CLLocationManager()
	let initialLocation = CLLocation(latitude: 33.549121, longitude: -117.780374)
	let regionRadius: CLLocationDistance = 1000
	
	@IBOutlet weak var zipcode: UITextField!
	@IBOutlet weak var mapView: MKMapView!
	var nearBy: [nearByDealer] = []
	var passedInfo:String = ""
	var currentLocation:String = ""
	var firstRun = true
	//  var locDealers: [String] = []
	@IBOutlet weak var tableList: UITableView!
	
	@IBOutlet weak var loadingLable: UILabel!
	@IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableList.delegate = self
		tableList.dataSource = self
		tableList.registerClass(tableCellDealer.classForCoder(), forCellReuseIdentifier: "TableCell")
		tableList.tableFooterView = UIView()
		
		self.locationManager.delegate = self
		self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
		self.locationManager.requestWhenInUseAuthorization()
		locationManager.delegate = self
		locationManager.requestAlwaysAuthorization()
		self.locationManager.startUpdatingLocation()

		NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillAppear:", name: UIKeyboardWillShowNotification, object: nil)
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
		view.addGestureRecognizer(tap)
	  addDoneButtonOnKeyboard()
		
		loadingSpinner.startAnimating()
	}
	
	
	func addDoneButtonOnKeyboard(){
		let doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
		doneToolbar.barStyle = UIBarStyle.BlackTranslucent
		let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
		let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("keyboardDone"))
		var items = [UIBarButtonItem]()
		items.append(flexSpace)
		items.append(done)
		doneToolbar.items = items as [UIBarButtonItem]
		doneToolbar.sizeToFit()
		self.zipcode.inputAccessoryView = doneToolbar
	
	}
	
	//Calls this function when the tap is recognized.
	func DismissKeyboard(){
		view.endEditing(true)
	}
	
	func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
		mapView.showsUserLocation = (status == .AuthorizedAlways)
	}
	
	func centerMapOnLocation(location: CLLocation) {
		
		let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
	  regionRadius * 2.0, regionRadius * 2.0)
		mapView.setRegion(coordinateRegion, animated: true)
		fadeOut()
	}
	
	func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
			if (error != nil) {
				return
			}
			if placemarks!.count > 0 {
				if let pm = placemarks?.first {
					self.displayLocationInfo(pm)
					self.getStore(pm.postalCode!)
				}
			}
			
		})
		self.locationManager.stopUpdatingLocation()
	}
	
	func displayLocationInfo(placemark: CLPlacemark) {
		// let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
		//   centerMapOnLocation(initialLocation)
		
	}
	
	func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
		//  println("Error: " + error.localizedDescription)
	}
 
	@IBAction func zipCodeSearch(sender: AnyObject) {
		getStore(currentLocation)
	}
	func keyboardDone(){
		getStore(zipcode.text!)
		self.view.frame.origin.y = 00
		self.view.endEditing(true)
	}

	func keyboardWillAppear(notification: NSNotification){

			self.view.frame.origin.y = -50
	}
	
	func getStore(zipcode: String){
		fadeIn()
		dispatch_async(dispatch_get_main_queue(),{
		let url = "https://www.fuse-review-kawasaki.com/mobileappjsonapi/GetDealerByZip?zipCode=\(zipcode)"
 	  let endpoint = NSURL(string: url)
		
		if let data = NSData(contentsOfURL: endpoint!){
			var firstLoc = true
			if let json: NSDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as? NSDictionary, let items = json["Dealerships"] as? NSArray {
				for item in items {
					if let lat = item["Latitude"] as? CLLocationDegrees, long = item["Longitude"] as? CLLocationDegrees, store = item["Name"] as? String, postalCode =  item["PostalCode"] as? String{
						if (firstLoc){
							self.nearBy = []
							let initialLocation = CLLocation(latitude: lat, longitude: long)
							self.centerMapOnLocation(initialLocation)
							firstLoc = false
						}
						else{
							let nbd: nearByDealer = nearByDealer()
							nbd.name = store
							nbd.long = long
							nbd.lat = lat
							nbd.zip = postalCode
							self.nearBy.append(nbd)
						}
						let dropPin = MKPointAnnotation()
						dropPin.coordinate = CLLocationCoordinate2DMake(lat,long)
						dropPin.title = store
						self.mapView.addAnnotation(dropPin)
					}
				}
				self.tableList.reloadData()
			}
		}
			
	 });
	
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell: tableCellDealer = tableView.dequeueReusableCellWithIdentifier("TableCell") as! tableCellDealer
		cell.textLabel?.text = self.nearBy[indexPath.row].name
		cell.textLabel?.textColor = UIColor.greenColor()
		cell.backgroundColor = UIColor.grayColor()
		return cell
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.nearBy.count;
	}

	func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
		self.passedInfo = self.nearBy[indexPath.row].name
		self.performSegueWithIdentifier("moreDealerInfo", sender: self)
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if (segue.identifier == "moreDealerInfo") {
			let svc = segue.destinationViewController as! DealerInformation
			       svc.dataPassed = passedInfo
			//  svc.secondDataPassed = fieldB.text
		}
	}
	
	func fadeOut(){
		UIView.animateWithDuration(0.5, animations: {
			self.loadingLable.alpha = 0
			self.loadingSpinner.alpha = 0
		})
	}

	func fadeIn(){
		UIView.animateWithDuration(0.5, animations: {
			self.loadingLable.alpha = 1
			self.loadingSpinner.alpha = 1
		})
	}
	
}

	
class tableCellDealer: UITableViewCell {
	var thing: Int = 0
	var delegate: AnyObject?
}

class nearByDealer: NSObject {
	
	var name: String = ""
	var zip: String = ""
	var lat: CLLocationDegrees?
	var long: CLLocationDegrees?
}





