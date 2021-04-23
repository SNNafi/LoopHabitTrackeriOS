//
//  EntryList.swift
//  LoopHabitTracker
//
//  Created by Shahriar Nasim Nafi on 21/4/21.
//
// Complete

import Foundation

struct EntryList {
    private var entriesByDate: [Date: Entry] = [:]
    
    /// Returns the entry corresponding to the given timestamp. If no entry with such timestamp has been previously added, returns `Entry(date, unknown)`.
    func get(date: Date) -> Entry {
        return entriesByDate[date] ?? Entry(time: date, entryType: .unknown)
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
        entriesByDate[entry.time] = entry
    }
    
    /// Returns all entries whose values are known, sorted by timestamp. The first element  corresponds to the newest entry, and the last element corresponds to the oldest.
    func getKnown() ->  [Entry] {
        return entriesByDate.values.sorted { $0.time > $1.time }
    }
    
    ///  Removes all known entries.
    mutating func removeAll() {
        entriesByDate.removeAll()
    }
    
    ///  Returns the total number of successful entries for each month, grouped by day of week.  The checkmarks are returned in a `Dictionary`. The key is the date for the first day of the month, at midnight (00:00). The value is an integer array with 7 entries. The first entry contains the total number of successful checkmarks during the specified month that occurred on the first day of week of the system's`Locale` and nexts days.  The first day of week can alse be setted by `firstWeekDay`. If there are no successful checkmarks during a certain month, the value is null.  __return__ total number of checkmarks by month versus day of week
    
    func computeWeekdayFrequency(isNumerical: Bool, firstWeekDay: WeekDay? = nil) -> [Date: [Int]] {
        let entries = getKnown()
        var dictionary = [Date: [Int]]()
        for entry in entries {
            let orginalDate = entry.time
            var weekDay = 0
            if firstWeekDay == nil {
                weekDay = orginalDate.weekDay()
            } else {
                weekDay = orginalDate.weekDay(firstWeekDay: firstWeekDay!)
            }
            let truncatedDate = orginalDate.startOf(.month)
            var list = dictionary[truncatedDate]
            if list == nil {
                list = [0, 0, 0, 0, 0, 0, 0]
                dictionary[truncatedDate] = list
            }
            if isNumerical {
                list![weekDay] += entry.entryType.rawValue
            } else if entry.entryType == .yesManual {
                list![weekDay] += 1
            }
        }
        return dictionary
    }
    
    
    
    /// Replaces all entries in this list by entries computed automatically from another list.   For boolean habits, this function creates additional entries (with entryType `EntryType.yesAuto` ) according to the frequency of the habit. For numerical habits, this function simply copies all entries.
    
    mutating func recomputeFrom(originalEntries: EntryList, frequency: Frequency, isNumerical: Bool) {
        removeAll()
        let orginal = originalEntries.getKnown()
        if isNumerical {
            orginal.forEach { add(entry: $0) }
        } else {
            var intervals = EntryList.buildIntervals(freq: frequency, entries: orginal)
            EntryList.snapIntervalsTogether(intervals: &intervals)
            let computed = EntryList.buildEntriesFromInterval(orginal: orginal, intervals: intervals)
            computed.filter { $0.entryType == .unknown }.forEach { add(entry: $0)}
        }
    }
    
