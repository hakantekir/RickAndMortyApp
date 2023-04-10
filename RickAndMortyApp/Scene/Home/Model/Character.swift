//
//  Character.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 7.04.2023.
//

import Foundation

struct Character: Codable, CharacterCellProtocol {
    let id: Int?
    let name, species, type: String?
    let origin, location: CharacterLocation?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
        
    var status: Status?
    var gender: Gender?
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

enum Gender: String, Codable {
    case unknown = "unknown"
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
}

struct CharacterLocation: Codable {
    let name: String?
    let url: String?
}


struct CharactersResponse: Codable {
    let info: Info?
    let results: [Character]?
}
