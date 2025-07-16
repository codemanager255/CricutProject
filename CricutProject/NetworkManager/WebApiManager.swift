//
//  WebApiManager.swift
//  CricutProject
//
//  Created by Arpit Mallick on 6/17/25.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case badURL
    case invalidResponse
    case decodingError
    case other(String)
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "The URL provided is invalid"
        case .invalidResponse:
            return "The server response was invalid"
        case .decodingError:
            return "Failed to decode the data"
        case .other(let message):
            return message
        }
    }
}

protocol NetworkService {
    func fetchData<T: Decodable>(from urlString: String) async throws -> T
}

struct WebApiManager: NetworkService {
    func fetchData<T>(from urlString: String) async throws -> T where T : Decodable {
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}
