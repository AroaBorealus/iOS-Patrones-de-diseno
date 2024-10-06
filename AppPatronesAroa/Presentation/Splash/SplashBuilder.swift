//
//  SplashBuilder.swift
//  AppPatronesAroa
//
//  Created by Aroa Miguel Garcia on 3/10/24.
//

import UIKit

final class SplashBuilder {
    func build() -> UIViewController{
        let splashViewModel = SplashViewModel()
        return SplashViewController(splashViewModel)
    }
}
