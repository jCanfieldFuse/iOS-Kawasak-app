//
//  MyApi.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 8/6/15.
//  Copyright (c) 2015 jon.canfield. All rights reserved.
//

import Foundation

class MyApi: NSObject {

    func getImagefromFolder(imageName: String) -> String{
        var image: String = ""
        let nsDocumentDirectory = NSSearchPathDirectory.DocumentDirectory
        let nsUserDomainMask    = NSSearchPathDomainMask.UserDomainMask
        if let paths            = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        {
            if paths.count > 0
            {
                if let dirPath = paths[0] as? String
                {
                    image = dirPath.stringByAppendingPathComponent(imageName)

                }
            }
        }
        return image
    }
    
}