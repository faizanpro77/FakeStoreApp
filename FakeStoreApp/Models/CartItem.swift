//
//  CartItem.swift
//  FakeStoreApp
//
//  Created by shaikh faizan on 12/04/25.
//

import Foundation

struct CartItem: Identifiable {
    let id = UUID()
    let product: Product
    var quantity: Int
}
