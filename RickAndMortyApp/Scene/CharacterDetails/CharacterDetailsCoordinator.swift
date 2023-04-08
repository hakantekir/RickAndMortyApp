//
//  CharacterDetailsCoordinator.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 8.04.2023.
//

import Foundation
import UIKit

class CharacterDetailsCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
