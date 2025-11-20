//
//  ThemeManager.swift
//  StockPriceTracker
//
//  Created by Nirav Valera on 20/11/2025.
//

import Foundation
import SwiftUI

final class ThemeManager: ObservableObject {
    @Published var isDark: Bool = false

    func toggle() {
        isDark.toggle()

        let scene = UIApplication.shared.connectedScenes.first
        if let windowScene = scene as? UIWindowScene {
            for window in windowScene.windows {
                window.overrideUserInterfaceStyle = isDark ? .dark : .light
            }
        }
    }
}
