//
//  raceResults.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 9/1/15.
//  Copyright (c) 2015 jon.canfield. All rights reserved.
//

import UIKit

class VisitedDealers: UIViewController, UITableViewDelegate, UITableViewDataSource{
	
	
	var screen = UIScreen.mainScreen().bounds
	var racingHeader = UIView()
	var hamburger = UIButton()
	//	var racingWebView = UIWebView()
	//	var footer:Footer = Footer()
	var burger: BurgerMenu = BurgerMenu()
	let coreData: CoreDataModel = CoreDataModel()
	var fadeView = UIView()
	var passedURL: String = ""
	var passIn:Int = 0
	var spinner = UIActivityIndicatorView()
	var nearBy: [nearByDealer] = []
	var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
	var tableList =  UITableView()
	var storeName = UILabel()
	let color:hexColor = hexColor()
	var url = ""
	override func viewDidLoad() {
		super.viewDidLoad()
		burger.pickView = 1
		burger.parentView = self
		self.navigationController?.navigationBarHidden = true
		//	racingWebView.delegate = self
		self.view.backgroundColor = UIColor.blackColor()
		fadeView.frame = CGRectMake(0, 0, screen.width, screen.height)
		fadeView.backgroundColor = UIColor.blackColor()
		fadeView.alpha = 0.8
		
		tableList.delegate = self
		tableList.dataSource = self
		tableList.registerClass(tableCellDealer.classForCoder(), forCellReuseIdentifier: "TableCell")
		tableList.frame = CGRectMake(0, 40, screen.width, screen.height)
		tableList.backgroundColor = UIColor.blackColor()
		tableList.tableFooterView = UIView(frame: CGRect.zero)
//		tableList.tableFooterView = UIView()
		self.view.addSubview(tableList)
		
		let racingHeader = UIView()
		racingHeader.frame = CGRectMake(0, 0, screen.width, 60)
		racingHeader.backgroundColor = UIColor.blackColor()
		self.view.addSubview(racingHeader)
		
		let hamburgerV = UIView()
		hamburgerV.frame = CGRectMake(20, 15, 40,40)
		hamburgerV.backgroundColor = UIColor.blackColor()
		let topRecognizer = UITapGestureRecognizer(target: self, action:"openMenu:")
		hamburgerV.addGestureRecognizer(topRecognizer)
		hamburgerV.userInteractionEnabled = true
		racingHeader.addSubview(hamburgerV)
		
		let hamburger = UIButton()
		hamburger.frame = CGRectMake(20, 15, 30,30)
		hamburger.setBackgroundImage(UIImage(named: "HamburgerMenu_Button_Top"), forState: .Normal)
		hamburger.contentHorizontalAlignment = .Center
		hamburger.addTarget(self, action: "openMenu:", forControlEvents: UIControlEvents.TouchUpInside)
		racingHeader.addSubview(hamburger)
		let headerText = UILabel()
		
		storeName.frame = CGRectMake(40,  10, 50 + 15, 45)
		storeName.textColor = UIColor.whiteColor()
		storeName.font = UIFont(name: "Signika-Light", size: 25)
		
		
		let myText  = "Explored Dealers"
		headerText.textColor = UIColor.whiteColor()
		let	myMutableString = NSMutableAttributedString(string: myText, attributes: [NSFontAttributeName:UIFont(name: "Signika-Light", size: 18.0)!])
		myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.grayColor(), range: NSRange(location:8,length:8))
		headerText.attributedText = myMutableString
		headerText.frame = CGRectMake(hamburger.frame.width + 35, 15, screen.width - hamburger.frame.width, 30)
		racingHeader.addSubview(headerText)

		//let url = NSURL (string: passedURL)
		
		self.view.addSubview(racingHeader)
		racingHeader.addSubview(hamburger)
		racingHeader.addSubview(headerText)
		//	self.view.addSubview(racingWebView)
		//self.view.addSubview(fadeView)
		self.view.addSubview(burger)
		
