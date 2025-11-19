//
//  StockPriceTrackerApp.swift
//  StockPriceTracker
//
//  Created by Nirav Valera on 19/11/2025.
//

import SwiftUI

@main
struct StockPriceTrackerApp: App {
    @State private var path = NavigationPath()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                StockListView()
                    .navigationDestination(for: StockSymbolModel.self) { symbol in
                        StockDetailsView(model: symbol)
                    }
            }
        }
    }
}
