//
//  GetAllCharactersUseCaseTests.swift
//  AppPatronesAroaTests
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

@testable import AppPatronesAroa
import XCTest

final class GetAllCharactersUseCaseTests: XCTestCase {
    func test_getAllCharacters_success() {
        let sut = GetAllCharactersUseCase()
        
        let expectation = self.expectation(description: "TestSuccess")
        let expectedCharacters = [DBCharacter(name: "1234",
                                              photo: "potato",
                                              id: "",
                                              description: "",
                                              favorite: false)]
        do {
            let encodedCharacters = try JSONEncoder().encode(expectedCharacters)
            APISession.shared = APISessionMock{ _ in .success(encodedCharacters) }
            sut.execute() { result in
                guard case .success(let characters) = result else {
                    return
                }
                guard characters == expectedCharacters else {
                    return
                }
                
                expectation.fulfill()
            }
            
        }
        catch {
            return
        }
        waitForExpectations(timeout: 5)
    }
    
    func test_getAllCharacters_failure() {
        let sut = GetAllCharactersUseCase()
        
        let expectation = self.expectation(description: "TestFailure")
        
        APISession.shared = APISessionMock{ _ in .failure(GetAllCharactersUseCaseError(reason: "Use Case Failed")) }
        sut.execute() { result in
            guard case .failure = result else {
                return
            }
            
            
            expectation.fulfill()
        }
        
        
        waitForExpectations(timeout: 5)
    }
}
