//
//  LaunchCoordinator.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 8.04.2023.
//

import Foundation
import UIKit

class LaunchCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(){
        let controller = LaunchViewController()
        controller.coordinator = self
        navigationController.show(controller, sender: nil)
    }
    
    func showHome() {
        let controller = HomeViewController.instantiate(name: .main)
        navigationController.setViewControllers([controller], animated: false)
    }
}
