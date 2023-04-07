//
//  SceneDelegate.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 7.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: HomeCoordinator?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window.windowScene = windowScene
        
        let navigationController = UINavigationController()
        
        coordinator = HomeCoordinator(navigationController: navigationController)
        coordinator?.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
    }
}

