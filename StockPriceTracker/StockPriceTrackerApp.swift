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
    @StateObject private var webSocketManager = WebSocketManager.shared
    @StateObject private var stockListViewModel = StockListViewModel(webSocketManager: WebSocketManager.shared)
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                StockListView()
                    .environmentObject(stockListViewModel)
                    .environmentObject(webSocketManager)
                    .environmentObject(ThemeManager())
                    .onOpenURL { url in
                        
                        guard url.scheme == "stocks",
                              url.host == "symbol" else { return }
                        
                        let symbol = url.lastPathComponent.uppercased()
                        
                        if let s = stockListViewModel.tickerSymbols.first(where: { $0.tickerSymbol == symbol }) {
                            path.append(s)
                        } else {
                            let placeholder = StockSymbolModel(symbol: symbol, price: 0)
                            path.append(placeholder)
                        }
                    }
                    .navigationDestination(for: StockSymbolModel.self) { symbol in
                        StockDetailsView(model: symbol)
                            .environmentObject(ThemeManager())
                    }
            }
        }
    }
}
