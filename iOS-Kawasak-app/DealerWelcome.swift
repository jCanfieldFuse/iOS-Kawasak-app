//
//  DealerWelcome.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 9/30/15.
//  Copyright © 2015 jon.canfield. All rights reserved.
//

import UIKit
import AVFoundation


class DealerWelcome: UIViewController  {
	var screen = UIScreen.mainScreen().bounds
	var locDealer:LocateDealerHeader = LocateDealerHeader()
	var welcomeLabel = UILabel()
	var centerView = UIView()
	var dealerName = UILabel()
	var kawasakiButton = UIButton()
	let buttonSize:CGFloat = 100
	let threeButtonXpos:CGFloat =  20
	var textWidth:CGFloat = 100
	var textHeight:CGFloat = 50
	var footer:Footer = Footer()
	
	var playerLayer:AVPlayerLayer = {
		
		let path = NSBundle.mainBundle().pathForResource("video", ofType: "mp4")
		let tmpPath = NSURL(fileURLWithPath: path!)
		let player = AVPlayer(URL:  tmpPath)
		
		player.muted = true
		player.allowsExternalPlayback = false
		player.appliesMediaSelectionCriteriaAutomatically = false
		var error:NSError?
		
		// This is needed so it would not cut off users audio (if listening to music etc.
		do {
			try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
		} catch var error1 as NSError {
			error = error1
		} catch {
			fatalError()
		}
		if error != nil {
			print(error)
		}
		
		var playerLayer = AVPlayerLayer(player: player)
		
		playerLayer.videoGravity = "AVLayerVideoGravityResizeAspectFill"
		playerLayer.backgroundColor = UIColor.blackColor().CGColor
		player.play()
		
		return playerLayer
		}()
	
