//
//  WebSocketProtocol.swift
//  StockPriceTracker
//
//  Created by Nirav Valera on 19/11/2025.
//

import Foundation
import Combine

protocol WebSocketProtocol: AnyObject {
    func connect()
    func disconnect()
}
