//
//  Binding.swift
//  AppPatronesAroa
//
//  Created by Aroa Miguel Garcia on 3/10/24.
//

import Foundation

final class Binding<State> {
    typealias Completion = (State) -> Void
    
    var completion: Completion?
    
    func bind(completion: @escaping Completion){
        self.completion = completion
    }
    
    func update(_ newValue: State) {
        DispatchQueue.main.async { [weak self] in
            self?.completion?(newValue)
        }
    }
}
