//
//  HCPractiseTests.swift
//  HCPractiseTests
//
//  Created by Anton Gubarenko on 21.01.2021.
//

import XCTest
@testable import HCPractise

class HCPractiseViewModelTests: XCTestCase {

    private let viewModel = PracticesViewModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testUserProfileLoading() throws {
        let expectation = XCTestExpectation(description: "Profile fetched")
        
        viewModel.getUserInfo { result in
            switch result {
            case .success():
                expectation.fulfill()
                break
            default:
                break
            }
        }
        
        wait(for: [expectation], timeout: 20.0)
    }
    
    func testUserNameLoading() throws {
        let expectation = XCTestExpectation(description: "User name fetched")
        
        viewModel.getUserInfo { result in
            switch result {
            case .success():
                if !self.viewModel.userName.isEmpty {
                    expectation.fulfill()
                }
                break
            default:
                break
            }
        }
        wait(for: [expectation], timeout: 20.0)
    }
    
    func testUserPracticesLoading() throws {
        let expectation = XCTestExpectation(description: "Practices fetched")
        
        viewModel.getPractices { result in
            switch result {
            case .success():
                if !self.viewModel.dataSource.practices.isEmpty {
                    expectation.fulfill()
                }
                break
            default:
                break
            }
        }
        wait(for: [expectation], timeout: 20.0)
    }

}
