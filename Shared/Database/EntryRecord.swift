//
//  HabitRecord.swift
//  LoopHabitTracker
//
//  Created by Shahriar Nasim Nafi on 24/4/21.
//

import GRDB

/// The SQLite database record corresponding to a `Entry`
struct EntryRecord: Identifiable, Equatable {
 
    var id: Int64?
    var habit: HabitRecord
    var habitId: Int
    var time: Double
    var value: Int
    
    static var databaseTableName: String {
        "Repetitions"
    }
}

extension EntryRecord: Codable, FetchableRecord, MutablePersistableRecord {
    fileprivate enum Columns {
        static let habit = Column(CodingKeys.habitId)
        static let time = Column(CodingKeys.time)
        static let value = Column(CodingKeys.value)
    }
    
    /// Updates a record i.e. `EntryRecord`'s id after it has been inserted in the database.
    mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
    
    mutating func copy(from entry: Entry) {
        time = entry.time.timeIntervalSince1970
        value = entry.value.rawValue
    }
    
    func to(entry: Entry) -> Entry {
        Entry(time: Date(timeIntervalSince1970: TimeInterval(time)), value: EntryValue(rawValue: value))
    }
}
