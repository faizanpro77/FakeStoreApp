//
//  CartViewModel.swift
//  FakeStoreApp
//
//  Created by shaikh faizan on 13/04/25.
//

import Foundation
import SwiftUI

class CartViewModel: ObservableObject {
    @Published var cartItems: [CartItem]
    @Published var selectedItems: Set<UUID> = []
    
    init(cartItems: [CartItem]) {
        self.cartItems = cartItems
    }
    
    var totalPrice: Double {
        cartItems.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
    
    func removeItems(at indices: IndexSet) {
        cartItems.remove(atOffsets: indices)
    }
    
    func toggleSelectAll() {
        if selectedItems.count == cartItems.count {
            selectedItems.removeAll()
        } else {
            selectedItems = Set(cartItems.map { $0.id })
        }
    }
}
