//
//  APIService.swift
//  FakeStoreApp
//
//  Created by shaikh faizan on 12/04/25.
//

import Foundation

import Foundation

class APIService {
    static let shared = APIService()
    private let baseURL = "https://fakestoreapi.com"
    
    func fetchProducts() async throws -> [Product] {
        let url = URL(string: "\(baseURL)/products")!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode([Product].self, from: data)
    }
}
