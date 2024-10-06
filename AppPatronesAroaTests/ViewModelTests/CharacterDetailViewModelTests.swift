//
//  CharacterDetailViewModelTests.swift
//  AppPatronesAroaTests
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

@testable import AppPatronesAroa
import XCTest

private final class SuccessGetCharacterUseCaseMock: GetCharacterUseCaseContract {
    func execute(_ characterName: String, completion: @escaping (Result<[AppPatronesAroa.DBCharacter]?, AppPatronesAroa.GetCharacterUseCaseError>) -> Void) {
        completion(.success([DBCharacter(name: "1234",
                                         photo: "potato",
                                         id: "1",
                                         description: "",
                                  favorite: false),
                             DBCharacter(name: "1234",
                                         photo: "potato",
                                         id: "2",
                                         description: "",
                                         favorite: false)]))
    }
}

private final class FailedGetCharacterUseCaseMock: GetCharacterUseCaseContract {
    func execute(_ characterName: String, completion: @escaping (Result<[AppPatronesAroa.DBCharacter]?, AppPatronesAroa.GetCharacterUseCaseError>) -> Void) {
        completion(.failure(GetCharacterUseCaseError(reason: "Use Case Failed")))
    }
}


final class CharacterDetailViewModelTests: XCTestCase {
    
    func test_load_success() {
        let successExpectation = expectation(description: "Ready")
        let loadingExpectation = expectation(description: "Loading")
        let useCaseMock = SuccessGetCharacterUseCaseMock()
        let expectedCharacter = DBCharacter(name: "1234",
                                            photo: "potato",
                                            id: "1",
                                            description: "",
                                     favorite: false)
        
        let characterInfo = CharacterInfo(characterName: "1234", characterId: "1")
        let sut = CharacterDetailModel(useCaseMock, characterInfo)
        
        sut.onStateChanged.bind { state in
            if state == .loading {
                loadingExpectation.fulfill()
            } else if state == .ready(character: expectedCharacter) {
                successExpectation.fulfill()
            }
        }
        
        sut.load()
        waitForExpectations(timeout: 5)
    }
    
    func test_load_failure() {
        let errorExpectation = expectation(description: "Error")
        let loadingExpectation = expectation(description: "Loading")
        let useCaseMock = FailedGetCharacterUseCaseMock()
        let characterInfo = CharacterInfo(characterName: "1234", characterId: "1")
        let sut = CharacterDetailModel(useCaseMock, characterInfo)
        
        sut.onStateChanged.bind { state in
            if state == .loading {
                loadingExpectation.fulfill()
            } else if state == .error(reason: "Use Case Failed") {
                errorExpectation.fulfill()
            }
        }
        
        sut.load()
        waitForExpectations(timeout: 5)
    }
}