	override func prefersStatusBarHidden() -> Bool {
		return true;
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.navigationBarHidden = true
		playerLayer.frame = self.view.frame
		NSNotificationCenter.defaultCenter().addObserver(self, selector:"playerDidReachEnd", name:AVPlayerItemDidPlayToEndTimeNotification, object:nil)
		print("dasdas")
		locDealer.parentView = self
		self.view.layer.addSublayer(self.playerLayer)
		
		centerView.frame = CGRectMake(0, screen.height * 0.5 - (screen.width * 0.3) , screen.width, screen.width * 0.4)
		self.view.addSubview(centerView)
		var topRightContainer = UIView()
		topRightContainer = UIView(frame: CGRectMake(screen.width * 0.4, (screen.height * 0.6) , screen.width, (screen.height * 0.3)))

		//self.view.addSubview(topRightContainer)

		welcomeLabel.frame = CGRectMake(20, 10, 80, 30)
		welcomeLabel.text = "Welcome!"
		welcomeLabel.textColor = UIColor.whiteColor()
		welcomeLabel.textAlignment = NSTextAlignment.Left
  	self.centerView.addSubview(welcomeLabel)
		
		dealerName.frame = CGRectMake(20, 30, 80, 80)
		dealerName.text = "Mission Hills Kawasaki"
		dealerName.numberOfLines = 0
		dealerName.textColor = UIColor.whiteColor()
		dealerName.textAlignment = NSTextAlignment.Left
		self.centerView.addSubview(dealerName)

		kawasakiButton.frame = CGRectMake((screen.width  - (buttonSize + 25) ), 5, buttonSize + 15 , buttonSize + 15)
		kawasakiButton.setBackgroundImage(UIImage(named: "hexagon"), forState: .Normal)
		kawasakiButton.setTitle("Explore Vehicles", forState: UIControlState.Normal)
		kawasakiButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		kawasakiButton.titleEdgeInsets =  UIEdgeInsets(top:0 , left: 0, bottom: 0, right: 0)
		kawasakiButton.contentHorizontalAlignment = .Center
		kawasakiButton.titleLabel!.numberOfLines = 0
//		kawasakiButton.titleLabel?.font = UIFont(name: (kawasakiButton.titleLabel?.font.fontName)!, size: fontSize)
		//kawasakiButton.addTarget(self, action: "buttonsTop:", forControlEvents: UIControlEvents.TouchUpInside)
		self.centerView.addSubview(kawasakiButton)

		var buttonTop = UIButton()
		buttonTop.frame = CGRectMake(0, threeButtonXpos, 50, 50)
		buttonTop.setImage(UIImage(named: "hexagon"), forState: .Normal)
		buttonTop.setTitle("Button", forState: UIControlState.Normal)
		buttonTop.addTarget(self, action: "getSavings:", forControlEvents: UIControlEvents.TouchUpInside)
		buttonTop.alpha = 1
		topRightContainer.addSubview(buttonTop)

		var textTop = UILabel()
		textTop.frame =  CGRectMake(buttonTop.frame.width + 25, threeButtonXpos, textWidth, textHeight)
		textTop.text = "Get Savings"
		let recognizer = UITapGestureRecognizer(target: self, action:"test:")
		textTop.addGestureRecognizer(recognizer)
		textTop.userInteractionEnabled = true
		textTop.textColor = UIColor.whiteColor()
		textTop.textAlignment = NSTextAlignment.Right
		topRightContainer.addSubview(textTop)
		
		var lineTop = UIView()
		lineTop.frame = CGRectMake(0, textTop.frame.height - 10, textTop.frame.width, 1)
		lineTop.backgroundColor = UIColor.grayColor()
		textTop.addSubview(lineTop)
		
		
		var buttonMiddle = UIButton()
		buttonMiddle.frame = CGRectMake(buttonTop.frame.origin.x + (buttonTop.frame.width * 0.5) - 3, threeButtonXpos + 39, 50, 50)
		buttonMiddle.setImage(UIImage(named: "hexagon"), forState: .Normal)
		buttonMiddle.setTitle("Button", forState: UIControlState.Normal)
		buttonMiddle.addTarget(self, action: "Racing:", forControlEvents: UIControlEvents.TouchUpInside)
		topRightContainer.addSubview(buttonMiddle)
		
		var textMiddle = UILabel()
		textMiddle.frame =  CGRectMake(textTop.frame.origin.x, threeButtonXpos + 39, textWidth, 50)
		textMiddle.text = "Racing"
		textMiddle.textColor = UIColor.whiteColor()
		textMiddle.textAlignment = NSTextAlignment.Right
		topRightContainer.addSubview(textMiddle)
		
		var lineMiddle = UIView()
		lineMiddle.frame = CGRectMake(0, textMiddle.frame.height - 10, textMiddle.frame.width, 1)
		lineMiddle.backgroundColor = UIColor.grayColor()
		textMiddle.addSubview(lineMiddle)
		
		var buttonBottom = UIButton()
		buttonBottom.frame = CGRectMake(buttonTop.frame.origin.x, buttonMiddle.frame.origin.y + 39, 50, textHeight)
		buttonBottom.setImage(UIImage(named: "hexagon"), forState: .Normal)
		buttonBottom.setTitle("Button", forState: UIControlState.Normal)
		buttonBottom.addTarget(self, action: "myKawasaki:", forControlEvents: UIControlEvents.TouchUpInside)
		topRightContainer.addSubview(buttonBottom)
		
		var textBottom = UILabel()
		textBottom.frame =  CGRectMake(textTop.frame.origin.x, buttonMiddle.frame.origin.y + 39, textWidth, textHeight)
		textBottom.text = "My Kawasaki"
		textBottom.textColor = UIColor.whiteColor()
		textBottom.textAlignment = NSTextAlignment.Right
		topRightContainer.addSubview(textBottom)
		
		var lineBottom = UIView()
		lineBottom.frame = CGRectMake(0, textBottom.frame.height - 10, textMiddle.frame.width, 1)
		lineBottom.backgroundColor = UIColor.grayColor()
		textBottom.addSubview(lineBottom)


		self.view.addSubview(footer)
self.view.addSubview(topRightContainer)
		
	}
	
	
	override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
		super.willAnimateRotationToInterfaceOrientation(toInterfaceOrientation, duration: duration)
		playerLayer.frame = self.view.frame
	}
	func playerDidReachEnd(){
		self.playerLayer.player!.seekToTime(kCMTimeZero)
		self.playerLayer.player!.play()
		
	}
	
	func getSavings(sender: UIButton!){
		let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("RaceResults") as! UIViewController
		self.presentViewController(viewController, animated: true, completion: nil)
	}
	
	func racing(sender: UIButton!){
		let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("RaceResults") as! UIViewController
		self.presentViewController(viewController, animated: true, completion: nil)
	}
	
	func myKawasaki(sender: UIButton!){
		let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("RaceResults") as! UIViewController
		self.presentViewController(viewController, animated: true, completion: nil)
	}
	
}