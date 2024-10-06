//
//  GetAllTransformationsUseCaseTests.swift
//  AppPatronesAroaTests
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

@testable import AppPatronesAroa
import XCTest

final class GetAllTransformationsUseCaseTests: XCTestCase {
    func test_getAllTransformations_success() {
        let sut = GetAllTransformationsUseCase()
        
        let expectation = self.expectation(description: "TestSuccess")
        let expectedTransformations = [DBTransformation(name: "1234",
                                              photo: "potato",
                                              id: "",
                                              description: "",
                                                   hero: Dictionary<String, String>())]
        do {
            let encodedCharacters = try JSONEncoder().encode(expectedTransformations)
            APISession.shared = APISessionMock{ _ in .success(encodedCharacters) }
            sut.execute("1") { result in
                guard case .success(let transformations) = result else {
                    return
                }
                guard transformations == expectedTransformations else {
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
    
    func test_getAllTransformations_failure() {
        let sut = GetAllTransformationsUseCase()
        
        let expectation = self.expectation(description: "TestFailure")
        
        APISession.shared = APISessionMock{ _ in .failure(GetAllTransformationsUseCaseError(reason: "Use Case Failed")) }
        sut.execute("1") { result in
            guard case .failure = result else {
                return
            }
            
            
            expectation.fulfill()
        }
        
        
        waitForExpectations(timeout: 5)
    }
}
