//
//  sectionList.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 7/28/15.
//  Copyright (c) 2015 jon.canfield. All rights reserved.
//

import UIKit

class MyKawasakiList: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //  var color = colors()
    var items: [String] = ["My Owned", "Dealer Favorites", "My Dealer"]
    //  @IBOutlet weak var tableListItems: UITableView!
    var selectedCell: String = ""
    
	@IBOutlet weak var userInfo: UILabel!
    @IBOutlet weak var tableListItems: UITableView!
    
	
	@IBOutlet weak var userEmail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //  tableListItems.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))?.textLabel?.text = "Magdasdasdsadsad:"
        userInfo.text = "Jonathan Canfield"
			userEmail.text = "jon.canfield@gofuse.com"
        tableListItems.delegate = self
        tableListItems.dataSource = self
        tableListItems.registerClass(tableCellMyKawasaki .classForCoder(), forCellReuseIdentifier: "MyKawasakiDetails")
        tableListItems.tableFooterView = UIView()
        //  //   menuButton.backgroundColor = color.getColorByName("green")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: tableCellMyKawasaki = tableView.dequeueReusableCellWithIdentifier("MyKawasakiDetails") as! tableCellMyKawasaki
        // do whatever with the class
        cell.textLabel?.text = self.items[indexPath.row]
        
        cell.textLabel?.textColor = UIColor.greenColor()
        // cell.te
        if ( indexPath.row % 2 == 0 ){
            cell.backgroundColor = UIColor.blackColor()
        }else{
            cell.backgroundColor = UIColor.grayColor()
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
           switch (indexPath.row){
        case 0:
            selectedCell = items[indexPath.row]
						self.performSegueWithIdentifier("MyKawasakiOwned", sender: self)
            break
        case 1:
            selectedCell = items[indexPath.row]
						self.performSegueWithIdentifier("MyKawasakiFav", sender: self)
            break
        case 2:
            selectedCell = items[indexPath.row]
						self.performSegueWithIdentifier("MyKawasakiDealer", sender: self)
            break
        case 3:
            selectedCell = items[indexPath.row]
            break
        default:
        break;
        }
//        self.performSegueWithIdentifier("MyKawasakiOwned", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "MyKawasakiOwned") {
            var svc = segue.destinationViewController as! MyKawasakiOwned
     //       svc.dataPassed = selectedCell
          //  svc.secondDataPassed = fieldB.text
        }
    }
}


class tableCellMyKawasaki: UITableViewCell {
    var thing: Int = 0
    var delegate: AnyObject?
}
