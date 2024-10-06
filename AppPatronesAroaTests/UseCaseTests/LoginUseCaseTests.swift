//
//  LoginUseCaseTests.swift
//  AppPatronesAroaTests
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

@testable import AppPatronesAroa
import XCTest

final class LoginUseCaseTests: XCTestCase {
    func test_loginGetToken_success() {
        let dataSource = DummySessionDataSource()
        let sut = LoginUseCase(sessionDataSource: dataSource)
        
        let expectation = self.expectation(description: "TestSuccess")
        let data = Data("YupiToken".utf8)
        
        APISession.shared = APISessionMock { _ in .success(data) }
        sut.execute(Credentials(username: "a@b.es", password: "122345")) { result in
            guard case .success = result else {
                return
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssertEqual(dataSource.session, data)
    }
    
    func test_login_networkFailure() {
        let dataSource = DummySessionDataSource()
        let sut = LoginUseCase(sessionDataSource: dataSource)
        
        let expectation = self.expectation(description: "TestFailure")
        APISession.shared = APISessionMock { _ in .failure(APIErrorResponse.network("login-fail")) }
        
        sut.execute(Credentials(username: "a@b.es", password: "122345")) { result in
            guard case .failure = result else {
                return
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssertNil(dataSource.session)
    }
    
    func test_login_invalidUsername(){
        let dataSource = DummySessionDataSource()
        let sut = LoginUseCase(sessionDataSource: dataSource)
        
        let expectation = self.expectation(description: "TestFailure")
        let desiredError = LoginUseCaseError(reason: "Invalid username")
        
        APISession.shared = APISessionMock { _ in .failure(APIErrorResponse.network("login-fail")) }
        
        sut.execute(Credentials(username: "ab.es", password: "122345")) { result in
            
            guard case .failure(let error) = result else {
                return
            }
            
            guard error == desiredError else{
                return
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssertNil(dataSource.session)
    }
    
    func test_login_invalidPassword(){
        let dataSource = DummySessionDataSource()
        let sut = LoginUseCase(sessionDataSource: dataSource)
        
        let expectation = self.expectation(description: "TestFailure")
        let desiredError = LoginUseCaseError(reason: "Invalid password")
        
        APISession.shared = APISessionMock { _ in .failure(APIErrorResponse.network("login-fail")) }
        
        sut.execute(Credentials(username: "ab@holi.es", password: "45")) { result in
            
            guard case .failure(let error) = result else {
                return
            }
            
            guard error == desiredError else{
                return
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssertNil(dataSource.session)
    }
    
}
