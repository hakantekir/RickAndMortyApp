//
//  Character.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 7.04.2023.
//

import Foundation

struct Character: Codable, CharacterCellProtocol {
    let id: Int?
    let name, status, species, type: String?
    let gender: String?
    let origin, location: CharacterLocation?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
    
    var imagePath: String {
        image ?? ""
    }
    
    var titleText: String {
        name ?? ""
    }
}

struct CharacterLocation: Codable {
    let name: String?
    let url: String?
}


struct CharactersResponse: Codable {
    let info: Info?
    let results: [Character]?
}
