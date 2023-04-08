//
//  Location.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 8.04.2023.
//

import Foundation

struct Location: Codable, LocationCellProtocol {
    let id: Int?
    let name, type, dimension: String?
    let residents: [String]?
    let url: String?
    let created: String?
    
    var titleText: String {
        name ?? ""
    }
}

struct LocationResponse: Codable {
    let info: Info?
    let results: [Location]?
}
