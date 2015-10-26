
//
//  FindDealer.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 10/8/15.
//  Copyright © 2015 jon.canfield. All rights reserved.
//

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
class FindDealer: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource{
	var screen = UIScreen.mainScreen().bounds
	let color:hexColor = hexColor()
	let locationManager = CLLocationManager()
	let initialLocation = CLLocation(latitude: 33.549121, longitude: -117.780374)
	let regionRadius: CLLocationDistance = 1000
	var zipcode = UITextField()
	var locDealer:LocateDealerHeader = LocateDealerHeader()
	var mapView = MKMapView()
	
	var nearBy: [nearByDealer] = []
	var passedInfo:String = ""
	var currentLocation:String = ""
	var firstRun = true
	
	var storeName = UILabel()
	var storeAddy = UILabel()
	
	var detailsButton = UIButton()
	var loadingLable =  UILabel()
	var loadingSpinner = UIActivityIndicatorView()
	var	latitude:CLLocationDegrees!
	var longitude:CLLocationDegrees!
	var dealerName:String!
	let background = UIView()
	let c:hexColor = hexColor()
	let phoneNumber = UILabel()
	let phoneBG = UIView()
	let phoneIcon = UIImageView()
	var tableList =  UITableView()
	override func viewDidLoad() {
		super.viewDidLoad()

		locDealer.parentView = self
		locDealer.locate = false
		self.navigationController?.navigationBarHidden = true
	//	self.view.backgroundColor =  c.rgbColor(0x161719)
		
		tableList.delegate = self
		tableList.dataSource = self
		tableList.registerClass(tableCellDealer.classForCoder(), forCellReuseIdentifier: "TableCell")
		tableList.tableFooterView = UIView()
		mapView.frame	= CGRectMake(0, 0, screen.width , screen.height * 0.51 + 4)
		self.view.addSubview(mapView)
		
		let bottomView = UIView()
		bottomView.frame = CGRectMake(0, mapView.frame.height, screen.width, 75)
		bottomView.backgroundColor = UIColor.blackColor()
		self.view.addSubview(bottomView)
		
		zipcode.frame = CGRectMake(10,  15, screen.width - 65, 42)
		zipcode.placeholder = "Enter zip code"
		zipcode.font = UIFont(name: "Signika-Light", size: 25)
		zipcode.backgroundColor = UIColor.whiteColor()
		
		

		let zipCodeSearch = UIButton()
		zipCodeSearch.frame = CGRectMake(zipcode.frame.origin.x + zipcode.frame.width, zipcode.frame.origin.y, zipcode.frame.height, zipcode.frame.height)
		zipCodeSearch.setImage(UIImage(named: "search-icon"), forState: .Normal)
		zipCodeSearch.setTitle("Button", forState: UIControlState.Normal)
		zipCodeSearch.addTarget(self, action: "zipCodeSearch:", forControlEvents: UIControlEvents.TouchUpInside)
	
		bottomView.addSubview(zipCodeSearch)
		bottomView.addSubview(zipcode)
		
		tableList.frame = CGRectMake(0, bottomView.frame.origin.y + 75, screen.width, screen.height -  bottomView.frame.origin.y + bottomView.frame.height - 150  )
		tableList.backgroundColor = UIColor.blackColor()
		self.view.addSubview(tableList)
		
		background.frame = CGRectMake(0, bottomView.frame.origin.y + 75, screen.width, screen.height - bottomView.frame.height)
		background.backgroundColor = c.rgbColor(0x5b5c5a)
	//	self.view.addSubview(background)

		storeName.frame = CGRectMake(40,  10, zipcode.frame.width + 15, 45)
		storeName.textColor = UIColor.whiteColor()
		storeName.font = UIFont(name: "Signika-Light", size: 25)
		//background.addSubview(storeName)
		
		storeAddy.frame = CGRectMake(storeName.frame.origin.x, storeName.frame.origin.y + storeName.frame.height - 20, zipcode.frame.width + 10, 60)
		storeAddy.textColor = color.rgbColor(0x02c102)
		storeAddy.font = UIFont(name: "Signika-Light", size: 15)
		storeAddy.numberOfLines = 0
		storeAddy.userInteractionEnabled = true
		let MiddleRecognizer = UITapGestureRecognizer(target: self, action:"goToMap:")
		storeAddy.addGestureRecognizer(MiddleRecognizer)
		//background.addSubview(storeAddy)
		
		
		phoneBG.frame = CGRectMake(0, screen.height - 100, screen.width, 40)
		phoneBG.backgroundColor = color.rgbColor(0x02c102)
		let topRecognizerV = UITapGestureRecognizer(target: self, action:"callDealer:")
		phoneBG.addGestureRecognizer(topRecognizerV)
		phoneBG.userInteractionEnabled = true
	//	self.view.addSubview(phoneBG)
		phoneBG.alpha = 0
		
		phoneIcon.frame = CGRectMake(40, -1 , 45, 45)
		phoneIcon.image = UIImage(named: "Phone_Icon")
		//phoneBG.addSubview(phoneIcon)

		phoneNumber.frame = CGRectMake(phoneIcon.frame.origin.x + 45, -1 , zipcode.frame.width + 15, 45)
		phoneNumber.textColor = UIColor.whiteColor()
		phoneNumber.font = UIFont(name: "Signika-Light", size: 25)
		//phoneBG.addSubview(phoneNumber)
		/*
		detailsButton.frame = CGRectMake(20, screen.height - 100, screen.width - 40, 40)
		detailsButton.setTitle("See Details", forState: .Normal)
		detailsButton.addTarget(self, action: "moreDetails:", forControlEvents: UIControlEvents.TouchUpInside)
		detailsButton.backgroundColor = color.rgbColor(0x02c102)
		self.view.addSubview(detailsButton)
		detailsButton.alpha = 0
		*/
		self.locationManager.delegate = self
		self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
		self.locationManager.requestWhenInUseAuthorization()
		locationManager.delegate = self
		locationManager.requestAlwaysAuthorization()
		self.locationManager.startUpdatingLocation()
		/*
		NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillAppear:", name: UIKeyboardWillShowNotification, object: nil)
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
		view.addGestureRecognizer(tap)
		addDoneButtonOnKeyboard()
		
		//loadingSpinner.startAnimating()
		self.view.addSubview(locDealer)*/
		let backgroundC = UIButton()
		backgroundC.frame = CGRectMake(0, 0, screen.width * 0.5, screen.width * 0.3)
		backgroundC.addTarget(self, action: "close:", forControlEvents: .TouchUpInside)
		backgroundC.setBackgroundImage(UIImage(named: "CloseFindDealerOverlay_Button"), forState: .Normal)
		self.view.addSubview(backgroundC)
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
  	self.view.frame.origin.y = 00
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

					if self.firstRun{
						self.getStore(pm.postalCode!)
						self.locationManager.stopUpdatingLocation()
						self.firstRun = false
					}
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
		//  //println("Error: " + error.localizedDescription)
	}
 
