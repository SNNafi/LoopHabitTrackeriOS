//
//  HabitRecord.swift
//  LoopHabitTracker
//
//  Created by Shahriar Nasim Nafi on 24/4/21.
//

import GRDB

/**
 * The SQLite database record corresponding to a `Habit`.
 */
struct HabitRecord: Identifiable, Equatable {
    
    var id: Int64?
    var description: String
    var question: String
    var name: String
    var freqNum: Int
    var freqDen: Int
    var color: Int
    var position: Int
    var reminderHour: Int?
    var reminderMin: Int?
    var reminderDays: Int
    var highlight: Int
    var archived: Int
    var habitType: Int
    var targetValue: Double
    var targetType: Int
    var unit: String
    var uuid: String
    
    static var databaseTableName: String {
        "habits"
    }
    
    mutating func copy(from habit: Habit) {
        id = habit.id
        name = habit.name
        description = habit.description
        highlight = 0
        color = habit.color.rawValue
        archived =  habit.isArchived ? 1 : 0
        habitType = habit.habitType.rawValue
        targetType = habit.targetType.rawValue
        targetValue = habit.targetValue
        unit = habit.unit
        position = habit.position
        question = habit.question
        uuid = habit.uuid.uuidString
        freqNum = habit.frequency.numerator
        freqDen = habit.frequency.denominator
        reminderDays = 0
        reminderMin = nil
        reminderHour = nil
        if habit.hasReminder {
            reminderHour = habit.reminder?.time.hour
            reminderMin = habit.reminder?.time.minute
            reminderDays = habit.reminder!.days.reduce(into: [], { (result, weekDay) in
                result.append(weekDay.rawValue)
            }).toInt()
            
        }
    }
    
    func copy(to habit: inout Habit) {
        habit.id = id
        habit.name = name
        habit.description = description
        habit.question = question
        habit.frequency = Frequency(numerator: freqNum, denominator: freqDen)
        habit.color = ColorPalette(rawValue: color)!
        habit.isArchived = archived != 0
        habit.habitType = HabitType(rawValue: habitType)!
        habit.targetType = TargetType(rawValue: targetType)!
        habit.targetValue = targetValue
        habit.unit = unit
        habit.position = position
        habit.uuid = UUID(uuidString: uuid)!
        if (reminderHour != nil && reminderMin != nil) {
            habit.reminder = Reminder(time: Date.from(hour: reminderHour!, minutes: reminderMin!), days: reminderDays.digits.map { WeekDay(rawValue: $0)! }
            )
        }
    }
}

extension HabitRecord: Codable, FetchableRecord, MutablePersistableRecord  {
    
    fileprivate enum Columns {
        static let description = Column(CodingKeys.description)
        static let question = Column(CodingKeys.question)
        static let name = Column(CodingKeys.name)
        static let freq_num = Column(CodingKeys.freqNum)
        static let freq_den = Column(CodingKeys.freqDen)
        static let color = Column(CodingKeys.color)
        static let position = Column(CodingKeys.position)
        static let reminder_hour = Column(CodingKeys.reminderHour)
        static let reminder_min = Column(CodingKeys.reminderMin)
        static let reminder_days = Column(CodingKeys.reminderDays)
        static let highlight = Column(CodingKeys.highlight)
        static let archived = Column(CodingKeys.archived)
        static let habit_type = Column(CodingKeys.habitType)
        static let target_value = Column(CodingKeys.targetValue)
        static let target_type = Column(CodingKeys.targetType)
        static let unit = Column(CodingKeys.unit)
        static let uuid = Column(CodingKeys.uuid)
        
    }
    
    /// Updates a record i.e. `Habit`'s id after it has been inserted in the database.
    mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}
