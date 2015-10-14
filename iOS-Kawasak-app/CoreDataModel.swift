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
		print("setting legal \(name)")
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
			print("Could not save \(error), \(error?.userInfo)")
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
				print(results.count)
				for i in results{
					let person = i
					print(person.valueForKey("legalAccept"))
		  		returnValue = person.valueForKey("legalAccept")
		  		}
			} else {
				print("Could not fetch")
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
	
	func setVehiclesExplored(id: Int){
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
			print("Could not save \(error), \(error?.userInfo)")
		}
	}
	
	func setDealersVisited(id: Int){
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
			print("Could not save \(error), \(error?.userInfo)")
		}
	}
	
	
	func getVehiclesExploredCount() -> Int{
		
		let appDelegate =	UIApplication.sharedApplication().delegate as! AppDelegate
		let managedContext = appDelegate.managedObjectContext!
		let fetchRequest = NSFetchRequest(entityName:"VehiclesExplored")
		let _: NSError?
		var returnValue = 0
		
		do{
			let fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
			if let results = fetchedResults {
				returnValue = results.count
			
			} else {
				print("Could not fetch")
			}
		}catch{}
		
		return returnValue
		
	}

	func getDealersExploredCount() -> Int{
		
		let appDelegate =	UIApplication.sharedApplication().delegate as! AppDelegate
		let managedContext = appDelegate.managedObjectContext!
		let fetchRequest = NSFetchRequest(entityName:"DealerHistory")
		let _: NSError?
		var returnValue = 0
		
		do{
			let fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
			if let results = fetchedResults {
				returnValue = results.count
				} else {
				print("Could not fetch")
			}
		}catch{}
		
		return returnValue
		
	}

	
	
}