//
//  SessionDataSources.swift
//  AppPatronesAroa
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

import Foundation

protocol SessionDataSourcesContract {
    func getSession() -> Data?
    func setSession(_ session: Data)
}

final class SessionDataSources: SessionDataSourcesContract {
    private static var token: Data?
    
    func getSession() -> Data?{
        return SessionDataSources.token
    }
    
    func setSession(_ session: Data) {
        SessionDataSources.token = session
    }
}