    static func buildIntervals(freq: Frequency, entries: [Entry]) -> [Interval] {
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
    
    /// Starting from the second newest interval, this function tries to slide the intervals backwards into the past, so that gaps are eliminated and streaks are maximized.
    /// The intervals should be sorted by date. The first element in the list should  correspond to the newest interval.
    
    static func snapIntervalsTogether(intervals: inout [Interval]) {
        for i in 1..<intervals.count {
            let current = intervals[i]
            let next = intervals[i - 1]
            let gapNextToCurrent = next.begin.days(until: current.end)
            let gapCenterToEnd = current.center.days(until: current.end)
            if gapNextToCurrent >= 0 {
                let shift = min(gapCenterToEnd, gapNextToCurrent + 1)
                intervals[i] = Interval(begin: current.begin.adding(days: -shift), center: current.center, end: current.end.adding(days: -shift))
            }
        }
    }
    
    /// Converts a list of intervals into a list of entries. Entries that fall outside of any  interval receive entryType `EntryType.unknown`. Entries that fall within an interval but do not appear  in __original__ receive entryType `EntryType.yesAuto`. Entries provided in __original__ are copied over.  The intervals should be sorted by date. The first element in the list should  correspond to the newest interval.
    
    static func buildEntriesFromInterval(orginal: [Entry], intervals: [Interval]) -> [Entry]  {
        var result = [Entry]()
        if orginal.isEmpty { return result }
        
        var from = orginal[0].time
        var to = orginal[0].time
        for e in orginal {
            if e.time < from { from = e.time }
            if e.time > to { to = e.time }
        }
        for interval in intervals {
            if interval.begin < from { from = interval.begin }
            if interval.end > to { to = interval.end }
        }
        
        // Create `.unknown` entries
        var current = to
        while current >= from {
            result.append(Entry(time: current, entryType: .unknown))
            current = current.adding(days: -1)
        }
        
        // Create '.yesAuto' entries
        intervals.forEach {
            current = $0.end
            while current >= $0.begin {
                let offset = current.days(until: to)
                result[offset] = Entry(time: current, entryType: .yesAuto)
                current = current.adding(days: -1)
            }
            
        }
        
        // Copy original entries
        orginal.forEach {
            let offset = $0.time.days(until: to)
            if result[offset].entryType == .unknown || $0.entryType == .skip || $0.entryType == .yesManual {
                result[offset] = $0
            }
        }
        return result
    }
}

extension Array where Element == Entry {
    
    
    /// Given a list of entries, truncates the date of each entry (according to the `Calendar.Component` given), groups the entries according to this truncated date, then creates a new entry (t,v) for each group, where t is the truncated date and v is the sum of the `rawValues` the `EntryType` of all entries in the group.
    
    ///  For numerical habits, non-positive entry values are converted to `zero`. For boolean habits, each `.yesManual` value is converted to `1000` and all other values are converted to `zero`.
    
    ///  The returned list is sorted by timestamp, with the newest entry coming first and the oldest entry coming last. If the original list has gaps in it (for example, weeks or months without any entries), then the list produced by this method will also have gaps.
    
    ///  I think this is not needed as `firstWeekDay` automatically changed by the system according to `Locale`
    func groupedSum(truncateComponent: Calendar.Component, isNumerical: Bool, firstWeekDay: WeekDay? = nil) -> [Entry] {
        var entries = self.map { (entry) -> Entry in
            if isNumerical {
                return Entry(time: entry.time, entryType: EntryType.init(rawValue: Swift.max(0, entry.entryType.rawValue)))
            } else {
                return Entry(time: entry.time, entryType: entry.entryType == .yesManual ? .init(rawValue: 1000) : .no)
            }
        }
        
        if firstWeekDay == nil {
            entries = entries.map { Entry(time: $0.time.startOf(truncateComponent), entryType: $0.entryType) }
        } else {
            entries = entries.map { Entry(time: $0.time.startOf(truncateComponent, firstWeekDay: firstWeekDay!), entryType: $0.entryType) }
        }
        
        let entriesDic = Dictionary(grouping: entries, by: { $0.time })
        
        return entriesDic.map { (date, entries) -> Entry in
            let value = entries.reduce(into: 0) { (result, entry) in
                result+=entry.entryType.rawValue
            }
            return Entry(time: date, entryType: .init(rawValue: value))
        }.sorted { $0.time.timeIntervalSince1970 > $1.time.timeIntervalSince1970}
        
    }
}
