//
//  HomeViewController.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 7.04.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureViewModel()
    }
    
    func configureUI() {
        collectionView.registerCell(type: CharacterCollectionViewCell.self)
    }
    
    func configureViewModel() {
        viewModel.getCharacters()
        viewModel.errorCallback = { [weak self] errorMessage in
            print(errorMessage)
        }
        viewModel.successCallback = { [weak self] in
            DispatchQueue.main.sync {
                self?.collectionView.reloadData()
            }
        }
        viewModel.coordinator = HomeCoordinator(navigationController: navigationController ?? UINavigationController())
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
        let width = collectionView.frame.width
        let height = collectionView.frame.height * 0.3
        return CGSize(width: width, height: height)
    }
}
