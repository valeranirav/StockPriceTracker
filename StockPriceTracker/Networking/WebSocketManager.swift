//
//  WebSocketManager.swift
//  StockPriceTracker
//
//  Created by Nirav Valera on 19/11/2025.
//

import Foundation
import Combine

final class WebSocketManager: ObservableObject, WebSocketProtocol {
    static let shared = WebSocketManager()

    @Published private(set) var isConnected: Bool = false
    
    private var webSocketTask: URLSessionWebSocketTask?
    private let url = URL(string: "wss://ws.postman-echo.com/raw")!
    private let session: URLSession

    private init() {
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }

    func connect() {
        guard webSocketTask == nil else { return }
        webSocketTask = session.webSocketTask(with: url)
        webSocketTask?.resume()
        
        DispatchQueue.main.async { [weak self] in
            self?.isConnected = true
        }
    }

    func disconnect() {
        DispatchQueue.main.async { [weak self] in
            self?.isConnected = false
        }
        
        webSocketTask?.cancel(with: .goingAway, reason: nil)
        webSocketTask = nil
    }
}
