//
//  HomeHelper.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 7.04.2023.
//

import Foundation

enum HomeEndpoint: String {
    case character = "api/character/"
    case location = "api/location/"
    
    var path: String {
        NetworkHelper.shared.requestURL(endPoint: self.rawValue)
    }
}
