//
//  StockListViewModel.swift
//  StockPriceTracker
//
//  Created by Nirav Valera on 19/11/2025.
//

import Combine
import Foundation

final class StockListViewModel: ObservableObject {
    @Published private(set) var tickerSymbols: [StockSymbolModel] = []
    @Published var isRunning: Bool = false
    
    private let webSocketManager: WebSocketProtocol
    private var timerCancellable: AnyCancellable?
    private var subscriptions = Set<AnyCancellable>()
    private let updateQueue = DispatchQueue(label: "feed.update.queue", qos: .userInitiated)
    
    init(webSocketManager: WebSocketProtocol) {
        self.webSocketManager = webSocketManager
        setupSymbols()
        bindWebSocket()
    }
    
    func start() {
        guard !isRunning else { return }
        webSocketManager.connect()
        isRunning = true
        
        // Fire every 2 seconds and send updates for every symbol
        timerCancellable = Timer.publish(every: 2.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.sendBatchUpdates()
            }
    }

    func stop() {
        isRunning = false
        timerCancellable?.cancel()
        webSocketManager.disconnect()
    }

    private func setupSymbols() {
        let tickers = ["AAPL","GOOG","TSLA","AMZN","MSFT","NVDA","FB","NFLX","INTC","AMD","BABA","ORCL","CRM","UBER","LYFT","SQ","PYPL","SHOP","ADBE","SAP","SONY","TWTR","ZM","SNAP","ATVI"]
        tickerSymbols = tickers.map { StockSymbolModel(symbol: $0, price: Double.random(in: 50...500)) }
        sortSymbols()
    }
    
    private func bindWebSocket() {
        webSocketManager.incomingPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] update in
                self?.apply(update: update)
            }
            .store(in: &subscriptions)
    }

    private func apply(update: StockUpdateModel) {
        guard let model = tickerSymbols.first(where: { $0.tickerSymbol == update.symbol }) else { return }
        let old = model.price
        model.previousPrice = old
        model.price = update.price
        if update.price > (old) {
            model.priceArrow = .up
        } else if update.price < (old) {
            model.priceArrow = .down
        } else {
            model.priceArrow = .none
        }
        // reset flash after 1s
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            model.priceArrow = .none
        }
        sortSymbols()
    }

    private func sortSymbols() {
        tickerSymbols.sort { $0.price > $1.price }
    }
    
    private func sendBatchUpdates() {
        updateQueue.async { [weak self] in
            guard let self = self else { return }
            for symbol in self.tickerSymbols {
                let delta = Double.random(in: -3...3)
                let newPrice = max(0.01, (symbol.price + delta))
                let update = StockUpdateModel(symbol: symbol.tickerSymbol, price: newPrice, ts: ISO8601DateFormatter().string(from: Date()))
                self.webSocketManager.send(update: update)                
            }
        }
    }
}
