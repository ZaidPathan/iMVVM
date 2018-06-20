//
//  PlayerVC.swift
//  iMVVM
//
//  Created by Zaid Pathan on 20/06/18.
//  Copyright © 2018 Zaid Pathan. All rights reserved.
//

import UIKit
import Player

class PlayerVC: UIViewController {
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var maxTimeLabel: UILabel!
    @IBOutlet weak var playerButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    var player:Player!
    let viewModel = PlayerViewModel(videoURL: URL(string: "https://player.vimeo.com/external/207561527.hd.mp4?s=a672f4505af1cd98c666607a1e9980ee39c08a86&profile_id=119&oauth2_token_id=57447761&download=1")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayer()
    }

    func setupPlayer() {
        for childVC in childViewControllers {
            if childVC is Player {
                if let player = childVC as? Player {
                    self.player = player
                }
            }
        }
        
        player.url = viewModel.videoURL
        player.playerDelegate = self
        player.playbackDelegate = self

        player.playFromBeginning()
    }
    
    @IBAction func playerButtonClicked(_ sender: Any) {
        
    }
}

extension PlayerVC: PlayerViewModelDelegate {
    func pvModelDidChangeMaxTime(maxTimeString: String) {
        maxTimeLabel.text = maxTimeString
    }
    
    func pvModelDidChangeCurrentTime(currentTimeString: String) {
        currentTimeLabel.text = currentTimeString
    }
    
    func pvModelDidChangeControlState(areControlsHidden: Bool) {
        playerButton.isHidden = areControlsHidden
        progressView.isHidden = areControlsHidden
        maxTimeLabel.isHidden = areControlsHidden
        currentTimeLabel.isHidden = areControlsHidden
    }
    
    func pvModelDidChangePlayerButtonImage(playerButtonImage: UIImage) {
        playerButton.setImage(playerButtonImage, for: .normal)
    }
}

extension PlayerVC: PlayerPlaybackDelegate {
    func playerCurrentTimeDidChange(_ player: Player) {
        
    }
    
    func playerPlaybackWillStartFromBeginning(_ player: Player) {
        
    }
    
    func playerPlaybackDidEnd(_ player: Player) {
        
    }
    
    func playerPlaybackWillLoop(_ player: Player) {
        
    }
}

extension PlayerVC: PlayerDelegate {
    func playerReady(_ player: Player) {
        
    }
    
    func playerPlaybackStateDidChange(_ player: Player) {
        
    }
    
    func playerBufferingStateDidChange(_ player: Player) {
        
    }
    
    func playerBufferTimeDidChange(_ bufferTime: Double) {
        
    }
}
