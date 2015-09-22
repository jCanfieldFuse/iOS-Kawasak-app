//
//  PagedScrollViewController.swift
//  ScrollViews
//
//

import UIKit
import CoreData

class PagedScrollViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    var people = [NSManagedObject]()
    var pageImages: [UIImage] = []
    var pageViews: [UIImageView?] = []
  	var aa:[String] = ["dasdasd","aaaaaaa","zzzzzzzzz","dasdasd","aaaaaaa","zzzzzzzzz","dasdasd","aaaaaaa","zzzzzzzzz","dasdasd","aaaaaaa","zzzzzzzzz","dasdasd","aaaaaaa","zzzzzzzzz","dasdasd","aaaaaaa","zzzzzzzzz"]
		let s: Singleton = Singleton.sharedInstance

		override func viewDidLoad() {
        super.viewDidLoad()
				// needs to be download
        pageImages = [UIImage(named:"image1.png")!,
											UIImage(named:"image2.png")!,
											UIImage(named:"image3.png")!,
											UIImage(named:"image4.png")!,]

       let pageCount = pageImages.count

  			pageControl.currentPage = 0
        pageControl.numberOfPages = pageCount
				pageControl.currentPageIndicatorTintColor = UIColor.greenColor()
			
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        
       let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat(pageImages.count), pagesScrollViewSize.height / 2)
				scrollView.frame = CGRectMake(0, 0, pagesScrollViewSize.width, pagesScrollViewSize.height / 2 )
				scrollView.backgroundColor = UIColor.whiteColor()
        loadVisiblePages()
		/*	var alert = UIAlertController(title: "V. 1", message: "Jason download", preferredStyle: UIAlertControllerStyle.Alert)
			alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
			self.presentViewController(alert, animated: true, completion: nil)
		*/

			/**************************************************************************************************************
			* check for beacon V. number if out os sync update. 														
			***************************************************************************************************************/
			savaDataTest()
			loadDataTest()

    }
	func savaDataTest(){

			
			let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
			
			defaults.setObject("self.firstNameTextField.text", forKey: "firstName")
			defaults.setObject("self.lastNameTextField.text", forKey: "lastName")
			defaults.setObject("self.emailTextField.text", forKey: "email")
			defaults.setObject(aa, forKey: "phoneNumber")
			print(aa, terminator: "")
			defaults.synchronize()
			

	}
	
	
	func loadDataTest(){
	
			
			let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
			
			if let firstNameIsNotNill = defaults.objectForKey("firstName") as? String {
			//	self.firstNameTextField.text = defaults.objectForKey("firstName") as String
			}
			
			if let lastNameIsNotNill = defaults.objectForKey("lastName") as? String {
			//	self.lastNameTextField.text = defaults.objectForKey("lastName") as String
			}
			
			if let emailIsNotNill = defaults.objectForKey("email") as? String {
		//		self.emailTextField.text = defaults.objectForKey("email") as String
			}
			
			if let phoneNumberIsNotNill = defaults.objectForKey("phoneNumber") as? String {
				let a  = defaults.objectForKey("phoneNumber") as! String
				print("dasdas")
				print(a)
			}
			

	}
	
	func addBeacon(id: Int){
		let appDelegate =	UIApplication.sharedApplication().delegate as! AppDelegate
		let managedContext = appDelegate.managedObjectContext!
		let entity =  NSEntityDescription.entityForName("Beacons", inManagedObjectContext: managedContext)
		let person = NSManagedObject(entity: entity!,	insertIntoManagedObjectContext:managedContext)
		person.setValue(id, forKey: "beaconID")
		var error: NSError?
		do {
			try managedContext.save()
		} catch let error1 as NSError {
			error = error1
			print("Could not save \(error), \(error?.userInfo)")
		}
	}

	func getBeacons(){

		let appDelegate =	UIApplication.sharedApplication().delegate as! AppDelegate
		let managedContext = appDelegate.managedObjectContext!
		let fetchRequest = NSFetchRequest(entityName:"Beacons")
		let error: NSError?
		do{
		let fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
		if let results = fetchedResults {
			people = results
			for i in people{
				let person = i
				print("++_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_")
				print(person.valueForKey("beaconID"), terminator: ""
				)
				print("++_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_")
			}
		} else {
			print("Could not fetch")
		}
	}catch{}
	}

	func deleteBeacons(){
		var a = 1
		let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		let context:NSManagedObjectContext = appDel.managedObjectContext!
		do {
			//		context.delete(a as NSManagedObject)
	//			.deleteObject("1")
		//	myData.removeAtIndex(indexPath.row)
			try context.save()
		} catch _ {
		}
	}
	
	func loadPage(page: Int) {
        if page < 0 || page >= pageImages.count {
            return
        }

        if let pageView = pageViews[page] {
        } else {

            var frame = scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            let newPageView = UIImageView(image: pageImages[page])
            newPageView.contentMode = .ScaleAspectFit
            newPageView.frame = frame
            scrollView.addSubview(newPageView)
            pageViews[page] = newPageView
        }
    }
    
    func purgePage(page: Int) {

        if page < 0 || page >= pageImages.count {
            return
        }
        if let pageView = pageViews[page] {
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
        
    }
    
    func loadVisiblePages() {
        
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        pageControl.currentPage = page
        let firstPage = page - 1
        let lastPage = page + 1
        
        for var index = 0; index < firstPage; ++index {
            purgePage(index)
        }
        
        for var index = firstPage; index <= lastPage; ++index {
            loadPage(index)
        }
        
        for var index = lastPage+1; index < pageImages.count; ++index {
            purgePage(index)
        }
    }
        

    func scrollViewDidScroll(scrollView: UIScrollView) {
        loadVisiblePages()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	/*
	// test for beacon version and beacon list.
	func getStore(){
	
		var endpoint = NSURL(string: http://www.fuse-review-kawasaki.com/mobileappjsonapi/GetDealerByZip?zipCode=92656)

		var data = NSData(contentsOfURL: endpoint!)
	
		var firstLoc = true
		if let json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary, let items = json["Dealerships"] as? NSArray {
			for item in items {
				println(item)
				if let store = item["Name"] as? String, postalCode =  item["PostalCode"] as? String{
  			
				/*	if (firstLoc){
						nearBy = []
						let initialLocation = CLLocation(latitude: lat, longitude: long)
						centerMapOnLocation(initialLocation)
						firstLoc = false
					}
					else{
						var nbd: nearByDealer = nearByDealer()
						nbd.name = store
						nbd.long = long
						nbd.lat = lat
						nbd.zip = postalCode
						nearBy.append(nbd)
					}
					let dropPin = MKPointAnnotation()
					dropPin.coordinate = CLLocationCoordinate2DMake(lat,long)
					dropPin.title = store
					mapView.addAnnotation(dropPin)
					
				}
				
			}
			
			tableList.reloadData()
		*/
//}
				}
			}
		}
	}
//	}
*/

}
