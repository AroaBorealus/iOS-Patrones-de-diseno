//
//  GetCharacterUseCase.swift
//  AppPatronesAroa
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

import Foundation

protocol GetCharacterUseCaseContract{
    func execute(_ character: String, completion: @escaping (Result<[DBCharacter]?,GetCharacterUseCaseError>) -> Void)
}


final class GetCharacterUseCase: GetCharacterUseCaseContract{
    func execute(_ character: String, completion: @escaping (Result<[DBCharacter]?, GetCharacterUseCaseError>) -> Void) {
        
        GetCharactersAPIRequest(characterName: character).perform { result in
            do {
                try completion(.success(result.get()))
            } catch {
                completion(.failure(GetCharacterUseCaseError(reason: "Use Case Failed")))
            }
        }
    }
}

struct GetCharacterUseCaseError: Error {
    let reason: String
}
