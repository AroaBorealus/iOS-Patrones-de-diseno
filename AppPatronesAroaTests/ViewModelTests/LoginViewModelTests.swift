//
//  LoginViewModelTests.swift
//  AppPatronesAroaTests
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

@testable import AppPatronesAroa
import XCTest

private final class SuccessLoginUseCaseMock: LoginUseCaseContract {
    func execute(_ credentials: AppPatronesAroa.Credentials, completion: @escaping (Result<Void, AppPatronesAroa.LoginUseCaseError>) -> Void) {
        completion(.success(()))
    }
}


private final class FailedLoginUseCaseMock: LoginUseCaseContract {
    func execute(_ credentials: AppPatronesAroa.Credentials, completion: @escaping (Result<Void, AppPatronesAroa.LoginUseCaseError>) -> Void) {
        completion(.failure(LoginUseCaseError(reason: "Network failed")))
    }
}


final class LoginViewModelTests: XCTestCase {
    
    func test_login_success() {
        let successExpectation = expectation(description: "Ready")
        let loggingxpectation = expectation(description: "Logging")
        let useCaseMock = SuccessLoginUseCaseMock()
        
        let sut = LoginViewModel(useCaseMock)
        
        sut.onStateChanged.bind { state in
            if state == .logging {
                loggingxpectation.fulfill()
            } else if state == .ready {
                successExpectation.fulfill()
            }
        }
        
        sut.login("1234", "password")
        waitForExpectations(timeout: 5)
    }
    
    func test_login_failure() {
        let errorExpectation = expectation(description: "Error")
        let loggingxpectation = expectation(description: "Logging")
        let useCaseMock = FailedLoginUseCaseMock()
        
        let sut = LoginViewModel(useCaseMock)
        
        sut.onStateChanged.bind { state in
            if state == .logging {
                loggingxpectation.fulfill()
            } else if state == .error(reason: "Network failed") {
                errorExpectation.fulfill()
            }
        }
        
        sut.login("1234", "password")
        waitForExpectations(timeout: 5)}
}
