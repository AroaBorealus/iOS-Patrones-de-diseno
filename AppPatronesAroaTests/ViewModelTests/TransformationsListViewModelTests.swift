//
//  TransformationsListViewModelTests.swift
//  AppPatronesAroaTests
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

@testable import AppPatronesAroa
import XCTest


final class TransformationsListViewModelTests: XCTestCase {
    
    func test_getAllTransformations_success() {
        let successExpectation = expectation(description: "Ready")
        let loadingExpectation = expectation(description: "Loading")
        let useCaseMock = SuccessGetTransformationsUseCaseMock()
        let sut = TransformationsListModel(useCaseMock, "1")
        
        sut.onStateChanged.bind { state in
            if state == .loading {
                loadingExpectation.fulfill()
            } else if state == .ready {
                successExpectation.fulfill()
            }
        }
        
        sut.load()
        waitForExpectations(timeout: 5)
        XCTAssertEqual(sut.transformations.count, 1)
    }
    
    func test_getAllTransformations_failure() {
        let errorExpectation = expectation(description: "Error")
        let loadingExpectation = expectation(description: "Loading")
        let useCaseMock = FailedGetTransformationsUseCaseMock()
        let sut = TransformationsListModel(useCaseMock, "1")

        sut.onStateChanged.bind { state in
            if state == .loading {
                loadingExpectation.fulfill()
            } else if state == .error(reason: "Use Case Failed") {
                errorExpectation.fulfill()
            }
        }
        
        sut.load()
        waitForExpectations(timeout: 5)
        XCTAssertEqual(sut.transformations.count, 0)
    }
}
