//
//  APIInterceptor.swift
//  AppPatronesAroa
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//
import Foundation

protocol APIInterceptor { }

protocol APIRequestInterceptorContract: APIInterceptor {
    func intercept(request: inout URLRequest)
}

final class APIRequestAuthenticatorInterceptor: APIRequestInterceptorContract {
    
    private let datasource: SessionDataSourcesContract
    
    init(datasource: SessionDataSourcesContract = SessionDataSources()) {
        self.datasource = datasource
    }
    
    func intercept(request: inout URLRequest) {
        guard let token = datasource.getSession() else {
            return
        }
        request.setValue("Bearer \(String(decoding: token, as: UTF8.self))", forHTTPHeaderField: "Authorization")
    }
}
