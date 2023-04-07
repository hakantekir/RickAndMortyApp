//
//  HomeViewModel.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 7.04.2023.
//

import Foundation

class HomeViewModel {
    var coordinator: HomeCoordinator?
    var characters = [Character]()
    let managaer = HomeManager.shared
    
    var successCallback: (()->())?
    var errorCallback: ((String)->())?
    
    func getCharacters() {
        managaer.getCharacters { result in
            switch result {
            case .success(let response):
                if let characters = response.results {
                    self.characters = characters
                    self.successCallback?()
                }
            case .failure(let error):
                self.errorCallback?(error.localizedDescription)
            }
        }
    }
}
