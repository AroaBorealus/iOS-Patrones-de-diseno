//
//  GetAllTransformationsUseCase.swift
//  AppPatronesAroa
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

import Foundation

protocol GetAllTransformationsUseCaseContract{
    func execute(_ characterId: String, completion: @escaping (Result<[DBTransformation]?,GetAllTransformationsUseCaseError>) -> Void)
}


final class GetAllTransformationsUseCase: GetAllTransformationsUseCaseContract{
    func execute(_ characterId: String, completion: @escaping (Result<[DBTransformation]?, GetAllTransformationsUseCaseError>) -> Void) {
        
        GetTransformationsAPIRequest(characterId: "\(characterId)").perform { result in
            do {
                try completion(.success(result.get()))
            } catch {
                completion(.failure(GetAllTransformationsUseCaseError(reason: "Use Case Failed")))
            }
        }
    }
}

struct GetAllTransformationsUseCaseError: Error {
    let reason: String
}
