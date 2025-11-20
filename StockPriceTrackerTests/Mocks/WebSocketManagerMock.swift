//
//  WebSocketManagerMock.swift
//  StockPriceTrackerTests
//
//  Created by Nirav Valera on 20/11/2025.
//

import Combine
import Foundation
@testable import StockPriceTracker

final class WebSocketManagerMock: WebSocketProtocol {
    let incomingSubject = PassthroughSubject<StockUpdateModel, Never>()
    var incomingPublisher: AnyPublisher<StockUpdateModel, Never> {
        return incomingSubject.eraseToAnyPublisher()
    }
    
    // Tracking variables to verify calls
    var connectCalledCount = 0
    var disconnectCalledCount = 0
    var sendCalledCount = 0
    var sentUpdates: [StockUpdateModel] = []
    
    func connect() {
        connectCalledCount += 1
    }
    
    func disconnect() {
        disconnectCalledCount += 1
    }
    
    func send(update: StockUpdateModel) {
        sendCalledCount += 1
        sentUpdates.append(update)
    }
    
    // Helper function to send mock data
    func simulateUpdate(_ update: StockUpdateModel) {
        self.incomingSubject.send(update)
    }
}
