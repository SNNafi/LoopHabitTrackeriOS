//
//  Streak.swift
//  LoopHabitTracker
//
//  Created by Shahriar Nasim Nafi on 21/4/21.
//
// Complete

import Foundation

struct Streak {
    let start: Date
    let end: Date
    
    var length: Int {
        start.days(until: end) + 1
    }
    
    func compareLonger(to: Streak) -> CompareDate? {
        if length != to.length {
            return CompareDate(rawValue: (length - to.length).signum())
        } else {
            return compareNewer(to: to)
        }
    }
    
    func compareNewer(to: Streak) -> CompareDate {
        end.compare(to: to.end)
    }
}

