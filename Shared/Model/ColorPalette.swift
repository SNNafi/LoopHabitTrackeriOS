//
//  ColorPalette.swift
//  LoopHabitTracker
//
//  Created by Shahriar Nasim Nafi on 23/4/21.
//

import SwiftUI

enum ColorPalette {
    case red
    case deepOrange
    case orange
    case amber
    case yellow
    case lime
    case lightGreen
    case green
    case teal
    case cyan
    case lightBlue
    case blue
    case indigo
    case deepPurple
    case purple
    case pink
    case brown
    case darkGrey
    case grey
    case lightGrey
    
    var color: Color {
        switch self {
        case .red:
            return Color(rgba: 0xD32F2F)
        case .deepOrange:
            return Color(rgba: 0xE64A19)
        case .orange:
            return Color(rgba: 0xF57C00)
        case .amber:
            return Color(rgba: 0xFF8F00)
        case .yellow:
            return Color(rgba: 0xF9A825)
        case .lime:
            return Color(rgba: 0xAFB42B)
        case .lightGreen:
            return Color(rgba: 0x7CB342)
        case .green:
            return Color(rgba: 0x388E3C)
        case .teal:
            return Color(rgba: 0x00897B)
        case .cyan:
            return Color(rgba: 0x00ACC1)
        case .lightBlue:
            return Color(rgba: 0x039BE5)
        case .blue:
            return Color(rgba: 0x1976D2)
        case .indigo:
            return Color(rgba: 0x303F9F)
        case .deepPurple:
            return Color(rgba: 0x5E35B1)
        case .purple:
            return Color(rgba: 0x8E24AA)
        case .pink:
            return Color(rgba: 0xD81B60)
        case .brown:
            return Color(rgba: 0x5D4037)
        case .darkGrey:
            return Color(rgba: 0x303030)
        case .grey:
            return Color(rgba: 0x757575)
        case .lightGrey:
            return Color(rgba: 0xAAAAAA)
        }
    }
}
