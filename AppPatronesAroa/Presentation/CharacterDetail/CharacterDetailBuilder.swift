//
//  CharacterDetailBuilder.swift
//  AppPatronesAroa
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

import UIKit

final class CharacterDetailBuilder {
    
    let characterInfo: CharacterInfo
    
    init(_ characterInfo: CharacterInfo) {
        self.characterInfo = characterInfo
    }
    
    func build() -> UIViewController{
        let characterUseCase = GetCharacterUseCase()
        let transformationsUseCase = GetAllTransformationsUseCase()
        let viewModel = CharacterDetailModel(characterUseCase, transformationsUseCase, characterInfo)
        let viewController = CharacterDetailViewController(viewModel)
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
}
