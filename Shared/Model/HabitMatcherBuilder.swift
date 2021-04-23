//
//  HabitMatcherBuilder.swift
//  LoopHabitTracker
//
//  Created by Shahriar Nasim Nafi on 23/4/21.
//

import Foundation

struct HabitMatcherBuilder {
    var archivedAllowed = false
    var reminderRequired = false
    var completedAllowed = true
    
    func build() -> HabitMatcher {
        HabitMatcher(isArchivedAllowed: archivedAllowed,
                     isReminderRequired: reminderRequired,
                     isCompletedAllowed: completedAllowed)
    }
    
}

