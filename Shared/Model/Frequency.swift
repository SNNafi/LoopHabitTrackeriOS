//
//  Frequency.swift
//  Loop Habit Tracker
//
//  Created by Shahriar Nasim Nafi on 20/4/21.
//
// Complete

import Foundation

struct Frequency{
    var numerator: Int
    var denominator: Int
    
    static let DAILY = Frequency(numerator: 1, denominator: 1)
    static let THREE_TIMES_PER_WEEK = Frequency(numerator: 3, denominator: 7)
    static let TWO_TIMES_PER_WEEK = Frequency(numerator: 2, denominator: 7)
    static let WEEKLY = Frequency(numerator: 1, denominator: 7)
    
    func toDouble() -> Double {
        Double(numerator / denominator) 
    }
}


