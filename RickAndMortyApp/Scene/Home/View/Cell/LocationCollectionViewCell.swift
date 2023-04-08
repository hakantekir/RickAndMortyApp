//
//  LocationCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 8.04.2023.
//

import UIKit

protocol LocationCellProtocol {
    var titleText: String { get }
}

class LocationCollectionViewCell: UICollectionViewCell, NibProtocol, ReuseProtocol {
    
    @IBOutlet weak var locationLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? .init(red: 100.0/255.0, green: 180.0/255.0, blue: 200.0/255.0, alpha: 1.0) : .clear
        }
    }
    
    func configure(data: LocationCellProtocol) {
        locationLabel.text = data.titleText
        layer.cornerRadius = 5.0
        layer.borderWidth = 1.0
        layer.borderColor = CGColor(red: 200.0/255.0, green: 220.0/255.0, blue: 95.0/255.0, alpha: 1.0)
    }
}
