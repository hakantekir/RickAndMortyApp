//
//  HomeViewController.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 7.04.2023.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureViewModel()
    }
    
    func configureUI() {
        collectionView.registerCell(type: CharacterCollectionViewCell.self)
        collectionView.registerSupplementaryView(type: LocationHeader.self, ofKind: UICollectionView.elementKindSectionHeader)
    }
    
    func configureViewModel() {
        viewModel.errorCallback = { [weak self] errorMessage in
            print(errorMessage)
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error", message: "Please, check your internet connection!", preferredStyle: .alert)
                let close = UIAlertAction(title: "Close", style: .cancel, handler: nil)
                alert.addAction(close)
                self?.present(alert, animated: true)
            }
        }
        viewModel.successCallback = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        viewModel.coordinator = HomeCoordinator(navigationController: navigationController ?? UINavigationController())
        viewModel.getCharacters()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CharacterCollectionViewCell = collectionView.dequeueCell(for: indexPath)
        cell.configure(data: viewModel.characters[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = collectionView.frame.width
        let size = UIScreen.main.bounds.size
        if size.height < size.width {
            width = width / 2 - 10
        }
        let height = 160.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: LocationHeader = collectionView.dequeueSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath)
        header.selectionCallback = { [weak self] location in
            self?.viewModel.location = location
            self?.viewModel.getCharacters()
        }
        
        header.viewModel.errorCallback = { [weak self] errorMessage in
            print(errorMessage)
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error", message: "Please, check your internet connection!", preferredStyle: .alert)
                let close = UIAlertAction(title: "Close", style: .cancel) { _ in
                    header.viewModel.getLocations()
                }
                alert.addAction(close)
                self?.present(alert, animated: true)
            }
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.coordinator?.showCharacterDetails(character: viewModel.characters[indexPath.item])
    }
}
