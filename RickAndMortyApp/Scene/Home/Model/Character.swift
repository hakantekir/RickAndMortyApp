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
    let origin, location: Location?
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

struct Location: Codable {
    let name: String?
    let url: String?
}

struct Info: Codable {
    let count: Int?
    let pages: Int?
    let next: String?
    let prev: String?
}

struct Results: Codable {
    let characters: [Character]?
}

struct CharactersResponse: Codable {
    let info: Info?
    let results: [Character]?
}
