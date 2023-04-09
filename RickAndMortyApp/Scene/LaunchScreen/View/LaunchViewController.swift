//
//  LaunchViewController.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 8.04.2023.
//

import UIKit

class LaunchViewController: UIViewController {
    
    var coordinator: LaunchCoordinator?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 150))
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        label.font = UIFont(name: "Avenir", size: 30)
        label.textAlignment = .center
        if UserDefaults.standard.bool(forKey: "isLaunchedBefore") {
            label.text = "Hello!"
        } else {
            label.text = "Welcome!"
            UserDefaults.standard.setValue(true, forKey: "isLaunchedBefore")
        }
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.addSubview(label)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageView.center = view.center
        label.center = CGPoint(x: view.center.x, y: view.center.y * 1.2 + imageView.frame.height)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
            self.animate()
        })
    }
    private func animate(){
        UIView.animate(withDuration: 1.5, animations: {
            let sizeX = self.view.frame.size.width * 5
            let sizeY = sizeX / 2
            let diffX = sizeX - self.view.frame.size.width
            let diffY = self.view.frame.size.height - sizeY
            self.imageView.frame = CGRect(x: -(diffX/2),
                                          y: diffY/2,
                                          width: sizeX,
                                          height: sizeY)
        })
        UIView.animate(withDuration: 2, animations: {
            self.imageView.alpha = 0
        }) { done in
            if done {
                self.coordinator?.showHome()
            }
        }
    }
}

