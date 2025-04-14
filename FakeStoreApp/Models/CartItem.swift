//
//  CartItem.swift
//  FakeStoreApp
//
//  Created by shaikh faizan on 12/04/25.
//

import Foundation

struct CartItem: Identifiable, Equatable {
    let id = UUID()
    let product: Product
    var quantity: Int
    
    // Implement Equatable conformance
    static func == (lhs: CartItem, rhs: CartItem) -> Bool {
        return lhs.id == rhs.id &&
               lhs.product.id == rhs.product.id &&
               lhs.quantity == rhs.quantity
    }
}
