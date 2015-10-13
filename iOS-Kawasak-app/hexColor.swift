//
//  hexColor.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 9/25/15.
//  Copyright © 2015 jon.canfield. All rights reserved.
//

import Foundation
import UIKit

class hexColor{
	
	func rgbColor(rgbValue: UInt) -> UIColor {
		return UIColor(
			red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
			blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
			alpha: CGFloat(1.0)
		)
	}}