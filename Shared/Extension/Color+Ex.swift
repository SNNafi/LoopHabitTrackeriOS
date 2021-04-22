//
//  Color+Ex.swift
//  LoopHabitTracker
//
//  Created by Shahriar Nasim Nafi on 23/4/21.
//

import SwiftUI

extension Color {
    init(rgba: Int, opacity: Double = 1.0) {
        self.init(
            red: (rgba >> 16) & 0xFF,
            green: (rgba >> 8) & 0xFF,
            blue: rgba & 0xFF,
            opacity: opacity
        )
    }    
    init(red: Int, green: Int, blue: Int, opacity: Double) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: Double(red) / 255.0, green: Double(green) / 255.0, blue: Double(blue) / 255.0, opacity: opacity)
    }
}
