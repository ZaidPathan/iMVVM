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
    private let viewModel = PlayerViewModel(videoURL: URL(string: "https://player.vimeo.com/external/207561527.hd.mp4?s=a672f4505af1cd98c666607a1e9980ee39c08a86&profile_id=119&oauth2_token_id=57447761&download=1")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayer()
        setupViewModel()
    }

    private func setupPlayer() {
        for childVC in childViewControllers {
            if childVC is Player {
                if let player = childVC as? Player {
                    viewModel.player = player
                }
            }
        }
    }

    private func setupViewModel() {
        viewModel.delegate = self
        viewModel.playerButtonClicked()
    }
    
    @IBAction func playerButtonClicked(_ sender: Any) {
        viewModel.playerButtonClicked()
    }
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        viewModel.playerTapped()
    }
}

extension PlayerVC: PlayerViewModelDelegate {
    func pvModelDidChange(maxTimeString: String) {
        maxTimeLabel.text = maxTimeString
    }
    
    func pvModelDidChange(currentTimeString: String, progress: Float) {
        currentTimeLabel.text = currentTimeString
        progressView.progress = progress
    }
    
    func pvModelDidChange(areControlsHidden: Bool) {
        playerButton.isHidden = areControlsHidden
        progressView.isHidden = areControlsHidden
        maxTimeLabel.isHidden = areControlsHidden
        currentTimeLabel.isHidden = areControlsHidden
    }
    
    func pvModelDidChange(playerButtonImage: UIImage) {
        playerButton.setImage(playerButtonImage, for: .normal)
    }
}
