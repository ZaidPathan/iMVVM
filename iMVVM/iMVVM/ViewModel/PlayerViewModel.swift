//
//  PlayerViewModel.swift
//  iMVVM
//
//  Created by Zaid Pathan on 20/06/18.
//  Copyright © 2018 Zaid Pathan. All rights reserved.
//

import Foundation
import UIKit

protocol PlayerViewModelDelegate {
    func pvModelDidChangeCurrentTime(currentTimeString: String)
    func pvModelDidChangeMaxTime(maxTimeString: String)
    func pvModelDidChangeControlState(areControlsHidden: Bool)
    func pvModelDidChangePlayerButtonImage(playerButtonImage: UIImage)
}

class PlayerViewModel {
    var videoURL: URL?
    var delegate: PlayerViewModelDelegate?
    
    var currentTimeString: String = String() {
        didSet {
            delegate?.pvModelDidChangeCurrentTime(currentTimeString: currentTimeString)
        }
    }
    
    var maxTimeString: String = String() {
        didSet {
            delegate?.pvModelDidChangeMaxTime(maxTimeString: maxTimeString)
        }
    }
    
    var areControlsHidden: Bool = false {
        didSet {
            delegate?.pvModelDidChangeControlState(areControlsHidden: areControlsHidden)
        }
    }
    
    var playerButtonImage: UIImage = #imageLiteral(resourceName: "pause") {
        didSet {
            delegate?.pvModelDidChangePlayerButtonImage(playerButtonImage: playerButtonImage)
        }
    }
    
    init(videoURL: URL) {
        self.videoURL = videoURL
    }
}
