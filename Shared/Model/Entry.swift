//
//  Entry.swift
//  Loop Habit Tracker
//
//  Created by Shahriar Nasim Nafi on 20/4/21.
//
// Complete

import Foundation

struct Entry {
    let time: Date
    let entryType: EntryType
    
    func nextToggleValueWithSkip(entryType: EntryType) -> EntryType {
        switch entryType {
        case .no , .unknown, .yesAuto, .other(_):
            return .yesManual
        case .yesManual:
            return .skip
        case .skip:
            return .no
        }
    }
    func nextToggleValueWithoutSkip(entryType: EntryType) -> EntryType {
        switch entryType {
        case .no , .unknown, .yesAuto, .other(_):
            return .yesManual
        default:
            return .no
        }
    }
    
}


enum EntryType{
    /// Value indicating that no data is available for the given timestamp.
    case unknown
    /// Value indicating that the user did not perform the habit, even though they were expected to perform it.
    case no
    /// Value indicating that the user did not perform the habit, but they were not expected to, because of the frequency of the habit.
    case yesAuto
    /// Value indicating that the user has performed the habit at this timestamp.
    case yesManual
    /// Value indicating that the habit is not applicable for this timestamp.
    case skip
    
    case other(Int)
    
    
    init(rawValue: Int) {
        switch rawValue {
        case -1:
            self = .unknown
        case  0:
            self = .no
        case  1:
            self = .yesAuto
        case  2:
            self = .yesManual
        case  3:
            self = .skip
        default:
            self = .other(rawValue)
        }
    }
    
    var rawValue: Int {
        switch self {
        case .unknown:
            return -1
        case .no:
            return 0
        case .yesAuto:
            return 1
        case .yesManual:
            return 2
        case .skip:
            return 3
        case let .other(value):
            return value
        }
    }
}

extension EntryType: Equatable {
    static func ==(lhs: EntryType, rhs: EntryType) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
