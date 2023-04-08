//
//  LocationHeader.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 8.04.2023.
//

import UIKit

class LocationHeader: UICollectionReusableView, NibProtocol, ReuseProtocol {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = LocationViewModel()
    var selectionCallback: ((_ location: Location)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViewModel()
    }
    
    override func layoutSubviews() {
        configureUI()
    }
    
    fileprivate func configureUI() {
        collectionView.registerCell(type: LocationCollectionViewCell.self)
    }
    
    fileprivate func configureViewModel() {
        viewModel.successCallback = { [weak self] in
            DispatchQueue.main.sync {
                self?.collectionView.reloadData()
            }
        }
        viewModel.getLocations()
    }
}

extension LocationHeader: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.locations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LocationCollectionViewCell = collectionView.dequeueCell(for: indexPath)
        cell.configure(data: viewModel.locations[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectionCallback?(viewModel.locations[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 0.3
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}
