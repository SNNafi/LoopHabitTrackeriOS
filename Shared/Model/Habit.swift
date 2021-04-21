//
//  Habit.swift
//  Loop Habit Tracker
//
//  Created by Shahriar Nasim Nafi on 20/4/21.
//

import SwiftUI

struct Habit {
    var color: Color = .orange
    var description: String = ""
    var frequency: Frequency = Frequency.DAILY
    var id: Int? = nil
    var isArchived: Bool = false
    var name: String = ""
    var position: Int = 0
    var question: String = ""
    var reminder: Date? = nil
    var targetType: TargetType = .atLeast
    var targetValue: Double = 0.0
    var habitType: HabitType = .yesNoHabit
    var unit: String = ""
    var uuid = UUID()
}


enum HabitType: Int {
    case numberHabit
    case yesNoHabit
}

enum TargetType: Int {
    case atLeast
    case atMost
}


//var color: PaletteColor = PaletteColor(8),
//  var description: String = "",
//  var frequency: Frequency = Frequency.DAILY,
//  var id: Long? = null,
//  var isArchived: Boolean = false,
//  var name: String = "",
//  var position: Int = 0,
//  var question: String = "",
//  var reminder: Reminder? = null,
//  var targetType: Int = AT_LEAST,
//  var targetValue: Double = 0.0,
//  var type: Int = YES_NO_HABIT,
//  var unit: String = "",
//  var uuid: String? = null,
//  val computedEntries: EntryList,
//  val originalEntries: EntryList,
//  val scores: ScoreList,
//  val streaks: StreakList,
