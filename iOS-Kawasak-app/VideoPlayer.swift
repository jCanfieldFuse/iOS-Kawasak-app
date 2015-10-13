//
//  VideoPlayer.swift
//  iOS-Kawasak-app
//
//  Created by jon.canfield on 9/28/15.
//  Copyright © 2015 jon.canfield. All rights reserved.
//

import AVFoundation
import UIKit

class VideoPlayer: UIView {
	/*
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
	
	
	
	override func willMoveToSuperview(newSuperview: UIView?) {
		print("playing")
		playerLayer.frame = self.frame
  	NSNotificationCenter.defaultCenter().addObserver(self, selector:"playerDidReachEnd", name:AVPlayerItemDidPlayToEndTimeNotification, object:nil)
	}
	
	func playerDidReachEnd(){
		print("reached the end")
		self.playerLayer.player!.seekToTime(kCMTimeZero)
		self.playerLayer.player!.play()
		
	}*/

	
}
