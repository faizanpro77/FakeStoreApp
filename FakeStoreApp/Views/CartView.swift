//
//  CartView.swift
//  FakeStoreApp
//
//  Created by shaikh faizan on 12/04/25.
//

import SwiftUI

struct CartView: View {
    @Binding var cartItems: [CartItem]
    @StateObject private var viewModel: CartViewModel
    @State private var showingCheckoutAlert = false
    
    init(cartItems: Binding<[CartItem]>) {
        self._cartItems = cartItems
        self._viewModel = StateObject(wrappedValue: CartViewModel(cartItems: cartItems.wrappedValue))
    }
    
    var body: some View {
        VStack {
            // Header
            HStack {
                VStack(alignment: .leading) {
                    Text("9:41")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text("Cart")
                        .font(.title)
                        .bold()
                    
                    Text("92 High Street, London")
                        .font(.subheadline)
                }
                
                Spacer()
            }
            .padding()
            
            // Select All Button
            Button(action: {
                viewModel.toggleSelectAll()
            }) {
                HStack {
                    Image(systemName: viewModel.selectedItems.count == cartItems.count ? "checkmark.square" : "square")
                    Text("Select all")
                    Spacer()
                }
                .foregroundColor(.primary)
            }
            .padding(.horizontal)
            
            // Cart Items List
            List {
                ForEach($cartItems) { $item in
                    HStack {
                        Image(systemName: viewModel.selectedItems.contains(item.id) ? "checkmark.square" : "square")
                            .onTapGesture {
                                if viewModel.selectedItems.contains(item.id) {
                                    viewModel.selectedItems.remove(item.id)
                                } else {
                                    viewModel.selectedItems.insert(item.id)
                                }
                            }
                        
                        AsyncImage(url: URL(string: item.product.image)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 60, height: 60)
                        
                        VStack(alignment: .leading) {
                            Text(item.product.title)
                                .font(.subheadline)
                            Text("£\(item.product.price, specifier: "%.2f")")
                                .font(.subheadline)
                                .bold()
                        }
                        
                        Spacer()
                        
                        Stepper(value: $item.quantity, in: 1...10) {
                            Text("\(item.quantity)")
                        }
                    }
                }
                .onDelete { indices in
                    viewModel.removeItems(at: indices)
                }
            }
            .listStyle(PlainListStyle())
            
            // Checkout Section
            VStack {
                HStack {
                    Text("Total:")
                    Spacer()
                    Text("£\(viewModel.totalPrice, specifier: "%.2f")")
                        .bold()
                }
                .padding()
                
                Button(action: {
                    showingCheckoutAlert = true
                }) {
                    Text("Checkout")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .alert("Thank You", isPresented: $showingCheckoutAlert) {
                    Button("OK", role: .cancel) {
                        // Clear selected items after checkout
                        cartItems.removeAll { viewModel.selectedItems.contains($0.id) }
                        viewModel.selectedItems.removeAll()
                    }
                } message: {
                    Text("Your order has been placed successfully!")
                }
            }
        }
        .onChange(of: cartItems) { newItems in
            viewModel.cartItems = newItems
        }
    }
}

// MARK: - Preview
struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        let mockProduct1 = Product(
            id: 1,
            title: "Network Switch: Use, Yellow",
            price: 100.00,
            description: "Network switch device",
            category: "electronics",
            image: "https://fakestoreapi.com/img/71kWymZ+c+L._AC_SX679_.jpg",
            rating: Product.Rating(rate: 4.5, count: 30)
        )
        
        let mockProduct2 = Product(
            id: 2,
            title: "The Legend of Zebia: Tears of the Kingdom",
            price: 39.00,
            description: "Nintendo Switch game",
            category: "electronics",
            image: "https://fakestoreapi.com/img/71kWymZ+c+L._AC_SX679_.jpg",
            rating: Product.Rating(rate: 4.9, count: 150)
        )
        
        let mockCartItems = [
            CartItem(product: mockProduct1, quantity: 1),
            CartItem(product: mockProduct2, quantity: 1)
        ]
        
        return CartView(cartItems: .constant(mockCartItems))
    }
}
