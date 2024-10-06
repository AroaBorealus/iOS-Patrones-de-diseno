//
//  GetCharactersUseCase.swift
//  AppPatronesAroa
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

import Foundation

protocol GetAllCharactersUseCaseContract{
    func execute(completion: @escaping (Result<[DBCharacter]?,GetAllCharactersUseCaseError>) -> Void)
}


final class GetAllCharactersUseCase: GetAllCharactersUseCaseContract{
    func execute(completion: @escaping (Result<[DBCharacter]?, GetAllCharactersUseCaseError>) -> Void) {
        
        GetCharactersAPIRequest(characterName: "").perform { result in
            do {
                try completion(.success(result.get()))
            } catch {
                completion(.failure(GetAllCharactersUseCaseError(reason: "Use Case Failed")))
            }
        }
    }
}

struct GetAllCharactersUseCaseError: Error {
    let reason: String
}
