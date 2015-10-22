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
	var color:hexColor = hexColor()
	var loginSlider = UIView()
	var topRightContainer = UIView()
	var header = UIView()

	var footer = UIView()
	var leftBottomTopButton = UIButton()
	var leftBottomRightButton = UIButton()
	var leftBottomBottumButton = UIButton()
	
	var buttonTop = UIButton()
	var buttonMiddle = UIButton()
	var buttonBottom = UIButton()
	
	var textTop = UILabel()
	var textMiddle = UILabel()
	var textBottom = UILabel()
	
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
		textTop.alpha = 0
		textMiddle.alpha = 0
		textBottom.alpha = 0
		
		self.navigationController?.navigationBarHidden = true
		self.view.layer.addSublayer(self.playerLayer)
		playerLayer.frame = self.view.frame
		NSNotificationCenter.defaultCenter().addObserver(self, selector:"playerDidReachEnd", name:AVPlayerItemDidPlayToEndTimeNotification, object:nil)
		
		topRightContainer = UIView(frame: CGRectMake(screen.width, 0, screen.width * 0.5, screen.height * 0.5))

		header.frame = CGRectMake(0, 0, screen.width, 50)
		header.backgroundColor = UIColor.blackColor()
	
		footer.frame = CGRectMake(0, screen.height, screen.width, -50)
		footer.backgroundColor = UIColor.blackColor()
		
		self.view.addSubview(header)
		self.view.addSubview(footer)
		self.view.addSubview(topRightContainer)
		
		let headerLabel = UILabel()
		headerLabel.frame =  CGRectMake(10, 0, screen.width, 50)
		headerLabel.text = "KAWASAKI APP HEADER"
		headerLabel.textColor = color.rgbColor(0x02c102)
		headerLabel.textAlignment = NSTextAlignment.Center
		header.addSubview(headerLabel)
		
		let footerLabel = UILabel()
		footerLabel.frame =  CGRectMake(10, 0, screen.width, 50)
		footerLabel.text = "KAWASAKI FOOTER"
		footerLabel.textColor = color.rgbColor(0x02c102)
		footerLabel.textAlignment = NSTextAlignment.Center
		footer.addSubview(footerLabel)
		
		// these are the button on the bottom left
		leftBottomTopButton.frame = CGRectMake(50, screen.height - 200, 75, 75)
		leftBottomTopButton.setImage(UIImage(named: "hexagon"), forState: .Normal)
		leftBottomTopButton.setTitle("Button", forState: UIControlState.Normal)
		leftBottomTopButton.addTarget(self, action: "buttonsTop:", forControlEvents: UIControlEvents.TouchUpInside)
		leftBottomTopButton.alpha = 1
		self.view.addSubview(leftBottomTopButton)
		
		leftBottomRightButton.frame = CGRectMake(leftBottomTopButton.frame.origin.x + (leftBottomTopButton.frame.height * 0.5) + 20, leftBottomTopButton.frame.origin.y + (leftBottomTopButton.frame.height * 0.5) - 5, 75, 75)
		leftBottomRightButton.setImage(UIImage(named: "hexagon"), forState: .Normal)
		leftBottomRightButton.setTitle("Button", forState: UIControlState.Normal)
		leftBottomRightButton.addTarget(self, action: "buttonsTopLeft:", forControlEvents: UIControlEvents.TouchUpInside)
		leftBottomRightButton.alpha = 1
		self.view.addSubview(leftBottomRightButton)
		
		leftBottomBottumButton  = UIButton()
		leftBottomBottumButton.frame = CGRectMake(leftBottomTopButton.frame.origin.x , leftBottomTopButton.frame.origin.y + (leftBottomTopButton.frame.height) - 9 , 75, 75)
		leftBottomBottumButton.setImage(UIImage(named: "hexagon"), forState: .Normal)
		leftBottomBottumButton.setTitle("Button", forState: UIControlState.Normal)
		leftBottomBottumButton.addTarget(self, action: "showLoginScreen:", forControlEvents: UIControlEvents.TouchUpInside)
		leftBottomBottumButton.alpha = 1
		self.view.addSubview(leftBottomBottumButton)
		
		
		//these are the buttons on the top right
		buttonTop.frame = CGRectMake(topRightContainer.frame.width - 75, 100, 50, 50)
		buttonTop.setImage(UIImage(named: "hexagon"), forState: .Normal)
		buttonTop.setTitle("Button", forState: UIControlState.Normal)
		buttonTop.addTarget(self, action: "topButton:", forControlEvents: UIControlEvents.TouchUpInside)
		buttonTop.alpha = 1
		topRightContainer.addSubview(buttonTop)
		
		textTop.frame =  CGRectMake((buttonTop.frame.origin.x - buttonTop.frame.width) - 20, 100, 50, 50)
		textTop.text = "testy"
		textTop.textColor = color.rgbColor(0x02c102)
		textTop.textAlignment = NSTextAlignment.Right
		topRightContainer.addSubview(textTop)
		
		buttonMiddle.frame = CGRectMake(buttonTop.frame.origin.x - (buttonTop.frame.width * 0.5), 155, 50, 50)
		buttonMiddle.setImage(UIImage(named: "hexagon"), forState: .Normal)
		buttonMiddle.setTitle("Button", forState: UIControlState.Normal)
		buttonMiddle.addTarget(self, action: "middleButton:", forControlEvents: UIControlEvents.TouchUpInside)
		topRightContainer.addSubview(buttonMiddle)
		
		textMiddle.frame =  CGRectMake((buttonMiddle.frame.origin.x - buttonMiddle.frame.width) - 20, 155, 50, 50)
		textMiddle.text = "testy2"
		textMiddle.textColor = color.rgbColor(0x02c102)
		textMiddle.textAlignment = NSTextAlignment.Right
		topRightContainer.addSubview(textMiddle)
		
	
		buttonBottom.frame = CGRectMake(buttonMiddle.frame.origin.x + (buttonMiddle.frame.width * 0.5), 210, 50, 50)
		buttonBottom.setImage(UIImage(named: "hexagon"), forState: .Normal)
		buttonBottom.setTitle("Button", forState: UIControlState.Normal)
		buttonBottom.addTarget(self, action: "bottomButton:", forControlEvents: UIControlEvents.TouchUpInside)
		topRightContainer.addSubview(buttonBottom)
		
	
		textBottom.frame =  CGRectMake((buttonTop.frame.origin.x - buttonTop.frame.width) - 20, 210, 50, 50)
		textBottom.text = "testy3"
		textBottom.textColor = color.rgbColor(0x02c102)
		textBottom.textAlignment = NSTextAlignment.Right
		topRightContainer.addSubview(textBottom)

		
		//this is the left hand slider.
		loginSlider = UIView(frame: CGRectMake(-400, 0, screen.width * 0.8, screen.height))
		loginSlider.backgroundColor = color.rgbColor(0x686767)
		self.view.addSubview(loginSlider)
		
		let closeButton   = UIButton()
		closeButton.frame = CGRectMake(20, 30, 20, 20)
		closeButton.setImage(UIImage(named: "close"), forState: .Normal)
		closeButton.setTitle("Button", forState: UIControlState.Normal)
		closeButton.addTarget(self, action: "closeleftSide:", forControlEvents: UIControlEvents.TouchUpInside)
		loginSlider.addSubview(closeButton)
		
		var slidertopText = UILabel()
		slidertopText.frame = 	CGRectMake(0, loginSlider.frame.origin.y + 50, loginSlider.frame.width, 20)
		slidertopText.text = "some text some text some text some text some text some text "
		slidertopText.numberOfLines = 1
		slidertopText.textColor = UIColor.whiteColor()
		slidertopText.textAlignment = NSTextAlignment.Center
		loginSlider.addSubview(slidertopText)
		
		let centerItem = (loginSlider.frame.width * 0.5)  -  ((loginSlider.frame.width * 0.5) * 0.5)
		
		var username = UITextField()
		username.frame = CGRectMake(centerItem, slidertopText.frame.origin.y + 80, loginSlider.frame.width * 0.5, 20)
		username.borderStyle = UITextBorderStyle.RoundedRect
		username.placeholder = "username"
		username.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
		loginSlider.addSubview(username)
		
		var password = UITextField()
		password.frame = CGRectMake(centerItem, username.frame.origin.y + 30, loginSlider.frame.width * 0.5, 20)
		password.borderStyle = UITextBorderStyle.RoundedRect
		password.placeholder = "password"
		password.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
		loginSlider.addSubview(password)
		
		var loginSubmit = UIButton()
		loginSubmit.frame = CGRectMake(centerItem, password.frame.origin.y + 40, loginSlider.frame.width * 0.5, 40)
		loginSubmit.backgroundColor = color.rgbColor(0x02c102)
		loginSubmit.setTitle("Submit", forState: .Normal)
		loginSubmit.addTarget(self, action: "topButton:", forControlEvents: UIControlEvents.TouchUpInside)
		loginSlider.addSubview(loginSubmit)
		self.textTop.alpha = 0
		self.textMiddle.alpha = 0
		self.textBottom.alpha = 0
