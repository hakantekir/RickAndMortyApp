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
    
    var location: Location?
    
    var successCallback: (()->())?
    var errorCallback: ((String)->())?
    
    func getCharacters() {
        guard let characters = (location?.residents?.map { $0.components(separatedBy: "/").last }.compactMap { $0 }), !characters.isEmpty else {
            self.characters = []
            self.successCallback?()
            return
        }
        managaer.getCharacters(characters: characters , page: 1) { result in
            switch result {
            case .success(let response):
                self.characters = response
                self.successCallback?()
            case .failure(let error):
                self.errorCallback?(error.localizedDescription)
            }
        }
    }
}
