//
//  CharacterDetailsViewController.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 8.04.2023.
//

import UIKit

class CharacterDetailsViewController: UIViewController, Storyboarded {

    @IBOutlet private weak var characterImage: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var specyLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var episodesLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    
    @IBOutlet var labelsToTopConstraint: NSLayoutConstraint!
    @IBOutlet var labelsToLeftConstraint: NSLayoutConstraint!
    @IBOutlet var imageToLeftConstraint: NSLayoutConstraint!
    @IBOutlet var imageCenterContraint: NSLayoutConstraint!
    
    var viewModel: CharacterDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        let size = UIScreen.main.bounds.size
        if size.width < size.height {
            applyPortraitConstraints()
        } else {
            applyLandscapeConstraints()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        handleOrientation()
    }
    
    func handleOrientation() {
        if UIDevice.current.orientation.isLandscape {
            applyLandscapeConstraints()
        } else {
            applyPortraitConstraints()
        }
    }
    
    func applyLandscapeConstraints() {
        labelsToTopConstraint.constant = 20
        labelsToLeftConstraint.constant = 315
        imageCenterContraint.isActive = false
        imageToLeftConstraint.isActive = true
    }
    
    func applyPortraitConstraints() {
        labelsToTopConstraint.constant = 315
        labelsToLeftConstraint.constant = 0
        imageToLeftConstraint.isActive = false
        imageCenterContraint.isActive = true
    }
    
    fileprivate func configureUI(){
        let character = viewModel?.character
        let episodes = character?.episode?.map { $0.components(separatedBy: "/").last }.compactMap { $0 }
        let episodesString = episodes?.map{String($0)}.joined(separator: ",")
        let dateFormatter = DateFormatter()
        var formattedDate = ""
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: character?.created ?? "") {
            dateFormatter.dateFormat = "d MMM yyyy, hh:mm:ss"
            formattedDate = dateFormatter.string(from: date)
        }
        let titleLabel = UILabel()
        titleLabel.text = character?.name
        titleLabel.font = UIFont(name: "Avenir-heavy", size: 17)
        navigationItem.titleView = titleLabel
        characterImage.loadURL(url: character?.imagePath ?? "", placeholder: UIImage(named: "placeholder"))
        statusLabel.text = character?.status
        specyLabel.text = character?.species
        genderLabel.text = character?.gender
        originLabel.text = character?.origin?.name
        locationLabel.text = character?.location?.name
        episodesLabel.text = episodesString
        createdLabel.text = formattedDate
    }
}
