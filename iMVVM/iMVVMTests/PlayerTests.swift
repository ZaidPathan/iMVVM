//
//  PlayerTests.swift
//  iMVVMTests
//
//  Created by Zaid Pathan on 26/06/18.
//  Copyright © 2018 Zaid Pathan. All rights reserved.
//

import XCTest
import Player

class PlayerTests: XCTestCase {
    let url = URL(string: "https://player.vimeo.com/external/207561527.hd.mp4?s=a672f4505af1cd98c666607a1e9980ee39c08a86&profile_id=119&oauth2_token_id=57447761&download=1")!
    var viewModel: PlayerViewModel!
    
    override func setUp() {
        super.setUp()

        //
        viewModel = PlayerViewModel(videoURL: url)
        viewModel.player = Player()

    }
    // Test driven 🧪🚗👨‍💻 development
    //

    //
    

    func testInitialState() {
        XCTAssertTrue(viewModel.playerState == .stopped)
        viewModel.playerButtonClicked()

        let playingExpactation = XCTestExpectation(description: "Playing...")

        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
            if self.viewModel.playerState == .playing {
                playingExpactation.fulfill()
            }
        }

        wait(for: [playingExpactation], timeout: 4)

        viewModel.playerButtonClicked()

        XCTAssertTrue(viewModel.playerState == .paused)

        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
            XCTAssertTrue(self.viewModel.areControlsHidden == false)
        }
    }


    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
