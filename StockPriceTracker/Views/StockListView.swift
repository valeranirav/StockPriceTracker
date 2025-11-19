//
//  StockListView.swift
//  StockPriceTracker
//
//  Created by Nirav Valera on 19/11/2025.
//

import SwiftUI

struct StockListView: View {
    @EnvironmentObject var stockListViewModel: StockListViewModel
    @State private var tickerSymbols: [StockSymbolModel] = []
    
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
        .onAppear() {
            self.tickerSymbols = stockListViewModel.tickerSymbols
        }
    }
}

#Preview {
    StockListView()
}
