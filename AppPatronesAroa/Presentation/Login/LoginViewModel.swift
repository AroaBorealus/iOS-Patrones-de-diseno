//
//  LoginViewModel.swift
//  AppPatronesAroa
//
//  Created by Aroa Miguel Garcia on 3/10/24.
//

import Foundation

enum LoginState: Equatable {
    case logging
    case error(reason: String)
    case ready
}

final class LoginViewModel {
    var onStateChanged = Binding<LoginState>()
    
    var useCase: LoginUseCaseContract
    
    init(_ useCase: LoginUseCaseContract){
        self.useCase = useCase
    }
    
    func login(_ username: String?, _ password: String?){
        onStateChanged.update(.logging)
        let credentials = Credentials(username: username ?? "", password: password ?? "")
        useCase.execute(credentials) { [weak self] result in
            do {
                try result.get()
                self?.onStateChanged.update(.ready)
            } catch let error as LoginUseCaseError {
                self?.onStateChanged.update(.error(reason: error.reason))
            } catch {
                self?.onStateChanged.update(.error(reason: "An Login error has occurred"))
            }
        }
        //cambiar estado
    }
    
    
}
