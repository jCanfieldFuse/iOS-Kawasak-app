//
//  VideobgTest.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 9/23/15.
//  Copyright © 2015 jon.canfield. All rights reserved.
//

import UIKit
import AVFoundation

class VideobgTest: UIViewController  {
	@IBOutlet weak var loginSlider: UIView!
	
	@IBOutlet weak var topRightContainer: UIView!
	var isButtonOneVisible = false
	var isButtonTwoVisible = false
	var screen = UIScreen.mainScreen().bounds
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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		loginSlider.frame = CGRectMake(-400, 0, screen.width * 0.8, screen.height)
		topRightContainer.frame = CGRectMake(screen.width, 0, screen.width * 0.5, screen.height * 0.5)
		
		//	loginSlider.frame.origin.x = CGFloat(0.0)
		self.view.layer.addSublayer(self.playerLayer)
		playerLayer.frame = self.view.frame
		
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector:"playerDidReachEnd", name:AVPlayerItemDidPlayToEndTimeNotification, object:nil)
		
		let buttonTop  = UIButton()
		buttonTop.frame = CGRectMake(topRightContainer.frame.width - 75, 100, 50, 50)
		buttonTop.setImage(UIImage(named: "hexagon"), forState: .Normal)
		buttonTop.setTitle("Button", forState: UIControlState.Normal)
		buttonTop.addTarget(self, action: "topButton:", forControlEvents: UIControlEvents.TouchUpInside)
		buttonTop.alpha = 1
		topRightContainer.addSubview(buttonTop)
		
		let buttonMiddle   = UIButton()
		buttonMiddle.frame = CGRectMake(buttonTop.frame.origin.x - (buttonTop.frame.width * 0.5), 155, 50, 50)
		buttonMiddle.setImage(UIImage(named: "hexagon"), forState: .Normal)
		buttonMiddle.setTitle("Button", forState: UIControlState.Normal)
		
		buttonMiddle.addTarget(self, action: "middleButton:", forControlEvents: UIControlEvents.TouchUpInside)
		topRightContainer.addSubview(buttonMiddle)
		
		let buttonBottom   = UIButton()
		buttonBottom.frame = CGRectMake(buttonMiddle.frame.origin.x + (buttonMiddle.frame.width * 0.5), 210, 50, 50)
		buttonBottom.setImage(UIImage(named: "hexagon"), forState: .Normal)
		buttonBottom.setTitle("Button", forState: UIControlState.Normal)
		buttonBottom.addTarget(self, action: "bottomButton:", forControlEvents: UIControlEvents.TouchUpInside)
		topRightContainer.addSubview(buttonBottom)
		
		
		let closeButton   = UIButton()
		closeButton.frame = CGRectMake(20, 80, 20, 20)
		closeButton.setImage(UIImage(named: "close"), forState: .Normal)
		closeButton.setTitle("Button", forState: UIControlState.Normal)
		closeButton.addTarget(self, action: "closeleftSide:", forControlEvents: UIControlEvents.TouchUpInside)
		loginSlider.addSubview(closeButton)
		
	}
	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)
		NSNotificationCenter.defaultCenter().removeObserver(self)
	}
	
	override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
		super.willAnimateRotationToInterfaceOrientation(toInterfaceOrientation, duration: duration)
		playerLayer.frame = self.view.frame
	}
	func playerDidReachEnd(){
		self.playerLayer.player!.seekToTime(kCMTimeZero)
		self.playerLayer.player!.play()
		
	}
	
	
	@IBAction func showLoginScreen(sender: AnyObject) {
		UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: {
			self.loginSlider.frame = CGRectMake(0, 0, self.screen.width * 0.8, self.screen.height)
			}, completion: { finished in
    print("Basket doors opened!")
  })
		
	}
	
	
	@IBAction func buttonsTop(sender: AnyObject) {

		if !self.isButtonOneVisible && !self.isButtonTwoVisible{
			showRightSide()
			self.isButtonOneVisible = true
			self.isButtonTwoVisible = false
			
		}
		if !self.isButtonOneVisible && self.isButtonTwoVisible{
			removeThenShow()
			self.isButtonOneVisible = true
			self.isButtonTwoVisible = false
		}
	}
	
	@IBAction func buttonsTopLeft(sender: AnyObject) {
		if !self.isButtonTwoVisible && !self.isButtonOneVisible {
			showRightSide()
			self.isButtonTwoVisible = true
			self.isButtonOneVisible = false
		}
		if !self.isButtonTwoVisible && self.isButtonOneVisible{
			removeThenShow()
			self.isButtonTwoVisible = true
			self.isButtonOneVisible = false
			
		}
		
	}
	func removeThenShow(){
		UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: {
			self.topRightContainer.frame.origin.x = self.screen.width
			}, completion: { finished in
				UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: {
					self.topRightContainer.frame.origin.x = self.screen.width - self.topRightContainer.frame.width
					}, completion: { finished in
						print("done")
				})
		})
	}
	
	func	showRightSide(){
		UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: {
			self.topRightContainer.frame.origin.x = self.screen.width - self.topRightContainer.frame.width
			}, completion: { finished in
				print("done")
		})
	}
	
	//sugue somewhere
	func topButton(sender: UIButton!){
		print("hello")
	}
	func middleButton(sender: UIButton!){
		print("hello")
	}
	func bottomButton(sender: UIButton!){
		print("hello")
	}
	
	func closeleftSide(sender: UIButton!){
		UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: {
			self.loginSlider.frame = CGRectMake(-400, 0, self.screen.width * 0.8, self.screen.height)
			}, completion: { finished in
    print("Basket doors opened!")
  })
		
		
	}
	
	
	
}