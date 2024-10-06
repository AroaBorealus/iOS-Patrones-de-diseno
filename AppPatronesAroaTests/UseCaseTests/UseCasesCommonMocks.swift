//
//  UseCasesCommonMocks.swift
//  AppPatronesAroaTests
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

@testable import AppPatronesAroa
import XCTest

final class APISessionMock: APISessionContract {
    let mockResponse: ((any APIRequest) -> Result<Data, any Error>)
    
    init(mockResponse: @escaping (any APIRequest) -> Result<Data, any Error>) {
        self.mockResponse = mockResponse
    }
    
    func request<Request: APIRequest>(apiRequest: Request, completion: @escaping (Result<Data, any Error>) -> Void) {
        completion(mockResponse(apiRequest))
    }
}

final class DummySessionDataSource: SessionDataSourcesContract {
    private(set) var session: Data?
        
    func setSession(_ session: Data) {
        self.session = session
    }
    
    func getSession() -> Data? { nil }

}
