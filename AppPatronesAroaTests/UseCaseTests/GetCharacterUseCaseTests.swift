//
//  GetCharacterUseCaseTests.swift
//  AppPatronesAroaTests
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

@testable import AppPatronesAroa
import XCTest

final class GetCharacterUseCaseTests: XCTestCase {
    func test_getCharacterUseCase_success() {
        let sut = GetCharacterUseCase()
        
        let expectation = self.expectation(description: "TestSuccess")
        let expectedCharacters = [DBCharacter(name: "1234",
                                              photo: "potato",
                                              id: "",
                                              description: "",
                                              favorite: false)]
        do {
            let encodedCharacters = try JSONEncoder().encode(expectedCharacters)
            APISession.shared = APISessionMock{ _ in .success(encodedCharacters) }
            sut.execute("1234") { result in
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
        let sut = GetCharacterUseCase()
        
        let expectation = self.expectation(description: "TestFailure")
        
        APISession.shared = APISessionMock{ _ in .failure(GetCharacterUseCaseError(reason: "Use Case Failed")) }
        sut.execute("1234") { result in
            guard case .failure = result else {
                return
            }
            
            
            expectation.fulfill()
        }
        
        
        waitForExpectations(timeout: 5)
    }
}

