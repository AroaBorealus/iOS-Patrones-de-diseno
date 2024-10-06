//
//  HomeViewModel.swift
//  AppPatronesAroa
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

import Foundation

enum HomeStates {
    case loading
    case ready
    case error(reason: String)
}

final class HomeViewModel {
    let useCase: GetAllCharactersUseCaseContract
    var onStateChanged = Binding<HomeStates>()
    var characters: [DBCharacter] = []
    
    init(_ useCase: GetAllCharactersUseCaseContract) {
        self.useCase = useCase
    }
    
    func load() {
        onStateChanged.update(.loading)
        useCase.execute { [weak self ] result in
            switch result {
            case .success(let characterArray):
                guard let characterArrayUnwrapped = characterArray else {
                    self?.onStateChanged.update(.error(reason: "Character array not found"))
                    return
                }
                self?.characters = characterArrayUnwrapped
                self?.onStateChanged.update(.ready)
            case .failure(let error):
                self?.onStateChanged.update(.error(reason: error.reason))
            }
        }
    }
}
