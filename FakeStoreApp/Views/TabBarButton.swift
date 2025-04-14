//
//  TabBarButton.swift
//  FakeStoreApp
//
//  Created by shaikh faizan on 13/04/25.
//

import SwiftUI

struct TabBarButton: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? .blue : .gray)
                
                Text(title)
                    .font(.caption)
                    .foregroundColor(isSelected ? .blue : .gray)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct TabBarButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TabBarButton(icon: "house", title: "Home", isSelected: true, action: {})
                .previewDisplayName("Selected")
            TabBarButton(icon: "cart", title: "Cart", isSelected: false, action: {})
                .previewDisplayName("Not Selected")
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