	@IBAction func zipCodeSearch(sender: AnyObject) {
		getStore(self.zipcode.text!)
	}
	func keyboardDone(){
		//getStore(zipcode.text!)
		
		self.view.frame.origin.y = 00
		self.view.endEditing(true)
	}
	
	func keyboardWillAppear(notification: NSNotification){
		
		self.view.frame.origin.y = -50
	}
	
	func getStore(zipcode: String){
	//	//print("1212")

		self.locationManager.startUpdatingLocation()
//		fadeIn()
		dispatch_async(dispatch_get_main_queue(),{
			let url = "https://mobileapp.fuse-review-kawasaki.com/mobileappapi/GetDealerByZip?zipcode=\(zipcode)"
			let endpoint = NSURL(string: url)
				self.nearBy = []
			if let data = NSData(contentsOfURL: endpoint!){
				var firstLoc = true
				if let json: NSDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as? NSDictionary, let items = json["Dealerships"] as? NSArray {
					for item in items {
					//	//print(item)
						if let lat = item["Latitude"] as? CLLocationDegrees, long = item["Longitude"] as? CLLocationDegrees, store = item["Name"] as? String, postalCode = item["PostalCode"] as? String, addy = item["Address"] as? String, city = item["City"] as? String, state = item["State"] as? String, phone = item["Phone"] as? String, dealerID = item["Id"] as? String{

							if (firstLoc){

							
								let initialLocation = CLLocation(latitude: lat, longitude: long)
								self.centerMapOnLocation(initialLocation)
								firstLoc = false
							}
								self.storeName.text = store
								self.phoneNumber.text = phone
								let	text = "\(addy) \n" + "\(city) " + "\(state) " + "\(postalCode) "
							
								let kText:NSMutableAttributedString = NSMutableAttributedString(string: text)
								kText.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSRange(location: 0, length: text.characters.count))
								self.storeAddy.attributedText = kText
							
								let nbd: nearByDealer = nearByDealer()
								nbd.name = store
								nbd.addy = addy
								nbd.city = city
								nbd.state = state
								nbd.postalCode = postalCode
								nbd.long = long
								nbd.lat = lat
								nbd.zip = postalCode
								nbd.IDdealer = dealerID
								//print(nbd.name)
								self.nearBy.append(nbd)
								firstLoc = false
								self.detailsButton.alpha = 1
								self.latitude = lat
								self.longitude = long
								self.dealerName = store
						//	}

							let dropPin = MKPointAnnotation()
							dropPin.coordinate = CLLocationCoordinate2DMake(lat,long)
							dropPin.title = store
							self.mapView.addAnnotation(dropPin)
							self.removeGray()
						}
					}
					self.tableList.reloadData()
				}
			}
			
	 });
		
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell: tableCellDealer = tableView.dequeueReusableCellWithIdentifier("TableCell") as! tableCellDealer
		cell.nameLabel.frame = CGRectMake(40,  0, cell.frame.width + 15, 45)
		cell.nameLabel.textColor = UIColor.whiteColor()
		cell.nameLabel.text = self.nearBy[indexPath.row].name
		cell.nameLabel.font = UIFont(name: "Signika-Light", size: 25)
		cell.addSubview(cell.nameLabel)
		

