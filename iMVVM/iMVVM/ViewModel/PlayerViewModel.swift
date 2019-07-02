//
//  PlayerViewModel.swift
//  iMVVM
//
//  Created by Zaid Pathan on 20/06/18.
//  Copyright © 2018 Zaid Pathan. All rights reserved.
//

import Foundation
import Player

protocol PlayerViewModelDelegate {
    func pvModelDidChange(currentTimeString: String, progress: Float)
    func pvModelDidChange(maxTimeString: String)
    func pvModelDidChange(areControlsHidden: Bool)
    func pvModelDidChange(playerButtonImage: UIImage)
}

class PlayerViewModel: NSObject {
    var delegate: PlayerViewModelDelegate?
    var player:Player? {
        didSet {
            player?.playerDelegate = self
            player?.playbackDelegate = self

            player?.url = videoURL
        }
    }

    private var videoURL: URL?
    private var timer: Timer?

    private var playerState: PlaybackState = .stopped {
        didSet {
            switch playerState {
            case .stopped:
                playerStopped()
            case .playing:
                playerPlaying()
            case .paused:
                playerPaused()
            case .failed:
                playerFailed()
            }
        }
    }
    
    private var currentTimeString: String = String() {
        didSet {
            let progress = (Float(currentTimeString) ?? 00) / (Float(maxTimeString) ?? 0)
            delegate?.pvModelDidChange(currentTimeString: currentTimeString, progress: progress)
        }
    }
    
    private var maxTimeString: String = String() {
        didSet {
            delegate?.pvModelDidChange(maxTimeString: maxTimeString)
        }
    }
    
    private var areControlsHidden: Bool = false {
        didSet {
            delegate?.pvModelDidChange(areControlsHidden: areControlsHidden)
        }
    }
    
    private var playerButtonImage: UIImage =  #imageLiteral(resourceName: "pause") {
        didSet {
            delegate?.pvModelDidChange(playerButtonImage: playerButtonImage)
        }
    }
    
    init(videoURL: URL) {
        self.videoURL = videoURL
        super.init()
    }
    
    func playerButtonClicked() {
        switch playerState {
        case .stopped:
            player?.playFromBeginning()
        case .playing:
            player?.pause()
        case .paused:
            player?.playFromCurrentTime()
        case .failed:
            player?.playFromBeginning()
        }
    }

    func playerTapped() {
        areControlsHidden = !areControlsHidden

        if !areControlsHidden {
            hideControlsAfter3Seconds(shouldHide: true)
        }
    }

    private func playerStopped() {
        playerButtonImage =  #imageLiteral(resourceName: "play")
        hideControlsAfter3Seconds(shouldHide: false)
    }
    
    private func hideControlsAfter3Seconds(shouldHide: Bool) {
        timer = nil
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
            if timer == self.timer {
                if self.playerState != .paused {
                    self.areControlsHidden = shouldHide
                }
            }
        }
    }
    
    private func playerPlaying() {
        playerButtonImage =  #imageLiteral(resourceName: "pause")
        hideControlsAfter3Seconds(shouldHide: true)
    }
    
    private func playerPaused() {
        playerButtonImage =  #imageLiteral(resourceName: "play")
        hideControlsAfter3Seconds(shouldHide: false)
    }
    
    private func playerFailed() {
        playerButtonImage =  #imageLiteral(resourceName: "play")
        hideControlsAfter3Seconds(shouldHide: false)
    }
}

extension PlayerViewModel: PlayerDelegate {
    func playerReady(_ player: Player) {

    }

    func playerPlaybackStateDidChange(_ player: Player) {
        playerState = player.playbackState
    }

    func playerBufferingStateDidChange(_ player: Player) {

    }

    func playerBufferTimeDidChange(_ bufferTime: Double) {

    }
}



extension PlayerViewModel: PlayerPlaybackDelegate {
    func playerCurrentTimeDidChange(_ player: Player) {
        maxTimeString = String(format: "%.2f", player.maximumDuration)
        currentTimeString = String(format: "%.2f", player.currentTime)
    }

    func playerPlaybackWillStartFromBeginning(_ player: Player) {

    }

    func playerPlaybackDidEnd(_ player: Player) {

    }

    func playerPlaybackWillLoop(_ player: Player) {

    }
}
