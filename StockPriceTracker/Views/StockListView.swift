//
//  StockListView.swift
//  StockPriceTracker
//
//  Created by Nirav Valera on 19/11/2025.
//

import SwiftUI

struct StockListView: View {
    @EnvironmentObject var stockListViewModel: StockListViewModel
    @EnvironmentObject var webSocketManager: WebSocketManager
    @EnvironmentObject var theme: ThemeManager
    @State private var tickerSymbols: [StockSymbolModel] = []
    
    var body: some View {
        VStack {
            topBar
            
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
        .onAppear() {
            self.tickerSymbols = stockListViewModel.tickerSymbols
        }
        .onChange(of: stockListViewModel.tickerSymbols, initial: false) { oldSymbols, newSymbols  in
            if oldSymbols != newSymbols {
                self.tickerSymbols = newSymbols
            }
        }
    }
    
    private var topBar: some View {
        HStack {
            Text(webSocketManager.isConnected ? "🟢 Connected" : "🔴 Disconnected")
                .font(.subheadline)
                .padding(.leading, 16)
            Spacer()
            Button(action: {
                if stockListViewModel.isRunning {
                    stockListViewModel.stop()
                } else {
                    stockListViewModel.start()
                }
            }) {
                Text(stockListViewModel.isRunning ? "Stop" : "Start")
                    .bold()
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(RoundedRectangle(cornerRadius: 8).stroke())
            }
            .padding(.trailing, 8)
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    StockListView()
}
