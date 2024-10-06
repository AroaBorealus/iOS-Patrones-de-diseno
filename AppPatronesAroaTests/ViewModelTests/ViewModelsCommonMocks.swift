//
//  ViewModelsCommonMocks.swift
//  AppPatronesAroaTests
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

@testable import AppPatronesAroa
import Foundation

final class SuccessGetTransformationsUseCaseMock: GetAllTransformationsUseCaseContract {
    func execute(_ characterId: String, completion: @escaping (Result<[AppPatronesAroa.DBTransformation]?, AppPatronesAroa.GetAllTransformationsUseCaseError>) -> Void) {
        completion(.success([DBTransformation(name: "1234",
                                              photo: "potato",
                                              id: "",
                                              description: "",
                                                   hero: Dictionary<String, String>())]))
    }
}

final class FailedGetTransformationsUseCaseMock: GetAllTransformationsUseCaseContract {
    func execute(_ characterId: String, completion: @escaping (Result<[AppPatronesAroa.DBTransformation]?, AppPatronesAroa.GetAllTransformationsUseCaseError>) -> Void) {
        completion(.failure(GetAllTransformationsUseCaseError(reason: "Use Case Failed")))
    }
}
