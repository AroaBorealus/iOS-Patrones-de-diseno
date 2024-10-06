//
//  LoginViewModelTests.swift
//  AppPatronesAroaTests
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

@testable import AppPatronesAroa
import XCTest

private final class SuccessGetCharactersUseCaseMock: GetAllCharactersUseCaseContract {
    func execute(completion: @escaping (Result<[AppPatronesAroa.DBCharacter]?, AppPatronesAroa.GetAllCharactersUseCaseError>) -> Void) {
        completion(.success([DBCharacter(name: "1234",
                                         photo: "potato",
                                         id: "",
                                         description: "",
                                  favorite: false)]))
    }
}

private final class FailedGetCharactersUseCaseMock: GetAllCharactersUseCaseContract {
    func execute(completion: @escaping (Result<[AppPatronesAroa.DBCharacter]?, AppPatronesAroa.GetAllCharactersUseCaseError>) -> Void) {
        completion(.failure(GetAllCharactersUseCaseError(reason: "Use Case Failed")))
    }
}


final class HomeViewModelTests: XCTestCase {
    
    func test_getAllCharacters_success() {
        let successExpectation = expectation(description: "Ready")
        let loadingExpectation = expectation(description: "Loading")
        let useCaseMock = SuccessGetCharactersUseCaseMock()
        let sut = HomeViewModel(useCaseMock)
        
        sut.onStateChanged.bind { state in
            if state == .loading {
                loadingExpectation.fulfill()
            } else if state == .ready {
                successExpectation.fulfill()
            }
        }
        
        sut.load()
        waitForExpectations(timeout: 5)
        XCTAssertEqual(sut.characters.count, 1)
    }
    
    func test_getAllCharacters_failure() {
        let errorExpectation = expectation(description: "Error")
        let loadingExpectation = expectation(description: "Loading")
        let useCaseMock = FailedGetCharactersUseCaseMock()
        let sut = HomeViewModel(useCaseMock)
        
        sut.onStateChanged.bind { state in
            if state == .loading {
                loadingExpectation.fulfill()
            } else if state == .error(reason: "Use Case Failed") {
                errorExpectation.fulfill()
            }
        }
        
        sut.load()
        waitForExpectations(timeout: 5)
        XCTAssertEqual(sut.characters.count, 0)
    }
}
