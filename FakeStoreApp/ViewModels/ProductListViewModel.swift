import Foundation
import SwiftUI

@MainActor  // Make the whole class main-actor isolated
class ProductListViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    @Published var cartItems: [CartItem] = [] {
        didSet {
            // No need to call updateCartCount() since cartCount is now computed
        }
    }
    
    private let apiService = APIService.shared
    
    // Computed property is always up-to-date
    var cartCount: Int {
        cartItems.reduce(0) { $0 + $1.quantity }
    }
    
    func fetchProducts() async {
        isLoading = true
        errorMessage = nil
        
        do {
            // Perform async work
            let fetchedProducts = try await apiService.fetchProducts()
            
            // Update on main actor
            self.products = fetchedProducts
            
            if products.count % 2 != 0 {
                // Add placeholder logic if needed
            }
        } catch {
            errorMessage = "Failed to fetch products: \(error.localizedDescription)"
            print(error)
        }
        
        isLoading = false
    }
    
    func addToCart(product: Product) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems[index].quantity += 1
        } else {
            cartItems.append(CartItem(product: product, quantity: 1))
        }
    }
    
    func removeFromCart(product: Product) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            if cartItems[index].quantity > 1 {
                cartItems[index].quantity -= 1
            } else {
                cartItems.remove(at: index)
            }
        }
    }
    
    func isInCart(product: Product) -> Bool {
        cartItems.contains(where: { $0.product.id == product.id })
    }
    
    func timeString(time: Int) -> String {
        let hours = time / 3600
        let minutes = (time % 3600) / 60
        let seconds = time % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
