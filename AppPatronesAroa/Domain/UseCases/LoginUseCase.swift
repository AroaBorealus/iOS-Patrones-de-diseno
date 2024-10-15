//
//  LoginUseCase.swift
//  AppPatronesAroa
//
//  Created by Aroa Miguel Garcia on 4/10/24.
//

import Foundation

protocol LoginUseCaseContract{
    func execute(_ credentials: Credentials, completion: @escaping (Result<Void,LoginUseCaseError>) -> Void)
}


final class LoginUseCase: LoginUseCaseContract{
    private let sessionDataSource: SessionDataSourcesContract
    
    init(sessionDataSource: SessionDataSourcesContract = SessionDataSources()) {
        self.sessionDataSource = sessionDataSource
    }
    
    func execute(_ credentials: Credentials, completion: @escaping (Result<Void, LoginUseCaseError>) -> Void) {
        
        
        guard validateUsername(credentials.username) else {
            completion(.failure(LoginUseCaseError(reason: "Invalid username")))
            return
        }
        
        guard validatePassword(credentials.password) else {
            completion(.failure(LoginUseCaseError(reason: "Invalid password")))
            return
        }
        
        LoginAPIRequest(credentials: credentials).perform { [weak self] result in
            switch result {
            case .success(let token):
                self?.sessionDataSource.setSession(token)
                completion(.success(()))
            case .failure:
                completion(.failure(LoginUseCaseError(reason: "Network failed")))
            }
        }
    }
    
    func validateUsername(_ username: String) -> Bool {
        return username.contains("@") && !username.isEmpty
    }
    
    func validatePassword(_ password: String) -> Bool {
        return password.count >= 5
    }
}

struct LoginUseCaseError: Error, Equatable{
    let reason: String
}
