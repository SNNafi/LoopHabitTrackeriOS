//
//  HabitError.swift
//  LoopHabitTracker
//
//  Created by Shahriar Nasim Nafi on 23/4/21.
//

import Foundation

enum HabitError: Error {
    
    case notFound
    case duplicateHabit
    case positionOutOfIndex
    case csvWritingFailed
    
    var localizedDescription: String {
        switch self {
        case .notFound:
            return "The habit is not found"
        case .duplicateHabit:
            return "Habit already exist. Try to add a different one"
        case .positionOutOfIndex:
            return "This position does not exist. Out of the index"
        case .csvWritingFailed:
            return "CSV writing failed"
        
        }
    }
}
