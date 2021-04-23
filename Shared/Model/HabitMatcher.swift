//
//  HabitMatcher.swift
//  LoopHabitTracker
//
//  Created by Shahriar Nasim Nafi on 23/4/21.
//

import Foundation

struct HabitMatcher {
    var isArchivedAllowed: Bool = false
    var isReminderRequired: Bool = false
    var isCompletedAllowed: Bool = true
    
    func matches(habit: Habit) -> Bool {
        if !isArchivedAllowed && habit.isArchived  { return false }
        if isReminderRequired && !habit.hasReminder { return false }
        if !isCompletedAllowed && habit.isCompletedToday { return false }
        return true
    }
    
    static var withAlarm = HabitMatcherBuilder(archivedAllowed: true, reminderRequired: true).build()
        
}
