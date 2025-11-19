//
//  StockListViewModel.swift
//  StockPriceTracker
//
//  Created by Nirav Valera on 19/11/2025.
//

import Foundation

final class StockListViewModel: ObservableObject {
    @Published private(set) var tickerSymbols: [StockSymbolModel] = []
   
    init() {
        setupSymbols()
    }

    private func setupSymbols() {
        let tickers = ["AAPL","GOOG","TSLA","AMZN","MSFT","NVDA","FB","NFLX","INTC","AMD","BABA","ORCL","CRM","UBER","LYFT","SQ","PYPL","SHOP","ADBE","SAP","SONY","TWTR","ZM","SNAP","ATVI"]
        tickerSymbols = tickers.map { StockSymbolModel(symbol: $0, price: Double.random(in: 50...500)) }
        sortSymbols()
    }

    private func sortSymbols() {
        tickerSymbols.sort { $0.price > $1.price }
    }
}
