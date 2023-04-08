//
//  NetworkManager.swift
//  RickAndMortyApp
//
//  Created by Hakan Tekir on 7.04.2023.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func request<T: Codable>(responseType: T.Type,
                             httpMethod: HTTPMethods,
                             url: String,
                             queryItems: [String:String?]? = nil,
                             header: [String:String]? = nil,
                             body: Data? = nil,
                             completion: @escaping((Result<(T), NetworkError>) -> Void)) {
        guard var urlComponents = URLComponents(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        if let queryItems = queryItems {
            urlComponents.queryItems = queryItems.map { URLQueryItem(name: $0, value: $1) }
        }
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        
        print(url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = header
        request.httpBody = body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = URLSession(configuration: .default).dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.unknownError(error)))
            } else {
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.invalidResponse))
                    return
                }
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                if (200...299).contains(httpResponse.statusCode) {
                    do {
                        let result = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.failure(.parseError))
                    }
                } else {
                    completion(.failure(.parseError))
                }
            }
        }
        
        dataTask.resume()
    }
}

