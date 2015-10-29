//
//  CoreData.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 10/8/15.
//  Copyright © 2015 jon.canfield. All rights reserved.
//

import CoreData
import UIKit
class CoreDataModel: NSObject {

	
	
	func setLegal(name: Bool) {
 	let appDelegate =	UIApplication.sharedApplication().delegate as! AppDelegate
		let managedContext = appDelegate.managedObjectContext!
		let entity =  NSEntityDescription.entityForName("Usage", inManagedObjectContext: managedContext)
		let person = NSManagedObject(entity: entity!,	insertIntoManagedObjectContext:managedContext)
		person.setValue(name, forKey: "legalAccept")
		var error: NSError?
		do {
			try managedContext.save()
		} catch let error1 as NSError {
			error = error1
			//print("Could not save \(error), \(error?.userInfo)")
		}
	}


	func getLegal() -> AnyObject{
		
		let appDelegate =	UIApplication.sharedApplication().delegate as! AppDelegate
		let managedContext = appDelegate.managedObjectContext!
		let fetchRequest = NSFetchRequest(entityName:"Usage")
		let _: NSError?
		var returnValue:AnyObject!
		
		do{
			let fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
			if let results = fetchedResults {
			//	people = results

				for i in results{
					let person = i

		  		returnValue = person.valueForKey("legalAccept")
		  		}
			} else {
				//print("Could not fetch")
			}
		}catch{}

		return returnValue != nil ?  returnValue! :  0

	}

	func deleteLegal(){
		//let appDelegate =	UIApplication.sharedApplication().delegate as! AppDelegate
	//	let managedContext = appDelegate.managedObjectContext!
	//	let fetchRequest = NSFetchRequest(entityName: "Usage")
	//	let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
	
	//	do {
	//		try myPersistentStoreCoordinator.executeRequest(deleteRequest, withContext: managedContext)
	//	} catch let error as NSError {
	// TODO: handle the error
	//	}
	}
	
	func setVehiclesExplored(id: String){
		let appDelegate =	UIApplication.sharedApplication().delegate as! AppDelegate
		let managedContext = appDelegate.managedObjectContext!
		let entity =  NSEntityDescription.entityForName("VehiclesExplored", inManagedObjectContext: managedContext)
		let vh = NSManagedObject(entity: entity!,	insertIntoManagedObjectContext:managedContext)
		vh.setValue(id, forKey: "exploredVehicles")
		var error: NSError?
		do {
			try managedContext.save()
		} catch let error1 as NSError {
			error = error1
			//print("Could not save \(error), \(error?.userInfo)")
		}
	}
	
	func setDealersVisited(id: String){
		let appDelegate =	UIApplication.sharedApplication().delegate as! AppDelegate
		let managedContext = appDelegate.managedObjectContext!
		let entity =  NSEntityDescription.entityForName("DealerHistory", inManagedObjectContext: managedContext)
		let vh = NSManagedObject(entity: entity!,	insertIntoManagedObjectContext:managedContext)
		vh.setValue(id, forKey: "dealersVisited")
		var error: NSError?
		do {
			try managedContext.save()
		} catch let error1 as NSError {
			error = error1
			//print("Could not save \(error), \(error?.userInfo)")
		}
	}
	
	
	func getVehiclesExplored() -> (count: Int, values: String) {
		
		let appDelegate =	UIApplication.sharedApplication().delegate as! AppDelegate
		let managedContext = appDelegate.managedObjectContext!
		let fetchRequest = NSFetchRequest(entityName:"VehiclesExplored")
		fetchRequest.returnsDistinctResults = true
		let _: NSError?
		var returnArr: Array<String> = []
		var dict: Dictionary<String, Bool> = [:]
		
		do{
			if let fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject] {
				for v in fetchedResults {
					let vehicle: VehiclesExplored = v as! VehiclesExplored
					dict[vehicle.exploredVehicles!] = true
				}
				for veh in dict.keys {
					returnArr.append(veh)
				}
			} else {
				//print("Could not fetch")
			}
		}catch{}
	
		return (returnArr.count, returnArr.joinWithSeparator(","))
	}

	func getDealersExploredCount()  -> (count: Int, values: String) {
		
		let appDelegate =	UIApplication.sharedApplication().delegate as! AppDelegate
		let managedContext = appDelegate.managedObjectContext!
		let fetchRequest = NSFetchRequest(entityName:"DealerHistory")
		fetchRequest.returnsDistinctResults = true
		let _: NSError?
		var returnArr: Array<String> = []
		var dict: Dictionary<String, Bool> = [:]
		
		do{
			if let fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject] {
				for v in fetchedResults {
					let vehicle: DealerHistory = v as! DealerHistory
					dict[vehicle.dealersVisited!] = true
				}
				for veh in dict.keys {
					returnArr.append(veh)
				}
			} else {
				//print("Could not fetch")
			}
		}catch{}
		//print(returnArr.joinWithSeparator(","))
		return (returnArr.count, returnArr.joinWithSeparator(","))
	}

	
	
}