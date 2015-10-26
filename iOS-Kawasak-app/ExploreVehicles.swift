//
//  raceResults.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 9/1/15.
//  Copyright (c) 2015 jon.canfield. All rights reserved.
//

import UIKit

class ExploreVehicles: UIViewController, UIWebViewDelegate {
	
	var screen = UIScreen.mainScreen().bounds
	var racingHeader = UIView()
	var hamburger = UIButton()
	var racingWebView = UIWebView()
	var burger: BurgerMenu = BurgerMenu()
	var fadeView = UIView()
	var passedURL: String = ""
	var passIn:Int = 0

	let images = [
		UIImage(named: "2")!,
		UIImage(named: "2")!,
		UIImage(named: "3"),
		UIImage(named: "4")!,
		UIImage(named: "5")!,
		UIImage(named: "6")!]
	var index = 0
	let animationDuration: NSTimeInterval = 0.5
	let switchingInterval: NSTimeInterval = 3
	let imageTest = UIImageView()
	let imageView = UIImageView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		burger.pickView = 1
		burger.parentView = self
		self.navigationController?.navigationBarHidden = true
		racingWebView.delegate = self
		fadeView.frame = CGRectMake(0, 0, screen.width, screen.height)
		fadeView.backgroundColor = UIColor.blackColor()
		fadeView.alpha = 0.8
		
		let hamburgerV = UIView()
		hamburgerV.frame = CGRectMake(20, 15, 40,40)
		hamburgerV.backgroundColor = UIColor.blackColor()
		let topRecognizer = UITapGestureRecognizer(target: self, action:"openMenu:")
		hamburgerV.addGestureRecognizer(topRecognizer)
		hamburgerV.userInteractionEnabled = true
		racingHeader.addSubview(hamburgerV)


		let url = NSURL (string: passedURL)
		
		let requestObj = NSURLRequest(URL: url!)
		racingWebView.frame = CGRectMake(0, 0, screen.width, screen.height)
		racingWebView.loadRequest(requestObj);
		racingWebView.backgroundColor = UIColor.blackColor()
		
		self.view.addSubview(racingWebView)
		self.view.addSubview(fadeView)
		
		imageView.frame = CGRectMake(0, 0, screen.width * 0.5, screen.width * 0.5)
		imageView.center = self.view.center
		view.addSubview(imageView)
		
		imageView.image = images[index++]
		
		let background = UIButton()
		background.frame = CGRectMake(0, 0, screen.width * 0.5, screen.width * 0.3)
		background.addTarget(self, action: "close:", forControlEvents: .TouchUpInside)
		background.setBackgroundImage(UIImage(named: "CloseFindDealerOverlay_Button"), forState: .Normal)
		self.view.addSubview(background)
		
	}
	func animateImageView() {
		CATransaction.begin()
		
		CATransaction.setAnimationDuration(animationDuration)
		CATransaction.setCompletionBlock {
			let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(0))
			dispatch_after(delay, dispatch_get_main_queue()) {
				self.animateImageView()
			}
		}
		
		let transition = CATransition()
		transition.type = kCATransitionFade
		/*
		transition.type = kCATransitionPush
		transition.subtype = kCATransitionFromRight
		*/
		imageView.layer.addAnimation(transition, forKey: kCATransition)
		imageView.image = images[index]
		
		CATransaction.commit()
		
		index = index < images.count - 1 ? index + 1 : 0
	}
	
	func webViewDidStartLoad(webView: UIWebView) {
		
		animateImageView()
		
	}
	
	func close (sender: AnyObject){
		self.dismissViewControllerAnimated(true, completion: {})
	}
	
	func webViewDidFinishLoad(webView: UIWebView) {
		imageView.removeFromSuperview()
		UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
			self.fadeView.alpha = 0
			}, completion: { finished in
		})
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func openMenu(sender: UIButton!){
		burger.openMenu()
		
	}
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if (segue.identifier == "toLanding") {
			let svc = segue.destinationViewController as! LandingPageNew
			svc.dataPassed = passIn
		}
	}
	
}


