//
//  UIView+Extension.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 10.04.2023.
//

import Foundation
import UIKit

@IBDesignable
extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
