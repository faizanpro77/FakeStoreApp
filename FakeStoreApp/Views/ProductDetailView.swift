//
//  ProductDetailView.swift
//  FakeStoreApp
//
//  Created by shaikh faizan on 13/04/25.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @StateObject var viewModel: ProductDetailViewModel
    
    init(product: Product, viewModel: ProductListViewModel) {
        self.product = product
        _viewModel = StateObject(wrappedValue: ProductDetailViewModel(product: product, listViewModel: viewModel))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Product Image
                AsyncImage(url: URL(string: product.image)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .background(Color(.systemGray6))
                
                // Product Info
                VStack(alignment: .leading, spacing: 8) {
                    Text(product.title)
                        .font(.title2)
                        .bold()
                    
                    HStack(spacing: 12) {
                        RatingItem(icon: "star.fill", text: "4.8", subText: "\(product.rating.count) reviews", iconColor: Color.green)
                               RatingItem(icon: "hand.thumbsup.fill", text: "\(Int(product.rating.rate * 20))%", subText: nil, iconColor: Color(#colorLiteral(red: 0.8, green: 1, blue: 0, alpha: 1)))
                               RatingItem(icon: "message.fill", text: "8", subText: nil, iconColor: .gray)
                           }
                    
                    Text("£\(product.price, specifier: "%.2f")")
                        .font(.title)
                        .bold()
                    
                    Text("from £15 per month")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text(product.description)
                        .font(.body)
                    
                    Button("Read more") {
                        // Expand description
                    }
                    .foregroundColor(.blue)
                }
                .padding()
                
                Spacer()
                
                // Add to Cart Button
                Button(action: {
                    viewModel.toggleCartStatus()
                }) {
                    HStack {
                        Image(systemName: viewModel.isInCart ? "checkmark" : "cart")
                        Text(viewModel.isInCart ? "Added to Cart" : "Add to Cart")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isInCart ? Color.green : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()
                
                Text("Delivery on 30 October")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .navigationTitle(product.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RatingItem: View {
    var icon: String
    var text: String
    var subText: String?
    var iconColor: Color

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .foregroundColor(iconColor)
                .font(.system(size: 14, weight: .semibold))

                Text(text)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)

                if let sub = subText {
                    Text(sub)
                        .font(.system(size: 10))
                        .foregroundColor(.gray)
                }
            
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 10)
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
    }
}


// MARK: - Preview
struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let mockProduct = Product(
            id: 1,
            title: "Nintendo Switch, Gray",
            price: 299.99,
            description: "The Nintendo Switch gaming console is a compact device that can be taken everywhere. This portable super device is also equipped with 2 gemepods.",
            category: "electronics",
            image: "https://fakestoreapi.com/img/71kWymZ+c+L._AC_SX679_.jpg",
            rating: Product.Rating(rate: 4.8, count: 94)
        )
        
        let mockListViewModel = ProductListViewModel()
        
        return ProductDetailView(
            product: mockProduct,
            viewModel: mockListViewModel
        )
    }
}
