import SwiftUI

struct ProductListView: View {
    @StateObject private var viewModel = ProductListViewModel()
    @State private var selectedTab: Int = 0
    @State private var timeRemaining = 2 * 3600 + 50 * 60 + 21
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 0) {
            // Main content area (changes based on selected tab)
            Group {
                switch selectedTab {
                case 0:
                    homeTabContent
                case 2:
                    CartView(cartItems: $viewModel.cartItems)
                default:
                    placeholderTabView(for: selectedTab)
                }
            }
            .frame(maxHeight: .infinity)
            
            // Single instance of custom tab bar
            CustomTabBar(selectedTab: $selectedTab)
        }
        .navigationBarHidden(true)
        .task {
            await viewModel.fetchProducts()
        }
    }
    
    // MARK: - Tab Content Views
    
    private var homeTabContent: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header
                headerView
                
                // Search Bar
                searchBarView
                
                // Delivery Note
                deliveryNoteView
                
                // Categories Section
                categoriesView
                
                // Flash Sale Section
                flashSaleView
                
                // Products Grid
                productsGridView
            }
        }
    }
    
    private func placeholderTabView(for tab: Int) -> some View {
        VStack {
            Spacer()
            Text("\(tabName(for: tab)) Content")
                .font(.title)
            Spacer()
        }
    }
    
    // MARK: - Subviews
    
    private var headerView: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(Color(#colorLiteral(red: 0.8, green: 1, blue: 0, alpha: 1)))
                    .frame(width: 55, height: 55)
                
                Image(systemName: "checkmark.seal.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            VStack(alignment: .center) {
                Text("Delivery address")
                    .font(.caption2)
                    .foregroundColor(.gray)
                
                Text("92 High Street, London")
                    .font(.subheadline)
                    .bold()
            }
            
            Spacer()
            
                Image(systemName: "cart")
                    .overlay(
                        Text("\(viewModel.cartCount)")
                            .font(.caption2)
                            .padding(4)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .offset(x: 10, y: -10)
                    )
        }
        .padding()
    }
    
    private var searchBarView: some View {
        HStack {
            Spacer()
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                Text("Search the entire shop")
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 15)
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .padding(.horizontal)
    }
    
    private var deliveryNoteView: some View {
        HStack(spacing: 4) {
            Text("Delivery is")
                .font(.subheadline)
                .bold()
                .foregroundColor(.black)
            
            Text("50%")
                .font(.subheadline)
                .bold()
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(Color.white)
                .cornerRadius(4)
                .foregroundColor(.black)
            
            Text("cheaper")
                .font(.subheadline)
                .foregroundColor(.black)
            
            Spacer()
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .opacity(0.7)
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.teal.opacity(0.3), Color.teal]),
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .cornerRadius(20)
        .padding(.horizontal)
        .padding(.top)
    }
    
    private var categoriesView: some View {
        VStack {
            HStack {
                Text("Categories")
                    .font(.system(size: 28))
                    .bold()
                Spacer()
                Text("See all")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Image(systemName: "chevron.right")
                    .foregroundColor(.black)
                    .frame(width: 30, height: 30)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    CategoryButton(title: "Phones", icon: "iphone")
                    CategoryButton(title: "Consoles", icon: "gamecontroller")
                    CategoryButton(title: "Laptops", icon: "laptopcomputer")
                    CategoryButton(title: "Careers", icon: "headphones")
                    CategoryButton(title: "Watches", icon: "applewatch")
                    CategoryButton(title: "Cameras", icon: "camera")
                    CategoryButton(title: "Tablets", icon: "ipad")
                    CategoryButton(title: "TVs", icon: "tv")
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var flashSaleView: some View {
        HStack {
            Text("Flash Sale")
                .font(.system(size: 28))
                .fontWeight(.bold)
            
            Text(viewModel.timeString(time: timeRemaining))
                .font(.system(size: 16, design: .monospaced))
                .foregroundColor(.black)
                .padding(.horizontal, 12)
                .padding(.vertical, 5)
                .background(Color(red: 0.78, green: 1.0, blue: 0.0))
                .cornerRadius(8)
            Spacer()
            
            Button(action: { print("See all tapped") }) {
                Text("See all")
                    .foregroundColor(.gray)
            }
            
            Image(systemName: "chevron.right")
                .foregroundColor(.black)
                .frame(width: 30, height: 30)
                .background(Color.gray.opacity(0.2))
                .clipShape(Circle())
        }
        .padding()
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
    }
    
    private var productsGridView: some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible())], spacing: 16) {
            ForEach(viewModel.products) { product in
                NavigationLink(destination: ProductDetailView(product: product, viewModel: viewModel)) {
                    ProductGridItemView(product: product)
                }
            }
        }
        .padding()
    }
    
    // MARK: - Helper Functions
    
    private func tabName(for index: Int) -> String {
        switch index {
        case 0: return "Home"
        case 1: return "Catalog"
        case 2: return "Cart"
        case 3: return "Favorites"
        case 4: return "Profile"
        default: return "Unknown"
        }
    }
}

// MARK: - Supporting Views

struct CategoryButton: View {
    let title: String
    let icon: String
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.1))
                    .frame(width: 65, height: 65)
                
                Image(systemName: icon)
                    .foregroundColor(.black)
                    .font(.system(size: 24))
            }
            
            Text(title)
                .font(.caption)
        }
    }
}

// MARK: - Preview

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        let mockViewModel = ProductListViewModel()
        mockViewModel.products = [
            Product(
                id: 1,
                title: "iPhone 15 Pro",
                price: 999.99,
                description: "Latest iPhone model",
                category: "electronics",
                image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
                rating: Product.Rating(rate: 4.8, count: 120)
            ),
            Product(
                id: 2,
                title: "Samsung Galaxy Buds Pro",
                price: 199.99,
                description: "Wireless earbuds",
                category: "electronics",
                image: "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                rating: Product.Rating(rate: 4.5, count: 89)
            )
        ]
        
        return NavigationView {
            ProductListView()
                .environmentObject(mockViewModel)
        }
    }
}
