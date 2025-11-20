//
//  WebSocketProtocol.swift
//  StockPriceTracker
//
//  Created by Nirav Valera on 19/11/2025.
//

import Foundation
import Combine

protocol WebSocketProtocol: AnyObject {
    var incomingPublisher: AnyPublisher<StockUpdateModel, Never> { get }
    
    func connect()
    func disconnect()
    func send(update: StockUpdateModel)
}
