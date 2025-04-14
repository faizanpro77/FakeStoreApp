//
//  FakeStoreAppApp.swift
//  FakeStoreApp
//
//  Created by shaikh faizan on 12/04/25.
//

import SwiftUI

@main
struct FakeStoreAppApp: App {
    @StateObject private var viewModel = ProductListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ProductListView()
                    .environmentObject(viewModel)
            }
            .navigationViewStyle(.stack) // Important for iOS
        }
    }
}
