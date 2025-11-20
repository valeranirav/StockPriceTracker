# 📈 Stock Price Tracker (SwiftUI + WebSocket)

A real-time stock price tracking app built entirely with **SwiftUI**, featuring live WebSocket updates, animated price changes, and deep-link navigation.  
This project demonstrates **MVVM**, **Combine**, **NavigationStack**

---

## 🚀 Features

### 🔴🟢 Real-Time Price Feed
- Tracks **25 stock symbols** (AAPL, GOOG, TSLA, NVDA, AMZN, MSFT, and more)
- Fetches data using a WebSocket echo server:
  ```
  wss://ws.postman-echo.com/raw
  ```
- Every 2 seconds:
  - Random price updates are generated for each symbol
  - The update is sent to the WebSocket server
  - The echoed response is received back
  - UI updates in real time

---

## 📱 Screens

### **1. Stock List Screen**
Displays a scrollable list of 25 stock symbols with:
- Symbol (e.g., AAPL)
- Current price
- Animated price change indicator:
  - 🟢 ↑ (price increased)
  - 🔴 ↓ (price decreased)
- Auto-sorted by price (highest first)
- Tap any symbol to open the details screen

Includes:
- **Connection status indicator** (🟢 Connected / 🔴 Disconnected)
- **Start/Stop WebSocket feed button**

---

### **2. Symbol Detail Screen**
Shows:
- Selected symbol as title
- Current price + arrow indicator
- Basic description

---

## 🏛 Architecture

This project follows **MVVM** design pattern using **Combine**.

Key principles:
- 100% SwiftUI (no UIKit)
- WebSocket manager publishes updates to multiple screens
- Shared state injected using `@EnvironmentObject`
- Zero duplicated WebSocket connections

---

## 🧩 Technologies Used

- **SwiftUI**
- **Combine**
- **NavigationStack**
- **URLSessionWebSocketTask**
- **MVVM Architecture**

---

## 🧪 Bonus Features

- 1-second animated flash:
  - Green when price increases
  - Red when price decreases
- Unit tests using **Swift Testing**
- Light/Dark mode support
- Deep link support:
  ```
  stocks://symbol/AAPL
  ```
  Opens the details screen for the target symbol.

---

## 🔗 Deep Link Support

To open the app directly to a symbol detail screen:

```
stocks://symbol/{SYMBOL}
```

Example:

```
stocks://symbol/TSLA
```

This uses SwiftUI’s `onOpenURL` with `NavigationStack` to route to the right destination.

---

## 📂 Project Structure

```
StockPriceTracker/
 ├── Models/
 │    ├── StockSymbolModel.swift
 │    └── StockUpdateModel.swift
 │
 ├── ViewModels/
 │    └── StockListViewModel.swift
 │
 ├── Networking/
 │    └── WebSocketManager.swift
 │    └── WebSocketProtocol.swift
 │
 ├── Views/
 │    ├── StockListView.swift
 │    └── StockDetailsView.swift
 │    ├── StockListRowView.swift
 │
 ├── Theme/
 │    └── ThemeManager.swift
 │
 ├── StockPriceTrackerApp.swift
 └── README.md
```

---

## 📜 License

MIT License. Free to use and modify.

