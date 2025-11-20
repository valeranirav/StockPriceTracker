//
//  StockListRowView.swift
//  StockPriceTracker
//
//  Created by Nirav Valera on 19/11/2025.
//

import SwiftUI

struct StockListRowView: View {
    @ObservedObject var symbolModel: StockSymbolModel
    
    var body: some View {
        HStack {
            tickerSymbolView
            Spacer()
            priceView
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(.ultraThinMaterial)
                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        )
    }
    
    var tickerSymbolView: some View {
        Text(symbolModel.tickerSymbol)
            .font(.headline)
            .frame(width: 80, alignment: .leading)
    }
    
    var priceView: some View {
        HStack(spacing: 8) {
            Text(String(format: "%.2f", symbolModel.price))
                .bold()
                .modifier(FlashModifier(flash: symbolModel.priceArrow))
            
            changeIndicator
                .font(.caption)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
        }
        .frame(minWidth: 140, alignment: .trailing)
    }
    
    var changeIndicator: some View {
        Group {
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
            } else {
                Text("—")
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    StockListRowView(symbolModel: StockSymbolModel(symbol: "AAPL", price: 123.23))
}
