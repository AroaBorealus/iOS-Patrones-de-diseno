//
//  CharacterDetailModel.swift
//  AppPatronesAroa
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

import Foundation

struct CharacterDetailInfo: Equatable{
    var character: DBCharacter
    var hasTransformations: Bool = false
}

enum CharacterDetailStates: Equatable {
    case loading
    case ready(character: CharacterDetailInfo)
    case error(reason: String)
}

final class CharacterDetailModel {
    let characterUseCase: GetCharacterUseCaseContract
    let transformationsUseCase: GetAllTransformationsUseCaseContract
    let characterInfo: CharacterInfo
    var onStateChanged =  Binding<CharacterDetailStates>()
    
    init(_ characterUseCase: GetCharacterUseCaseContract,_ transformationsUseCase: GetAllTransformationsUseCaseContract, _ characterInfo: CharacterInfo) {
        self.characterUseCase = characterUseCase
        self.transformationsUseCase = transformationsUseCase
        self.characterInfo = characterInfo
    }
    
    func load(){
        onStateChanged.update(.loading)
        characterUseCase.execute(characterInfo.characterName) { [weak self] result in
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
                
                self?.transformationsUseCase.execute(foundCharacter.id) { [weak self] result in
                    switch result {
                    case .success(let transformations):
                        var characterInfo = CharacterDetailInfo(character: foundCharacter)
                        if let unwrappedTransformations = transformations {
                            characterInfo.hasTransformations = !unwrappedTransformations.isEmpty
                            self?.onStateChanged.update(.ready(character: characterInfo))
                            return
                        }
                        characterInfo.hasTransformations = false
                        self?.onStateChanged.update(.ready(character: characterInfo))
                    case .failure:
                        var characterInfo = CharacterDetailInfo(character: foundCharacter)
                        characterInfo.hasTransformations = false
                        self?.onStateChanged.update(.ready(character: characterInfo))
                    }
                    
                }
            case .failure(let error):
                self?.onStateChanged.update(.error(reason: error.reason))
            }
        }
    }
}
