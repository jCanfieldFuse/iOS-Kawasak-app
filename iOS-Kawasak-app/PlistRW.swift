//
//  PlistRW.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 8/4/15.
//  Copyright (c) 2015 jon.canfield. All rights reserved.
//

import Foundation


class PlistRW: NSObject {

    func getPlist(){
//        var URL = NSURL(string: "http://lab.vpgroup.com.br/aplicativos/teste-catalogo/lista.plist")
       createPlist()
  //      load(URL!)
    /************************************************************************************
    //read plist
    *************************************************************************************/
    var myDict: NSDictionary?
    if let path = NSBundle.mainBundle().pathForResource("Info", ofType: "plist") {
        myDict = NSDictionary(contentsOfFile: path)
    }
    if let dict = myDict as? Dictionary<String, AnyObject>  {
           //print(dict)
        // Use your dict here
    }
    
    /************************************************************************************
    //  Create and insert the data into the Plist file  ....
    *************************************************************************************/
    let fileManager = (NSFileManager .defaultManager())
    let directorys : [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.AllDomainsMask, true)
    
    if (directorys != nil){
 //   let directories:[String] = directorys!;
   // let dictionary = directories[0]; //documents directory
    
    
    
    let plistfile = "myPlist.plist"
    let myDictionary: NSMutableDictionary = ["Content": "zzzz","Content1": "aaa"]
		let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
		let plistpath = String(documentsURL.URLByAppendingPathComponent(plistfile))
			
   // let plistpath = dictionary.stringByAppendingPathComponent(plistfile)
    //var error: NSError?
    do {
        try fileManager.removeItemAtPath(plistpath)
      //  //println("Remove successful")
    } catch _ as NSError {
     //   error = error1
      //   //println("Remove failed: \(error!.localizedDescription)")
    }

        
        
    if !fileManager .fileExistsAtPath(plistpath){//writing Plist file
    myDictionary.writeToFile(plistpath, atomically: false)
    }
    else{            //Reading Plist file
   // //println("Plist file found")
   // //print(plistpath)
    
   // let resultDictionary = NSMutableDictionary(contentsOfFile: plistpath)
   // //println(resultDictionary?.description)
    }
    
    
    //  Create and insert the data into the Text file  ....
    let textfile = "myText.txt"
    let sampleText = "This is a sample text file ......... "
   
		let documentsURLs = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
		let textpath = String(documentsURLs.URLByAppendingPathComponent(textfile))
  
		if !fileManager .fileExistsAtPath(textpath){//writing text file
        do {
            try sampleText.writeToFile(textpath, atomically: false, encoding: NSUTF8StringEncoding)
        } catch _ {
        };
    } else{
    //Reading text file
    let reulttext  = try? String(contentsOfFile: textpath, encoding: NSUTF8StringEncoding)
    //print(reulttext)
    }
    }
    else {
  //  //println("directory is empty")
    }
    
    
    }
    
    func createPlist(){
        var error: NSError?
    //    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        let documentsDirectory =  NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]

        let path: String  = String(documentsDirectory.URLByAppendingPathComponent("data.plist"))
        let fileManager: NSFileManager = NSFileManager.defaultManager()
        
        if !fileManager.fileExistsAtPath(path){
            if let bundle: String = NSBundle.mainBundle().pathForResource("data", ofType: "plist"){
                do {
                    try fileManager.copyItemAtPath(bundle, toPath: path)
                } catch let error1 as NSError {
                    error = error1
                }
                if let err = error {
                    //print(err)
                }
            }
        }
        
        
        if(fileManager.fileExistsAtPath(path)){
            let data = NSMutableDictionary(contentsOfFile: path)!
            data.removeAllObjects()
            data.writeToFile(path, atomically: true)
        }

    }

    
    
    }
    
    
    