//
//  StockListViewModelTests.swift
//  StockPriceTrackerTests
//
//  Created by Nirav Valera on 20/11/2025.
//

import Testing
import Combine
@testable import StockPriceTracker

struct StockListViewModelTests {
    @Test
    func initializationLoadsSymbols() {
        let mock = WebSocketManagerMock()
        let vm = StockListViewModel(webSocketManager: mock)
        
        #expect(vm.tickerSymbols.count == 25)
    }
    
    @Test
    func startConnectsWebSocket() {
        let mock = WebSocketManagerMock()
        let vm = StockListViewModel(webSocketManager: mock)
        
        vm.start()
        
        #expect(mock.connectCalledCount == 1)
        #expect(vm.isRunning == true)
    }
    
    @Test
    func stopDisconnectsWebSocket() {
        let mock = WebSocketManagerMock()
        let vm = StockListViewModel(webSocketManager: mock)
        
        vm.start()
        vm.stop()
        
        #expect(mock.disconnectCalledCount == 1)
        #expect(vm.isRunning == false)
    }
    
    @Test
    func applyUpdateChangesPriceAndArrow() async throws {
        let mock = WebSocketManagerMock()
        let vm = StockListViewModel(webSocketManager: mock)
        
        let symbol = vm.tickerSymbols.first!
        let oldPrice = symbol.price
        
        let update = StockUpdateModel(
            symbol: symbol.tickerSymbol,
            price: oldPrice + 20,
            ts: "2025-11-19"
        )
        
        mock.simulateUpdate(update)
        
        try await Task.sleep(for: .milliseconds(150))
        
        #expect(symbol.price == oldPrice + 20)
        #expect(symbol.previousPrice == oldPrice)
        #expect(symbol.priceArrow == .up)
    }
    
    @Test
    func applyUpdateArrowResetsAfter1Second() async throws {
        let mock = WebSocketManagerMock()
        let vm = StockListViewModel(webSocketManager: mock)
        
        let symbol = vm.tickerSymbols.first!
        let newPrice = symbol.price + 10
        
        mock.simulateUpdate(.init(symbol: symbol.tickerSymbol, price: newPrice, ts: ""))
        
        try await Task.sleep(for: .milliseconds(1200))
        
        #expect(symbol.priceArrow == .none)
    }
    
    @Test
    func sortingAfterUpdateWorks() async throws {
        let mock = WebSocketManagerMock()
        let vm = StockListViewModel(webSocketManager: mock)

        // Pick two symbols by identity, not by index
        let symbolA = vm.tickerSymbols[0]
        let symbolB = vm.tickerSymbols[1]

        // Assigning price
        symbolA.price = 100
        symbolB.price = 50

        let update = StockUpdateModel(
            symbol: symbolB.tickerSymbol,
            price: 600,
            ts: ""
        )

        mock.simulateUpdate(update)

        try await Task.sleep(for: .milliseconds(200))

        #expect(symbolB.price == 600)
        #expect(vm.tickerSymbols.first?.tickerSymbol == symbolB.tickerSymbol)
    }
}
