//
//  RatingView.swift
//  FakeStoreApp
//
//  Created by shaikh faizan on 13/04/25.
//

import SwiftUI

struct RatingView: View {
    let rating: Double
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(1..<6) { index in
                Image(systemName: index <= Int(rating) ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                    .font(.system(size: 12))
            }
        }
    }
}


// MARK: - Preview
struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RatingView(rating: 3.5)
                .previewDisplayName("3.5 Stars")
            RatingView(rating: 5.0)
                .previewDisplayName("5 Stars")
            RatingView(rating: 1.0)
                .previewDisplayName("1 Star")
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