		cell.addyLabel.frame = CGRectMake(storeName.frame.origin.x, storeName.frame.origin.y + storeName.frame.height - 20, zipcode.frame.width + 10, 60)
		cell.addyLabel.textColor = color.rgbColor(0x02c102)
		cell.addyLabel.font = UIFont(name: "Signika-Light", size: 15)
		cell.addyLabel.numberOfLines = 0
		cell.addyLabel.text = "\( self.nearBy[indexPath.row].addy) \n" + "\( self.nearBy[indexPath.row].city) " + "\( self.nearBy[indexPath.row].state) " + "\( self.nearBy[indexPath.row].postalCode) "
		cell.addSubview(cell.addyLabel)

		cell.backgroundColor = UIColor.blackColor()
		return cell
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 100
	}
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.nearBy.count
	}
	

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		//print(self.nearBy[indexPath.row].IDdealer)
		let viewController = ExploreVehicles()
		viewController.passedURL = "https://mobileapp.fuse-review-kawasaki.com/mobiledealer/DealerDetails/\(s.prefs.getAppID())/\(s.prefs.getPhID())/\(self.nearBy[indexPath.row].IDdealer)"
		self.presentViewController(viewController, animated: true, completion: nil)
////print("yep")
	//	self.passedInfo = self.nearBy[indexPath.row].name
	//	self.performSegueWithIdentifier("moreDealerInfo", sender: self)
	}
	
	
	
	func goToMap(sender: AnyObject){
		let regionDistance:CLLocationDistance = 10000
		let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
		let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
		let options = [
			MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
			MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
		]
		let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
		let mapItem = MKMapItem(placemark: placemark)
		mapItem.name = "\(self.dealerName)"
		mapItem.openInMapsWithLaunchOptions(options)
	
	}
	
	func moreDetails(sender: UIButton!){

		//	self.performSegueWithIdentifier("moreDealerInfo", sender: self)
			}
/*
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if (segue.identifier == "moreDealerInfo") {
			let svc = segue.destinationViewController as! DealerInformation
			svc.dataPassed = passedInfo
			//  svc.secondDataPassed = fieldB.text
		}
	}
	*/
	func close(sender: AnyObject){
				self.navigationController?.popViewControllerAnimated(true)
	}
	
	
	func callDealer (sender: AnyObject){
		if let ph = self.phoneNumber.text{
		let number = "tel://" + ph

			UIApplication.sharedApplication().openURL(NSURL(string: number)!)
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
	
	func removeGray(){
		UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
			self.background.alpha = 0
			}, completion: { finished in
				self.background.alpha = 1
				self.background.backgroundColor = UIColor.blackColor()
				self.phoneBG.alpha = 1

//				UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
	//						self.background.alpha = 1
		//		})
	
		})
	}

}

class tableCellDealer: UITableViewCell {
	var thing: Int = 0
	var delegate: AnyObject?
	var nameLabel: UILabel = UILabel()
	var addyLabel: UILabel = UILabel()
}

class nearByDealer: NSObject {
	
	var name: String = ""
	var zip: String = ""
	var addy: String = ""
	var city: String = ""
	var state: String = ""
	var postalCode: String = ""
	var IDdealer: String = ""
	var lat: CLLocationDegrees?
	var long: CLLocationDegrees?
}





