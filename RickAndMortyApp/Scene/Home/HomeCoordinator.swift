//
//  HomeCoordinator.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 7.04.2023.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(){
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(HomeViewController.self)")
        navigationController.show(controller, sender: nil)
    }
}
