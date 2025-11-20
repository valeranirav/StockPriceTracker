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
    
    // Incoming messages publisher
    private let privateIncoming = PassthroughSubject<StockUpdateModel, Never>()

    // Protocol-exposed publishers
    var incomingPublisher: AnyPublisher<StockUpdateModel, Never> { privateIncoming.eraseToAnyPublisher() }

    private init() {
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }

    func connect() {
        guard webSocketTask == nil else { return }
        webSocketTask = session.webSocketTask(with: url)
        listen()
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
    
    func send(update: StockUpdateModel) {
        guard let task = webSocketTask else { return }
        do {
            let data = try JSONEncoder().encode(update)
            let str = String(data: data, encoding: .utf8) ?? "{}"
            let message = URLSessionWebSocketTask.Message.string(str)
            task.send(message) { [weak self] error in
                if let err = error {
                    print("WebSocket send error:", err)
                    DispatchQueue.main.async {
                        self?.isConnected = false
                    }
                }
            }
        } catch {
            print("Encode error", error)
        }
    }

    private func listen() {
        webSocketTask?.receive { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let err):
                print("WebSocket receive error", err)
                DispatchQueue.main.async {
                    self.isConnected = false
                }
            case .success(let message):
                switch message {
                case .string(let text):
                    if let data = text.data(using: .utf8) {
                        if let update = try? JSONDecoder().decode(StockUpdateModel.self, from: data) {
                            DispatchQueue.main.async {
                                self.privateIncoming.send(update)
                            }
                        }
                    }
                default: break
                }
                // continue listening
                self.listen()
            }
        }
    }
}
