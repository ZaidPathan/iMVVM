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
        viewModel = PlayerViewModel(videoURL: url)
        viewModel.player = Player()
    }
    
    func testSetup() {
        XCTAssertEqual(viewModel.areControlsHidden, false)
        XCTAssertEqual(viewModel.currentTimeString, String())
    }
    
    func testVideoWillBegin() {

        XCTAssertEqual(viewModel.playerState, .stopped)
        viewModel.playerButtonClicked()

        let playingExpectation = XCTestExpectation(description: "Playing Now")

        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
            if self.viewModel.playerState == .playing {
                playingExpectation.fulfill()
            }
        }

        wait(for: [playingExpectation], timeout: 3)

        XCTAssertEqual(viewModel.playerState, .playing)

        let expectControlsHiddenAfter3Seconds = XCTestExpectation(description: "Controls are hidden")

        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
            if self.viewModel.areControlsHidden {
                expectControlsHiddenAfter3Seconds.fulfill()
            }
        }

        wait(for: [expectControlsHiddenAfter3Seconds], timeout: 4)

        viewModel.playerTapped()
        XCTAssertEqual(self.viewModel.areControlsHidden, false)
    }
    
    func testVideoDidBegin() {
        
    }
    
    func testAfter3SecondsOfPlaying() {
        
    }
    
    func testVideoEndPlaying() {
        
    }
    
    func testVideoPlayingFailed() {
        
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
