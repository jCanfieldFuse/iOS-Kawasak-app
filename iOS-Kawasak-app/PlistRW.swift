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
        //   print(dict)
        // Use your dict here
    }
    
    /************************************************************************************
    //  Create and insert the data into the Plist file  ....
    *************************************************************************************/
    let fileManager = (NSFileManager .defaultManager())
    let directorys : [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.AllDomainsMask, true) as? [String]
    
    if (directorys != nil){
    let directories:[String] = directorys!;
    let dictionary = directories[0]; //documents directory
    
    
    
    let plistfile = "myPlist.plist"
    var myDictionary: NSMutableDictionary = ["Content": "zzzz","Content1": "aaa"]
    let plistpath = dictionary.stringByAppendingPathComponent(plistfile);
    var error: NSError?
    if fileManager.removeItemAtPath(plistpath, error: &error) {
      //  println("Remove successful")
    } else {
      //   println("Remove failed: \(error!.localizedDescription)")
    }

        
        
    if !fileManager .fileExistsAtPath(plistpath){//writing Plist file
    myDictionary.writeToFile(plistpath, atomically: false)
    }
    else{            //Reading Plist file
   // println("Plist file found")
   // print(plistpath)
    
    let resultDictionary = NSMutableDictionary(contentsOfFile: plistpath)
   // println(resultDictionary?.description)
    }
    
    
    //  Create and insert the data into the Text file  ....
    let textfile = "myText.txt"
    let sampleText = "This is a sample text file ......... "
    
    let textpath = dictionary.stringByAppendingPathComponent(textfile);
    if !fileManager .fileExistsAtPath(textpath){//writing text file
    sampleText.writeToFile(textpath, atomically: false, encoding: NSUTF8StringEncoding, error: nil);
    } else{
    //Reading text file
    let reulttext  = String(contentsOfFile: textpath, encoding: NSUTF8StringEncoding, error: nil)
   // println(reulttext)
    }
    }
    else {
  //  println("directory is empty")
    }
    
    
    }
    
    func createPlist(){
        var error: NSError?
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        var documentsDirectory: String  = paths
        var path: String  = documentsDirectory.stringByAppendingPathComponent("data.plist")
        var fileManager: NSFileManager = NSFileManager.defaultManager()
        
        if !fileManager.fileExistsAtPath(path){
            if let bundle: String = NSBundle.mainBundle().pathForResource("data", ofType: "plist"){
                fileManager.copyItemAtPath(bundle, toPath: path, error: &error)
                if let err = error {
       //             println(err)
                }
            }
        }
        
        
        if(fileManager.fileExistsAtPath(path)){
            var data = NSMutableDictionary(contentsOfFile: path)!
            data.removeAllObjects()
            data.writeToFile(path, atomically: true)
        }

    }

    
    
    }
    
    
    