//
//  EntryList.swift
//  LoopHabitTracker
//
//  Created by Shahriar Nasim Nafi on 21/4/21.
//

import Foundation

struct EntryList {
    private var entriesByTimestamp: [Date: Entry] = [:]
    
    /// Returns the entry corresponding to the given timestamp. If no entry with such timestamp has been previously added, returns `Entry(date, unknown)`.
    func get(date: Date) -> Entry {
        return entriesByTimestamp[date] ?? Entry(time: date, entryType: .unknown)
    }
    
    /// Returns one entry for each day in the given interval. The first element corresponds to the newest entry, and the last element corresponds to the oldest. The interval endpoints are included.
    func getByInterval(from: Date, to: Date) -> [Entry] {
        var result = [Entry]()
        if from > to {
            return result
        }
        var current = to
        while current >= from {
            result.append(get(date: current))
            current = Calendar.current.date(byAdding: .day, value: -1, to: current)!
        }
        return result
    }
    
    /// Adds the given entry to the list. If another entry with the same timestamp already exists, replaces it.
    mutating func add(entry: Entry) {
        entriesByTimestamp[entry.time] = entry
    }
    
    /// Returns all entries whose values are known, sorted by timestamp. The first element  corresponds to the newest entry, and the last element corresponds to the oldest.
    func getKnown() ->  [Entry] {
        return entriesByTimestamp.values.sorted { $0.time > $1.time }
    }
    
    ///  Removes all known entries.
    mutating func removeAll() {
        entriesByTimestamp.removeAll()
    }
    
    mutating func recomputeFrom(originalEntries: EntryList, frequency: Frequency, isNumerical: Bool) {
        removeAll()
        var orginal = originalEntries.getKnown()
        if isNumerical {
            orginal.forEach { add(entry: $0) }
        } else {
           // var intervals
        }
    }
    
    func buildIntervals(freq: Frequency, entries: [Entry]) -> [Interval] {
        let filtered = entries.filter { $0.entryType == EntryType.yesManual }
        let num = freq.numerator
        let den = freq.denominator
        var intervals = [Interval]()
        for i in num - 1..<filtered.count {
            let begin = filtered[i]
            let center = filtered[i - num + 1]
            if begin.time.days(until: center.time) < den {
                let end = begin.time.adding(days: den - 1)
                intervals.append(Interval(begin: begin.time, center: center.time, end: end))
            }
        }
        return intervals
    }
}

