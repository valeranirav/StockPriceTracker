//
//  StockSymbolModel.swift
//  StockPriceTracker
//
//  Created by Nirav Valera on 19/11/2025.
//
import Foundation

final class StockSymbolModel: Identifiable, Hashable, ObservableObject {
    let id = UUID()
    let tickerSymbol: String
    var price: Double
    var description: String

    init(symbol: String, price: Double, description: String = "A sample description for the symbol.") {
        self.tickerSymbol = symbol
        self.price = price
        self.description = description
    }

    static func == (lhs: StockSymbolModel, rhs: StockSymbolModel) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
