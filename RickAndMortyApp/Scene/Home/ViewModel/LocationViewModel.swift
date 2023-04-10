//
//  LocationViewModel.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 8.04.2023.
//

import Foundation

class LocationViewModel {
    let manager = HomeManager.shared
    var locations = [Location?]()
    var currentPage = 1
    var isLastPage = false
    
    var errorCallback: ((String) -> Void)?
    var successCallback: (() -> Void)?
    
    func getLocations() {
        manager.getLocations(page: currentPage) { result in
            if self.locations.count != 0 {
                self.locations.removeLast()
            }
            switch result {
            case .success(let response):
                if let locations = response.results {
                    self.locations.append(contentsOf: locations)
                    self.isLastPage = self.currentPage == response.info?.pages
                    if !self.isLastPage {
                        self.locations.append(nil)
                    }
                    self.successCallback?()
                }
            case .failure(let error):
                self.errorCallback?(error.localizedDescription)
            }
        }
    }
    
    func pagination() {
        if !isLastPage {
            currentPage += 1
            getLocations()
        }
    }
}
