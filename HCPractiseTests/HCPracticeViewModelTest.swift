//
//  HCPracticeViewModelTest.swift
//  HCPractiseTests
//
//  Created by Anton Gubarenko on 22.01.2021.
//

import XCTest

class HCPracticeViewModelTest: XCTestCase {
    
    private let viewModel = PracticeViewModel()
    
    private let demoMP3 = URL(string: "https://dev.humancosmos.app/storage/practice/458/Intention.mp3")!
    
    override func setUpWithError() throws {
        viewModel.prepareAudioSession(demoMP3)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAudioLoading() throws {
        XCTAssertTrue(viewModel.audioPlayer != nil)
    }
    
    func testAudioPlaying() throws {
        viewModel.play()
        XCTAssertFalse(viewModel.isPaused)
    }
    
    func testAudioPausing() throws {
        viewModel.play()
        viewModel.pause()
        XCTAssertTrue(viewModel.isPaused)
    }
}
