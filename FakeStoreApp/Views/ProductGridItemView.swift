//
//  ProductGridItemView.swift
//  FakeStoreApp
//
//  Created by shaikh faizan on 13/04/25.
//

import SwiftUI

struct ProductGridItemView: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: product.image)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
            .frame(height: 120)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            
            Text(product.title)
                .font(.subheadline)
                .lineLimit(1)
                .foregroundStyle(.black)
            
            Text(product.description)
                .font(.caption)
                .foregroundColor(.black)
                .lineLimit(1)
            HStack{
                Text("£\(product.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(.black)
                Text("£789.00")
                    .font(.system(size: 16, design: .monospaced))
                    .foregroundColor(.gray)
                    .strikethrough(true, color: .gray)
            }


            
            HStack {
                RatingView(rating: product.rating.rate)
                Text("\(product.rating.count)")
                    .font(.caption2)
                    .foregroundStyle(.black)
            }
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

// MARK: - Preview
struct ProductGridItemView_Previews: PreviewProvider {
    static var previews: some View {
        let mockProduct = Product(
            id: 1,
            title: "Apple Phone 15 Pro",
            price: 669.00,
            description: "126GB Natural Titanium",
            category: "electronics",
            image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
            rating: Product.Rating(rate: 4.8, count: 120)
        )
        
        return ProductGridItemView(product: mockProduct)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
