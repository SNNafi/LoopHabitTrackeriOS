//
//  Reminder.swift
//  LoopHabitTracker
//
//  Created by Shahriar Nasim Nafi on 23/4/21.
//
// Complete

import Foundation

struct Reminder: Equatable, Hashable {
    let time: Date
    let days: [WeekDay]
    
}

