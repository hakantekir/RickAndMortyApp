//
//  CharacterCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 7.04.2023.
//

import UIKit

protocol CharacterCellProtocol {
    var titleText: String { get }
    var imagePath: String { get }
}

class CharacterCollectionViewCell: UICollectionViewCell, NibProtocol, ReuseProtocol {
    @IBOutlet private weak var characterImage: UIImageView!
    @IBOutlet  weak var titleLabel: UILabel!
    
    func configure(data: CharacterCellProtocol) {
        titleLabel.text = data.titleText
        characterImage.loadURL(url: data.imagePath)
    }
}
