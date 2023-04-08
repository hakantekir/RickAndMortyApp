//
//  HomeManager.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 7.04.2023.
//

import Foundation

protocol HomeManagerProtocol {
    func getCharacters(location: Int?, page: Int, completion: @escaping((Result<CharactersResponse, Error>) -> Void))
    func getLocations(page: Int, completion: @escaping((Result<LocationResponse, Error>) -> Void))
}

class HomeManager: HomeManagerProtocol {
    static let shared = HomeManager()
    
    func getCharacters(location: Int?, page: Int, completion: @escaping((Result<CharactersResponse, Error>) -> Void)) {
        var queryItems = ["page": String(page)]
        if let location = location {
            queryItems["location"] = String(location)
        }
        NetworkManager.shared.request(responseType: CharactersResponse.self,
                                      httpMethod: .get,
                                      url: HomeEndpoint.character.path,
                                      queryItems: queryItems) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getLocations(page: Int, completion: @escaping((Result<LocationResponse, Error>) -> Void)) {
        NetworkManager.shared.request(responseType: LocationResponse.self,
                                      httpMethod: .get,
                                      url: HomeEndpoint.location.path,
                                      queryItems: ["page": String(page)]) { result in
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
