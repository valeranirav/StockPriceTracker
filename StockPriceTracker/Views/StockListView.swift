//
//  StockListView.swift
//  StockPriceTracker
//
//  Created by Nirav Valera on 19/11/2025.
//

import SwiftUI

struct StockListView: View {
    @State private var tickerSymbols: [StockSymbolModel] = [StockSymbolModel(symbol: "AAPL", price: 124.56),
                                                            StockSymbolModel(symbol: "GOOG", price: 124.56),
                                                            StockSymbolModel(symbol: "AMZN", price: 124.56),
                                                            StockSymbolModel(symbol: "NVDA", price: 124.56)]
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                ForEach(tickerSymbols) { tickerSymbol in
                    NavigationLink(value: tickerSymbol) {
                        StockListRowView(symbolModel: tickerSymbol)
                            .padding(.vertical, 8)
                    }
                    Divider()
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("Stocks")
    }
}

#Preview {
    StockListView()
}
