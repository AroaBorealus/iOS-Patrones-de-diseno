//
//  HomeBuilder.swift
//  AppPatronesAroa
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

import UIKit

final class HomeBuilder {
    func build() -> UIViewController{
        let useCase = GetAllCharactersUseCase()
        let viewModel = HomeViewModel(useCase)
        let viewController = HomeViewController(viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        
        return navigationController
    }
}
