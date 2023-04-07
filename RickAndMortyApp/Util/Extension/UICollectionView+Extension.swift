//
//  UICollectionView+Extension.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 7.04.2023.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func registerCell<T: NibProtocol & ReuseProtocol>(type: T.Type) {
        register(type.nib,
                 forCellWithReuseIdentifier: type.reuseIdentifier)
    }

    func dequeueCell<T: ReuseProtocol>(for indexPath: IndexPath) -> T {
        let dequeued = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
        return dequeued
    }
}
