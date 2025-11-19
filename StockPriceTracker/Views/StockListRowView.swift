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
            
            Text("↑")
                .foregroundColor(.green)
                .font(.caption)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
        }
        .frame(minWidth: 140, alignment: .trailing)
    }
}

#Preview {
    StockListRowView(symbolModel: StockSymbolModel(symbol: "AAPL", price: 123.23))
}
