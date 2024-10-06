//
//  TransformationsListModel.swift
//  AppPatronesAroa
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

import Foundation

enum TransformationsListStates: Equatable {
    case loading
    case ready
    case error(reason: String)
}

final class TransformationsListModel {
    
    let useCase: GetAllTransformationsUseCaseContract
    let characterId: String
    var transformations: [DBTransformation] = []
    var onStateChanged = Binding<TransformationsListStates>()
    
    init(_ useCase: GetAllTransformationsUseCaseContract, _ characterId: String) {
        self.useCase = useCase
        self.characterId = characterId
    }
    
    func load() {
        onStateChanged.update(.loading)
        useCase.execute(characterId) { [weak self] result in
            switch result {
            case .success(let transformations):
                guard let unwrappedTransformations = transformations else {
                    self?.onStateChanged.update(.error(reason: "Could not unwrapp transformations"))
                    return
                }
                self?.transformations = unwrappedTransformations.sorted{
                    let name0Arr = $0.name.components(separatedBy: ".")
                    let name1Arr = $1.name.components(separatedBy: ".")
                    
                    guard let num0Str = name0Arr.first else
                    {
                        return $0.name < $1.name
                    }
                    
                    guard let num1Str = name1Arr.first else
                    {
                        return $0.name < $1.name
                    }
                    
                    guard let int0 = Int(num0Str) else
                    {
                        return $0.name < $1.name
                    }
                    
                    guard let int1 = Int(num1Str) else
                    {
                        return $0.name < $1.name
                    }
                    
                    return int0 < int1
                }
                self?.onStateChanged.update(.ready)
            case .failure(let error):
                self?.onStateChanged.update(.error(reason: error.reason))
            }
        }
    }
    
}
