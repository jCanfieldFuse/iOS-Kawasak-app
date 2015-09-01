//
//  Singlton.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 7/30/15.
//  Copyright (c) 2015 jon.canfield. All rights reserved.
//

import Foundation
import CoreLocation

class Singleton {
    class var sharedInstance: Singleton {
        struct Static {
            static var instance: Singleton?
            static var token: dispatch_once_t = 0
        }
       
        dispatch_once(&Static.token) {
            Static.instance = Singleton()
        }
        return Static.instance!
    }
    //put shit here
    var locationManager: LocManager = LocManager()
   
    
}

