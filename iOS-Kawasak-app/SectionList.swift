//
//  sectionList.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 7/28/15.
//  Copyright (c) 2015 jon.canfield. All rights reserved.
//

import UIKit

class SectionList: UIViewController, UITableViewDataSource, UITableViewDelegate, DownloadResponderDelegate {
    @IBOutlet weak var tableListItems: UITableView!
    
    	let color:hexColor = hexColor()
    @IBOutlet weak var mainImage: UIImageView!
    
    
    var items: [String] = ["My Kawasaki", "Racing", "Dealer","History"]
    let s: Singleton = Singleton.sharedInstance
    var plist: PlistRW = PlistRW()
    let downloader: DownloadFile = DownloadFile()
    let imagePicker: MyApi = MyApi()
    var selectedCell:String = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableListItems.delegate = self
        tableListItems.dataSource = self
        tableListItems.registerClass(tableCell.classForCoder(), forCellReuseIdentifier: "MyTableCell")
        tableListItems.tableFooterView = UIView()
        plist.getPlist()
        downloader.downloadFile("https://content.kawasaki.com/Images/kawasaki-logo.png", delegate: self)
        mainImage.image = UIImage(named: imagePicker.getImagefromFolder("kawasaki-logo.png"))
               
        
    }
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: tableCell = tableView.dequeueReusableCellWithIdentifier("MyTableCell") as! tableCell
   
        cell.textLabel?.text = self.items[indexPath.row]
        cell.textLabel?.textColor = color.rgbColor(0x02c102)
   
      //  if ( indexPath.row % 2 == 0 ){
      //      cell.backgroundColor = UIColor.blackColor()
      //  }else{
            cell.backgroundColor = UIColor.grayColor()
     //   }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.items.count;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.row){
        case 0:
            self.performSegueWithIdentifier("myKawasaki", sender: self)
        break
        case 1:
            self.performSegueWithIdentifier("racing", sender: self)
        break
        case 2:
            self.performSegueWithIdentifier("dealer", sender: self)
        break
        case 3:
            self.performSegueWithIdentifier("history", sender: self)
        break
        default:
        break;
        }

    }
    
    func didFinishDownloadingFileFromURL(url: String, toFile: NSURL) {
        
        var imageName = "\(toFile)".componentsSeparatedByString("/")
        mainImage.image = UIImage(named: imagePicker.getImagefromFolder(imageName[imageName.count - 1]))
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
       
        if (segue.identifier == "racing") {
            var svc = segue.destinationViewController as! RacingList
         //   svc.dataPassed = selectedCell
            //  svc.secondDataPassed = fieldB.text
        }
    }
    
}


class tableCell: UITableViewCell {
    var thing: Int = 0
    var delegate: AnyObject?
}

