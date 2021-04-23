//
//  Frequency.swift
//  Loop Habit Tracker
//
//  Created by Shahriar Nasim Nafi on 20/4/21.
//
// Complete

import Foundation

struct Frequency: Equatable, Hashable {
    var numerator: Int
    var denominator: Int
    
    static let daily = Frequency(numerator: 1, denominator: 1)
    static let threeTimesPerWeek = Frequency(numerator: 3, denominator: 7)
    static let twoTimesPerWeek = Frequency(numerator: 2, denominator: 7)
    static let weekly = Frequency(numerator: 1, denominator: 7)
    
    func toDouble() -> Double {
        Double(numerator / denominator) 
    }
}
