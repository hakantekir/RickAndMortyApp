//
//  HomeManager.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 7.04.2023.
//

import Foundation

protocol HomeManagerProtocol {
    func getCharacters(characters: [String], page: Int, completion: @escaping((Result<[Character], Error>) -> Void))
    func getLocations(page: Int, completion: @escaping((Result<LocationResponse, Error>) -> Void))
}

class HomeManager: HomeManagerProtocol {
    static let shared = HomeManager()
    
    func getCharacters(characters: [String], page: Int, completion: @escaping((Result<[Character], Error>) -> Void)) {
        if characters.count == 1 {
            getCharacter(id: characters[0]) { result in
                completion(result)
            }
        } else {
            let parameters = characters.map{String($0)}.joined(separator: ",")
            NetworkManager.shared.request(responseType: [Character].self,
                                          httpMethod: .get,
                                          url: HomeEndpoint.character.path,
                                          pathParameter: parameters) { result in
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
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
    
    fileprivate func getCharacter(id: String, completion: @escaping((Result<[Character], Error>) -> Void)) {
        NetworkManager.shared.request(responseType: Character.self,
                                      httpMethod: .get,
                                      url: HomeEndpoint.character.path,
                                      pathParameter: id) { result in
            switch result {
            case .success(let response):
                completion(.success([response]))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
