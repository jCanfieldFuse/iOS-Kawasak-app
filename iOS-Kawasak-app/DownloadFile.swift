//
//  DownloadFile.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 8/5/15.
//  Copyright (c) 2015 jon.canfield. All rights reserved.
//

import UIKit

class DownloadFile:NSObject, NSURLSessionDownloadDelegate {
    
    var task: NSURLSessionDownloadTask!
    
    var percentageWritten:Float = 0.0
    var taskTotalBytesWritten = 0
    var taskTotalBytesExpectedToWrite = 0
    
    var delegateDict: Dictionary<String, DownloadResponderDelegate> = [:]
    private var taskDict: Dictionary<NSURLSessionDownloadTask, String> = [:]
    
    lazy var session : NSURLSession = {
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        config.allowsCellularAccess = false
        let session = NSURLSession(configuration: config, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        return session
        }()
    
    
    func downloadFile(filePath: String, delegate: DownloadResponderDelegate){
        let url = NSURL(string:filePath)!
        delegateDict[filePath] = delegate
        let req = NSMutableURLRequest(URL:url)
        let task: NSURLSessionDownloadTask = self.session.downloadTaskWithRequest(req)
        taskDict[task] = filePath
        self.task = task
        print("_+_+_+_+_+_+_+_+_+_")
        task.resume()
        
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten writ: Int64, totalBytesExpectedToWrite exp: Int64) {

    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        // unused in this example
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {

    }
    
    // this is the only required NSURLSessionDownloadDelegate method
      func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        let documentsDirectoryURL =  NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first as! NSURL
        var err:NSError?
        
        let toFile: NSURL = documentsDirectoryURL.URLByAppendingPathComponent(downloadTask.response!.suggestedFilename!)
        
        if NSFileManager().moveItemAtURL(location, toURL: toFile, error: &err) {
            if let originalURL: String = taskDict[downloadTask] {
             print("_+_+_+_+++_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_")
                delegateDict[originalURL]?.didFinishDownloadingFileFromURL(originalURL, toFile: toFile)
                
            }
        } else {
            if let err = err {
            }
        }
        
    }
    
}

protocol DownloadResponderDelegate {
    func didFinishDownloadingFileFromURL(url: String, toFile: NSURL)
}