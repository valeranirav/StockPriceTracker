//
//  FlashModifier.swift
//  StockPriceTracker
//
//  Created by Nirav Valera on 20/11/2025.
//

import SwiftUI

struct FlashModifier: ViewModifier {
    let flash: StockSymbolModel.PriceArrow
    func body(content: Content) -> some View {
        switch flash {
        case .up:
            return content.foregroundColor(.green)
        case .down:
            return content.foregroundColor(.red)
        case .none:
            return content.foregroundColor(.primary)
        }
    }
}
