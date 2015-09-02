//
//  sectionList.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 7/28/15.
//  Copyright (c) 2015 jon.canfield. All rights reserved.
//

import UIKit

class RaceResultsFiltered: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var items: [String] = ["Schedule", "News", "Race Results","More"]
	var dataPassed: String = ""
	
	@IBOutlet weak var tableListItems: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableListItems.delegate = self
		tableListItems.dataSource = self
		tableListItems.registerClass(tableCellRacing.classForCoder(), forCellReuseIdentifier: "MyTableCell")
		tableListItems.tableFooterView = UIView()
		/****************************************************************************************************************************************************************************
		go to view for which does not have a stoyboard segue
		// let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("beaconScreen") as! UIViewController;
		// self.presentViewController(viewController, animated: false, completion: nil)
		* ***************************************************************************************************************************************************************************/
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell: tableCellRacing = tableView.dequeueReusableCellWithIdentifier("MyTableCell") as! tableCellRacing
		// do whatever with the class
		cell.textLabel?.text = self.items[indexPath.row]
		
		cell.textLabel?.textColor = UIColor.greenColor()
		// cell.te
		//   if ( indexPath.row % 2 == 0 ){
		//   cell.backgroundColor = UIColor.blackColor()
		//    cell.layer.frame.height = 2
		//  }else{
		cell.backgroundColor = UIColor.grayColor()
		//   }
		return cell
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.items.count;
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
	//	self.performSegueWithIdentifier("raceResultDetials", sender: self)
		   switch (indexPath.row){
		case 0:
		self.performSegueWithIdentifier("schedule", sender: self)
		break
		case 1:
		self.performSegueWithIdentifier("racingNews", sender: self)
		break
		case 2:
		self.performSegueWithIdentifier("raceResults", sender: self)
		break
		case 3:
		self.performSegueWithIdentifier("moreInfo", sender: self)
		break
		default:
		break;
		}
		
		
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		//    if segue.identifier == "Name" {
		//        segue.destinationViewController   .setup("Info")
		//    }
	}
}


class tableCellRacing: UITableViewCell {
	var thing: Int = 0
	var delegate: AnyObject?
}
