//
//  TransformationsBuilder.swift
//  AppPatronesAroa
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

import UIKit

final class TransformationsListBuilder {
    
    let characterId: String
    
    init(_ characterId: String) {
        self.characterId = characterId
    }
    
    func build() -> UIViewController {
        
        let useCase = GetAllTransformationsUseCase()
        let viewModel = TransformationsListModel(useCase, characterId)
        let viewController = TransformationsListViewController(viewModel)
        return viewController
    }
}
