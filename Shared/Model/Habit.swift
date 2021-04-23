//
//  Habit.swift
//  Loop Habit Tracker
//
//  Created by Shahriar Nasim Nafi on 20/4/21.
//
// inComplete
// Possible work left:
// URI

import SwiftUI

struct Habit {
    var color: ColorPalette = ColorPalette(rawValue: 8)!
    var description: String = ""
    var frequency: Frequency = Frequency.daily
    var id: Int64? = nil
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
    
    var isNumerical: Bool {
        habitType == .numberHabit
    }
    
    var hasReminder: Bool {
        reminder != nil
    }
    
    var uriString: String {
        "\(id)"
    }
    
    var isCompletedToday: Bool {
        let today = Date()
        let value = computedEntries.get(date: today).value
        if isNumerical {
            if targetType == .atLeast {
                return Double(value.rawValue) / 1000.0 >= targetValue
            } else {
                return Double(value.rawValue) / 1000.0 <= targetValue
            }
        } else {
            return value != .no && value != .unknown
        }
    }
    
    mutating func recompute() {
        computedEntries.recomputeFrom(originalEntries: originalEntries, frequency: frequency, isNumerical: isNumerical)
        let to = Date().adding(days: 30)
        let entries = computedEntries.getKnown()
        var from = entries.last?.time ?? to
        if from.isNewer(than: to) { from = to }
        scores.recompute(frequency: frequency, isNumerical: isNumerical, targetValue: targetValue, computedEntries: computedEntries, from: from, to: to)
        streaks.recompute(computedEntries: computedEntries, from: from, to: to)
    }
    
    mutating func copy(from habit: Habit) {
        self.color = habit.color
        self.description = habit.description
        self.frequency = habit.frequency
        self.isArchived = habit.isArchived
        self.name = habit.name
        self.position = habit.position
        self.question = habit.question
        self.reminder = habit.reminder
        self.targetType = habit.targetType
        self.targetValue = habit.targetValue
        self.habitType = habit.habitType
        self.unit = habit.unit
        self.uuid = habit.uuid
    }
    
}

extension Habit: Equatable {
    static func == (lhs: Habit, rhs: Habit) -> Bool {
        if lhs.color != rhs.color { return false }
        if lhs.description != rhs.description { return false }
        if lhs.frequency != rhs.frequency { return false }
        if lhs.id != rhs.id { return false }
        if lhs.isArchived != rhs.isArchived { return false }
        if lhs.name != rhs.name { return false }
        if lhs.position != rhs.position { return false }
        if lhs.question != rhs.question { return false }
        if lhs.reminder != rhs.reminder { return false }
        if lhs.targetType != rhs.targetType { return false }
        if lhs.targetValue != rhs.targetValue { return false }
        if lhs.habitType != rhs.habitType { return false }
        if lhs.unit != rhs.unit { return false }
        if lhs.uuid != rhs.uuid { return false }
        return true
    }
}

extension Habit: Hashable {    
    func hash(into hasher: inout Hasher) {
        hasher.combine(color)
        hasher.combine(description)
        hasher.combine(frequency)
        hasher.combine(id ?? 0)
        hasher.combine(isArchived)
        hasher.combine(name)
        hasher.combine(position)
        hasher.combine(question)
        hasher.combine(reminder?.hashValue ?? 0)
        hasher.combine(targetType)
        hasher.combine(targetValue)
        hasher.combine(habitType)
        hasher.combine(unit)
        hasher.combine(uuid)
    }
}

enum HabitType: Int {
    case numberHabit
    case yesNoHabit
}

enum TargetType: Int {
    case atLeast
    case atMost
}

