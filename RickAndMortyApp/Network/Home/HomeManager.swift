//
//  HomeManager.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 7.04.2023.
//

import Foundation

protocol HomeManagerProtocol {
    func getCharacters(completion: @escaping((Result<CharactersResponse, Error>) -> Void))
}

class HomeManager: HomeManagerProtocol {
    static let shared = HomeManager()
    
    func getCharacters(completion: @escaping((Result<CharactersResponse, Error>) -> Void)){
        NetworkManager.shared.request(responseType: CharactersResponse.self,
                                      url: HomeEndpoint.character.path,
                                      httpMethod: .get) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
}