		actInd.frame = CGRectMake((screen.width * 0.5) - 20, (screen.height * 0.5) - 20, 40.0, 40.0);
		actInd.hidesWhenStopped = true
		actInd.activityIndicatorViewStyle =	UIActivityIndicatorViewStyle.WhiteLarge
		self.view.addSubview(actInd)
		actInd.startAnimating()
		getDealers()
		
	}
	
	func getDealers(){
		//		https://Kawasakimobileappapi.gofuse.com/mobileappapi/GetDealersDetails/E7A9B1A8-241A-40DE-BAD1-330C7FF9C1A4/DB53531F-B4B2-47FE-95F3-9F1CADDA6111/AAC3176F-5FE5-4F87-A6A5-C284DEA97799
		let dealers = coreData.getDealersExploredCount()
		dispatch_async(dispatch_get_main_queue(),{
			self.nearBy = []
	//		print(passedURL)
			let url = "https://Kawasakimobileappapi.gofuse.com/mobileappapi/GetDealersDetails/E7A9B1A8-241A-40DE-BAD1-330C7FF9C1A4/DB53531F-B4B2-47FE-95F3-9F1CADDA6111/\(dealers.values)"
		//	print(url)
			let endpoint = NSURL(string: url)
			if let data = NSData(contentsOfURL: endpoint!){
				if let json: NSDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as? NSDictionary, let items = json["DealerDetailList"] as? NSArray {
					for item in items {
						print(item)
						let nbd: nearByDealer = nearByDealer()
						if let name = item["DealerName"] as? String{
							if let dealerID = item["DealerID"] as? String{
								if let addy1 = item["Address1"] as? String{
									if let city = item["City"] as? String{
										if let state = item["State"] as? String{
											if let zip = item["Zip"] as? String{
												nbd.zip = zip
											}
											nbd.state = state
										}
										nbd.city = city
									}
									nbd.addy = addy1
								}
								nbd.IDdealer =  dealerID
							}
							nbd.name =  name
						}
						self.nearBy.append(nbd)
					}
					print(self.nearBy)
				self.tableList.reloadData()
				self.actInd.stopAnimating()
				}
			}
		})
	}
	
	func webViewDidStartLoad(webView: UIWebView) {
		actInd.startAnimating()
		
		
	}
	
	func webViewDidFinishLoad(webView: UIWebView) {
		actInd.stopAnimating()
		UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
			self.fadeView.alpha = 0
			}, completion: { finished in
		})
		
	}
	
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func openMenu(sender: UIButton!){
		burger.openMenu()
		
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
	//	print("sup fool")
		let cell: tableCellDealer = tableView.dequeueReusableCellWithIdentifier("TableCell") as! tableCellDealer
		cell.nameLabel.frame = CGRectMake(40,  0, cell.frame.width + 15, 45)
		cell.nameLabel.textColor = UIColor.whiteColor()
		cell.nameLabel.text = self.nearBy[indexPath.row].name
		cell.nameLabel.font = UIFont(name: "Signika-Light", size: 25)
		cell.addSubview(cell.nameLabel)
		
		
		cell.addyLabel.frame = CGRectMake(storeName.frame.origin.x, storeName.frame.origin.y + storeName.frame.height - 20, cell.frame.width + 15, 60)
		cell.addyLabel.textColor = color.rgbColor(0x02c102)
		cell.addyLabel.font = UIFont(name: "Signika-Light", size: 15)
		cell.addyLabel.numberOfLines = 0
		cell.addyLabel.text = "\( self.nearBy[indexPath.row].addy) \n" + "\( self.nearBy[indexPath.row].city) " + "\( self.nearBy[indexPath.row].state) " + "\( self.nearBy[indexPath.row].postalCode) "
	//	print("\( self.nearBy[indexPath.row].addy) \n" + "\( self.nearBy[indexPath.row].city) " + "\( self.nearBy[indexPath.row].state) " + "\( self.nearBy[indexPath.row].zip) ")
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
		self.url = "https://Kawasakimobileappapi.gofuse.com/mobiledealer/DealerDetails/\(s.prefs.getAppID())/\(s.prefs.getPhID())/\(self.nearBy[indexPath.row].IDdealer)"
		self.performSegueWithIdentifier("toExplored", sender: self)
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	if (segue.identifier == "toExplored") {
	let svc = segue.destinationViewController as! DealersDetail
			svc.passedURL = self.url
	}
	
	}
	
}
class tableCellFoundDealer: UITableViewCell {
	var thing: Int = 0
	var delegate: AnyObject?
	var nameLabel: UILabel = UILabel()
	var addyLabel: UILabel = UILabel()
}

class foundDealers: NSObject {
	
	var name: String = ""
	var zip: String = ""
	var addy: String = ""
	var city: String = ""
	var state: String = ""
	var postalCode: String = ""
	var IDdealer: String = ""
	
}

