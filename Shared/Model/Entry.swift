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
        case .no , .unknown, .yesAuto:
            return .yesManual
        case .yesManual:
            return .skip
        case .skip:
            return .no
        }
    }
    func nextToggleValueWithoutSkip(entryType: EntryType) -> EntryType {
        switch entryType {
        case .no , .unknown, .yesAuto:
            return .yesManual
        default:
            return .no
        }
    }
    
}


enum EntryType: Int {
    /// Value indicating that no data is available for the given timestamp.
    case unknown = -1
    /// Value indicating that the user did not perform the habit, even though they were expected to perform it.
    case no
    /// Value indicating that the user did not perform the habit, but they were not expected to, because of the frequency of the habit.
    case yesAuto
    /// Value indicating that the user has performed the habit at this timestamp.
    case yesManual
    /// Value indicating that the habit is not applicable for this timestamp.
    case skip
}
