//
//  LocationViewModel.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 8.04.2023.
//

import Foundation

class LocationViewModel {
    let manager = HomeManager.shared
    var locations = [Location]()
    
    var successCallback: (() -> Void)?
    func getLocations(){
        manager.getLocations(page: 1) { result in
            switch result {
            case .success(let response):
                if let locations = response.results {
                    self.locations = locations
                    self.successCallback?()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
