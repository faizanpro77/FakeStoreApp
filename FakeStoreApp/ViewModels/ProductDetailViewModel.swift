

import Foundation

import SwiftUI

import SwiftUI

class ProductDetailViewModel: ObservableObject {
    @Published var product: Product
    @Published var isInCart: Bool = false  // Default value
    
    private let listViewModel: ProductListViewModel
    
    init(product: Product, listViewModel: ProductListViewModel) {
        self.product = product
        self.listViewModel = listViewModel
        Task { @MainActor in
            self.isInCart = listViewModel.isInCart(product: product)
        }
    }
    
    @MainActor
    func toggleCartStatus() {
        if isInCart {
            listViewModel.removeFromCart(product: product)
        } else {
            listViewModel.addToCart(product: product)
        }
        isInCart.toggle()
    }
}
