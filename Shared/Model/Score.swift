//
//  Score.swift
//  LoopHabitTracker
//
//  Created by Shahriar Nasim Nafi on 23/4/21.
//
// Complete

import Foundation

struct Score {
    let date: Date
    let value: Double
    
    
    /// Given the frequency of the habit, the previous score, and the value of the current checkmark, computes the current score for the habit. The frequency of the habit is the number of repetitions divided by the length of the interval. For example, a habit that should be repeated 3 times in 8 days has frequency 3.0 / 8.0 = 0.375.
    
    static func compute(frequency: Double, previousScore: Double, checkmarkValue: Double) -> Double {
        let multiplier = pow(0.5, (sqrt(frequency) /  13.0))
        var score =  previousScore * multiplier
        score += checkmarkValue * (1 - multiplier)
        return score
    }
}

