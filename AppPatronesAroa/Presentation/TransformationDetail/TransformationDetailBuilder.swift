//
//  TransformationDetailBuilder.swift
//  AppPatronesAroa
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

import UIKit

final class TransformationDetailBuilder {
    let transformation: DBTransformation
    
    init(_ transformation: DBTransformation) {
        self.transformation = transformation
    }
    
    func build() -> UIViewController{
        let viewModel = TransformationDetailViewModel(transformation)
        let viewController = TransformationDetailViewController(viewModel)
        viewController.modalPresentationStyle = .fullScreen

        return viewController
    }
}
