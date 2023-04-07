//
//  NetworkHelper.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 7.04.2023.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case parseError
    case unknownError(Error)
}

struct APIError: Decodable, Error {
    let statusCode: Int?
    let reason: String?
    let message: String?
}

class NetworkHelper {
    static let shared = NetworkHelper()
    
    private let baseURL = "https://rickandmortyapi.com/api/"
    
    func requestURL(endPoint: String) -> String {
        baseURL + endPoint
    }
}
