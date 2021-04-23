//
//  StreakList.swift
//  LoopHabitTracker
//
//  Created by Shahriar Nasim Nafi on 21/4/21.
//
// Complete

import Foundation

struct StreakList {
    private var streakList = [Streak]()
    
    mutating func getBest(limit: Int) -> [Streak]  {
        streakList.sort{ $1.compareLonger(to: $0) == CompareDate.newer }
        return [Streak](streakList.prefix(min(streakList.count, limit)))
            .sorted { $1.compareNewer(to: $0) == CompareDate.newer }
    }
    
    mutating func recompute(computedEntries: EntryList, from: Date, to: Date) {
        streakList.removeAll()
        let dates = computedEntries
            .getByInterval(from: from, to: to)
            .filter { $0.value.rawValue  > 0 }
            .map { $0.time }
        if dates.isEmpty { return }
        var begin = dates[0]
        var end = dates[0]
        for i in 1..<dates.count {
            let current = dates[i]
            if current == begin.adding(days: -1) {
                begin = current
            } else {
                streakList.append(Streak(start: begin, end: end))
                begin = current
                end = current
            }
        }
        streakList.append(Streak(start: begin, end: end))
        
    }
    
}

