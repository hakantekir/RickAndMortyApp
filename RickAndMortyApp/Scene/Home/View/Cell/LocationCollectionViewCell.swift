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
    
    func configure(data: LocationCellProtocol) {
        locationLabel.text = data.titleText
    }
}
