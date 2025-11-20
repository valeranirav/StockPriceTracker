//
//  StockDetailsView.swift
//  StockPriceTracker
//
//  Created by Nirav Valera on 19/11/2025.
//

import SwiftUI

struct StockDetailsView: View {
    @ObservedObject var symbolModel: StockSymbolModel

    init(model: StockSymbolModel) {
        self.symbolModel = model
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                tickerSymbolView
                priceView
                descriptionView
                Spacer()
            }
            .padding()
            .navigationTitle(symbolModel.tickerSymbol)
        }
    }
    
    var tickerSymbolView: some View {
        Text(symbolModel.tickerSymbol)
            .font(.largeTitle)
            .bold()
    }
    
    var priceView: some View {
        HStack(spacing: 12) {
            Text(String(format: "%.2f", symbolModel.price))
                .font(.title)
                .bold()
                .modifier(FlashModifier(flash: symbolModel.priceArrow))
            if let prev = symbolModel.previousPrice {
                if symbolModel.price > prev {
                    Text("↑")
                        .foregroundColor(.green)
                } else if symbolModel.price < prev {
                    Text("↓")
                        .foregroundColor(.red)
                } else {
                    Text("—")
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    var descriptionView: some View {
        Text(symbolModel.description)
            .padding()
            .multilineTextAlignment(.center)
    }
}

#Preview {
    StockDetailsView(model: StockSymbolModel(symbol: "AAPL", price: 123.23))
}
