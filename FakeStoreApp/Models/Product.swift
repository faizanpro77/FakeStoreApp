//
//  Product.swift
//  FakeStoreApp
//
//  Created by shaikh faizan on 12/04/25.
//

import Foundation

struct Product: Codable, Identifiable, Equatable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
    
    struct Rating: Codable, Equatable {
        let rate: Double
        let count: Int
    }
    
    // Implement Equatable conformance (not strictly needed since all properties are Equatable)
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}
