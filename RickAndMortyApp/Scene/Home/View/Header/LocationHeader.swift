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
    
    var isLoading = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViewModel()
    }
    
    override func layoutSubviews() {
        configureUI()
    }
    
    fileprivate func configureUI() {
        collectionView.registerCell(type: LocationCollectionViewCell.self)
        collectionView.registerCell(type: LoadingCollectionViewCell.self)
    }
    
    fileprivate func configureViewModel() {
        viewModel.successCallback = { [weak self] in
            DispatchQueue.main.sync {
                self?.collectionView.reloadData()
                self?.isLoading = false
                if let location = self?.viewModel.locations[0], self?.viewModel.currentPage == 1 {
                    self?.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: [])
                    self?.selectionCallback?(location)
                }
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
        if let location = viewModel.locations[indexPath.item] {
            let cell: LocationCollectionViewCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(data: location)
            return cell
        } else {
            let cell: LoadingCollectionViewCell = collectionView.dequeueCell(for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let location = viewModel.locations[indexPath.item] {
            selectionCallback?(location)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let location = viewModel.locations[indexPath.item] {
            let label = UILabel()
            label.text = location.titleText
            label.font = UIFont(name: "Avenir", size: 17)
            var labelSize = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: label.frame.size.height))
            labelSize.width += 10
            labelSize.height += 10
            return labelSize
        } else {
            return CGSize(width: 100, height: 30)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !isLoading && indexPath.item == viewModel.locations.count - 1 {
            isLoading = true
            viewModel.pagination()
            collectionView.reloadData()
        }
    }
}
