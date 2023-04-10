//
//  CharacterCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 7.04.2023.
//

import UIKit

protocol CharacterCellProtocol {
    var name: String? { get }
    var image: String? { get }
    var status: Status? { get }
    var gender: Gender? { get }
}

class CharacterCollectionViewCell: UICollectionViewCell, NibProtocol, ReuseProtocol {
    @IBOutlet private weak var characterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var statusImage: UIImageView!
    @IBOutlet private weak var genderLabel: UILabel!
    @IBOutlet private weak var genderImage: UIImageView!
    
    func configure(data: CharacterCellProtocol) {
        titleLabel.text = data.name
        characterImage.loadURL(url: data.image ?? "", placeholder: UIImage(named: "placeholder"))
        statusLabel.text = data.status?.rawValue
        genderLabel.text = data.gender?.rawValue
        switch data.status {
        case .alive:
            statusImage.tintColor = .green
        case .dead:
            statusImage.tintColor = .red
        default:
            statusImage.tintColor = .black
        }
        switch data.gender {
        case .male:
            genderImage.tintColor = .blue
        case .female:
            genderImage.tintColor = UIColor(named: "pink")
        case .genderless:
            genderImage.tintColor = .purple
        default:
            genderImage.tintColor = .black
        }
    }
}
