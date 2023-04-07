//
//  UIImageView+Extension.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 7.04.2023.
//

import Foundation
import UIKit

extension UIImageView {
    func loadURL(url: String) {
        if let url = URL(string: url) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self.image = image
                }
            }
            task.resume()
        }
    }
}
