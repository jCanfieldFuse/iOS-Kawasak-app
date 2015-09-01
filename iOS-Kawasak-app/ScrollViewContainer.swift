//
//  ScrollViewContainer.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 8/31/15.
//  Copyright (c) 2015 jon.canfield. All rights reserved.
//

import UIKit

class ScrollViewContainer: UIView {
	@IBOutlet var scrollView: UIScrollView!
 
	override func hitTest(point: CGPoint, withEvent event: UIEvent!) -> UIView? {
		let view = super.hitTest(point, withEvent: event)
		if let theView = view {
			if theView == self {
				return scrollView
			}
		}
		
		return view
	}
}