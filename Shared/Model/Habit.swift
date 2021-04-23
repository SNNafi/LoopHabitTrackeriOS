//
//  Habit.swift
//  Loop Habit Tracker
//
//  Created by Shahriar Nasim Nafi on 20/4/21.
//

import SwiftUI

struct Habit {
    var color: Color = ColorPalette(rawValue: 8)!.color
    var description: String = ""
    var frequency: Frequency = Frequency.DAILY
    var id: Int? = nil
    var isArchived: Bool = false
    var name: String = ""
    var position: Int = 0
    var question: String = ""
    var reminder: Reminder? = nil
    var targetType: TargetType = .atLeast
    var targetValue: Double = 0.0
    var habitType: HabitType = .yesNoHabit
    var unit: String = ""
    var uuid = UUID()
    var computedEntries: EntryList
    var originalEntries: EntryList
    var scores: ScoreList
    var streaks: StreakList
}


enum HabitType: Int {
    case numberHabit
    case yesNoHabit
}

enum TargetType: Int {
    case atLeast
    case atMost
}

