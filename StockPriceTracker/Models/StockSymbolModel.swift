//
//  StockSymbolModel.swift
//  StockPriceTracker
//
//  Created by Nirav Valera on 19/11/2025.
//
import Foundation

struct StockUpdateModel: Codable {
    let symbol: String
    let price: Double
    let ts: String
}

final class StockSymbolModel: Identifiable, Hashable, ObservableObject {
    let id = UUID()
    let tickerSymbol: String
    @Published var price: Double
    @Published var previousPrice: Double?
    @Published var priceArrow: PriceArrow = .none
    var description: String

    enum PriceArrow: String, Codable {
        case up, down, none
    }
    
    init(symbol: String, price: Double, description: String = "A sample description for the symbol.") {
        self.tickerSymbol = symbol
        self.price = price
        self.description = description
    }

    static func == (lhs: StockSymbolModel, rhs: StockSymbolModel) -> Bool {
        lhs.id == rhs.id &&
        lhs.price == rhs.price
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