0
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
	
	
	
	func buttonsTop(sender: UIButton!) {
		
		if !self.isButtonOneVisible && !self.isButtonTwoVisible{
			self.isButtonOneVisible = true
			self.isButtonTwoVisible = false
			showRightSide()
			
		}
		if !self.isButtonOneVisible && self.isButtonTwoVisible{
			self.isButtonOneVisible = true
			self.isButtonTwoVisible = false
  		removeThenShow()
		}
	}
	
	@IBAction func buttonsTopLeft(sender: UIButton!) {
		if !self.isButtonTwoVisible && !self.isButtonOneVisible {
			showRightSide()
			self.isButtonTwoVisible = true
			self.isButtonOneVisible = false
			showRightSide()
		}
		if !self.isButtonTwoVisible && self.isButtonOneVisible{
			self.isButtonTwoVisible = true
			self.isButtonOneVisible = false
			removeThenShow()
		}
	}

	
	//sugue somewhere
	func topButton(sender: UIButton!){
		 let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PagedScrollViewController") as! UIViewController
		 self.presentViewController(viewController, animated: true, completion: nil)
	}
	func middleButton(sender: UIButton!){
		let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PagedScrollViewController") as! UIViewController
		self.presentViewController(viewController, animated: true, completion: nil)
	}
	func bottomButton(sender: UIButton!){
		let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PagedScrollViewController") as! UIViewController
		self.presentViewController(viewController, animated: true, completion: nil)
	}

	

	
	//animations
	func removeThenShow(){
		UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
			self.topRightContainer.frame.origin.x = self.screen.width
			}, completion: { finished in
				self.buttonSection()
				self.textTop.alpha = 0
				self.textMiddle.alpha = 0
				self.textBottom.alpha = 0
				UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
					self.topRightContainer.frame.origin.x = self.screen.width - self.topRightContainer.frame.width
					}, completion: { finished in
						UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseOut, animations: {
							self.textTop.alpha = 1
							self.textMiddle.alpha = 1
							self.textBottom.alpha = 1
							}, completion: { finished in
								print("done")
						})
				})
		})
	}


	
	func	showRightSide(){
		buttonSection()
		UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
			self.topRightContainer.frame.origin.x = self.screen.width - self.topRightContainer.frame.width
			print(self.topRightContainer.frame)
			}, completion: { finished in
				UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
					self.topRightContainer.frame.origin.x = self.screen.width - self.topRightContainer.frame.width
					print(self.topRightContainer.frame)
					}, completion: { finished in
						UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
							self.textTop.alpha = 1
							self.textMiddle.alpha = 1
							self.textBottom.alpha = 1
							print(self.topRightContainer.frame)
							}, completion: { finished in
								print("done")
						})
				})
		})
	}
 func showLoginScreen(sender: UIButton!) {
		UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
			self.loginSlider.frame = CGRectMake(0, 0, self.screen.width * 0.8, self.screen.height)
			}, completion: { finished in
    print("Done")
  })
		
	}
	
	func closeleftSide(sender: UIButton!){
		UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
			self.loginSlider.frame = CGRectMake(-400, 0, self.screen.width * 0.8, self.screen.height)
			}, completion: { finished in
    print("DONE")
  })
		
	}
	func buttonSection(){
		if self.isButtonTwoVisible{
			buttonTop.setImage(UIImage(named: "hexagon"), forState: .Normal)
			buttonMiddle.setImage(UIImage(named: "hexagon"), forState: .Normal)
			buttonBottom.setImage(UIImage(named: "hexagon"), forState: .Normal)
			self.textTop.text = "green"
			self.textTop.textColor = color.rgbColor(0x02c102)
			self.textMiddle.text = "green"
			self.textMiddle.textColor = color.rgbColor(0x02c102)
			self.textBottom.text = "green"
			self.textBottom.textColor = color.rgbColor(0x02c102)

		}else{
			buttonTop.setImage(UIImage(named: "hexagonB"), forState: .Normal)
			buttonMiddle.setImage(UIImage(named: "hexagonB"), forState: .Normal)
			buttonBottom.setImage(UIImage(named: "hexagonB"), forState: .Normal)
			self.textTop.text = "purple"
			self.textTop.textColor = UIColor.purpleColor()
			self.textMiddle.text = "purple"
			self.textMiddle.textColor = UIColor.purpleColor()
			self.textBottom.text = "purple"
			self.textBottom.textColor = UIColor.purpleColor()
		
		}
	}
	
	
}