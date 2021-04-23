//
//  HabitError.swift
//  LoopHabitTracker
//
//  Created by Shahriar Nasim Nafi on 23/4/21.
//

import Foundation

enum HabitError: Error {
    /// Habit not found
    case notFound
    case duplicateHabit
    case positionOutOfIndex
}
