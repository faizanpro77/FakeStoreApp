import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    @EnvironmentObject var viewModel: ProductListViewModel
    
    var body: some View {
        HStack {
            ForEach(0..<5) { index in
                Button(action: {
                    selectedTab = index
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: iconForTab(index))
                            .font(.system(size: 22))
                            .frame(height: 24)
                        
                        Text(titleForTab(index))
                            .font(.system(size: 12, weight: .semibold))
                    }
                    .foregroundColor(selectedTab == index ? .blue : .gray)
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(Color.white)
        .clipShape(Capsule())
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -2)
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
    
    private func iconForTab(_ index: Int) -> String {
        switch index {
        case 0: return "house.fill"
        case 1: return "square.grid.2x2.fill"
        case 2: return "cart.fill"
        case 3: return "heart.fill"
        case 4: return "person.fill"
        default: return "circle.fill"
        }
    }
    
    private func titleForTab(_ index: Int) -> String {
        switch index {
        case 0: return "Home"
        case 1: return "Catalog"
        case 2: return "Cart"
        case 3: return "Favorites"
        case 4: return "Profile"
        default: return ""
        }
    }
}

// MARK: - Preview
struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample product first
        let sampleProduct = Product(
            id: 1,
            title: "iPhone 15 Pro",
            price: 999.99,
            description: "Sample product",
            category: "electronics",
            image: "",
            rating: Product.Rating(rate: 4.5, count: 100)
        )
        
        // Create mock view model
        let mockViewModel = ProductListViewModel()
        mockViewModel.cartItems = [
            CartItem(product: sampleProduct, quantity: 2)
        ]
        
        return Group {
            // Preview with Home selected
            CustomTabBar(selectedTab: .constant(0))
                .environmentObject(mockViewModel)
                .previewDisplayName("Home Selected")
                .previewLayout(.sizeThatFits)
            
            // Preview with Cart selected
            CustomTabBar(selectedTab: .constant(2))
                .environmentObject(mockViewModel)
                .previewDisplayName("Cart Selected")
                .previewLayout(.sizeThatFits)
            
            // Dark mode preview
            CustomTabBar(selectedTab: .constant(1))
                .environmentObject(mockViewModel)
                .previewDisplayName("Dark Mode")
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
        .padding()
        .background(Color(.systemBackground))
    }
}
