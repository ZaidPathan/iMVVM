//
//  PlayerViewModel.swift
//  iMVVM
//
//  Created by Zaid Pathan on 20/06/18.
//  Copyright © 2018 Zaid Pathan. All rights reserved.
//

import Foundation
import UIKit
import Player

protocol PlayerViewModelDelegate {
    func pvModelDidChange(currentTimeString: String)
    func pvModelDidChange(maxTimeString: String)
    func pvModelDidChange(areControlsHidden: Bool)
    func pvModelDidChange(playerButtonImage: UIImage)
    func playFromBeginning()
    func playFromCurrentTime()
    func pause()
}

class PlayerViewModel {
    var videoURL: URL?
    var delegate: PlayerViewModelDelegate?
    
    var playerState: PlaybackState = .stopped {
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
    
    var currentTimeString: String = String() {
        didSet {
            delegate?.pvModelDidChange(currentTimeString: currentTimeString)
        }
    }
    
    var maxTimeString: String = String() {
        didSet {
            delegate?.pvModelDidChange(maxTimeString: maxTimeString)
        }
    }
    
    var areControlsHidden: Bool = false {
        didSet {
            delegate?.pvModelDidChange(areControlsHidden: areControlsHidden)
        }
    }
    
    var playerButtonImage: UIImage = #imageLiteral(resourceName: "pause") {
        didSet {
            delegate?.pvModelDidChange(playerButtonImage: playerButtonImage)
        }
    }
    
    init(videoURL: URL) {
        self.videoURL = videoURL
    }
    
    func playerButtonClicked() {
        switch playerState {
        case .stopped:
            delegate?.playFromBeginning()
        case .playing:
            delegate?.pause()
        case .paused:
            delegate?.playFromCurrentTime()
        case .failed:
            delegate?.playFromBeginning()
        }
    }
    
    func playerStopped() {
        playerButtonImage = #imageLiteral(resourceName: "play")
        hideControlsAfter3Seconds(shouldHide: false)
    }
    
    func hideControlsAfter3Seconds(shouldHide: Bool) {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
            self.areControlsHidden = shouldHide
        }
    }
    
    func playerPlaying() {
        playerButtonImage = #imageLiteral(resourceName: "pause")
        hideControlsAfter3Seconds(shouldHide: true)
    }
    
    func playerPaused() {
        playerButtonImage = #imageLiteral(resourceName: "play")
        hideControlsAfter3Seconds(shouldHide: false)
    }
    
    func playerFailed() {
        playerButtonImage = #imageLiteral(resourceName: "play")
        hideControlsAfter3Seconds(shouldHide: false)
    }
    
    func playerTapped() {
        areControlsHidden = !areControlsHidden
        
        if !areControlsHidden {
            hideControlsAfter3Seconds(shouldHide: true)
        }
    }
}
