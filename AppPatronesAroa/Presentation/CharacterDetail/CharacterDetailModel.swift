//
//  CharacterDetailModel.swift
//  AppPatronesAroa
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

import Foundation

enum CharacterDetailStates {
    case loading
    case ready(character: DBCharacter)
    case error(reason: String)
}

final class CharacterDetailModel {
    let useCase: GetCharacterUseCaseContract
    let characterInfo: CharacterInfo
    var onStateChanged =  Binding<CharacterDetailStates>()
    
    init(_ useCase: GetCharacterUseCaseContract, _ characterInfo: CharacterInfo) {
        self.useCase = useCase
        self.characterInfo = characterInfo
    }
    
    func load(){
        onStateChanged.update(.loading)
        useCase.execute(characterInfo.characterName) { [weak self] result in
            switch result {
            case .success(let characters):
                guard let charId = self?.characterInfo.characterId else {
                    self?.onStateChanged.update(.error(reason: "Invalid entry ID"))
                    return
                }
                
                guard let foundCharacter = characters?.first(where: { candidate in
                    return candidate.id == charId
                }) else{
                    self?.onStateChanged.update(.error(reason: "Character not found by ID"))
                    return
                }
                self?.onStateChanged.update(.ready(character: foundCharacter))
                
            case .failure(let error):
                self?.onStateChanged.update(.error(reason: error.reason))
            }
        }
    }
}
