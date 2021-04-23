//
//  ScoreList.swift
//  LoopHabitTracker
//
//  Created by Shahriar Nasim Nafi on 23/4/21.
//
// Complete

import Foundation

struct ScoreList {
    private var dictionary = [Date: Score]()
    
    ///  Returns the score for a given day. If the timestamp given happens before the first repetition of the habit or after the last computed score, returns a score with value zero.
    func get(date: Date) -> Score {
        dictionary[date] ?? Score(date: date, value: 0.0)
    }
    
    
    /// Returns the list of scores that fall within the given interval.  There is exactly one score per day in the interval. The endpoints of the interval are included. The list is ordered by date (decreasing). That is, the first score corresponds to the newest date, and the last score corresponds to the oldest date.
    
    func getByInterval(from: Date, to: Date) -> [Score] {
        var result = [Score]()
        if from.isNewer(than: to) { return result }
        var current = to
        while !current.isOlder(than: from) {
            result.append(get(date: current))
            current = current.adding(days: -1)
        }
        return result
    }
    
    mutating func recompute( frequency: Frequency, isNumerical: Bool, targetValue: Double, computedEntries: EntryList, from: Date, to: Date) {
        dictionary.removeAll()
        
        if computedEntries.getKnown().isEmpty { return }
        if from.isNewer(than: to) { return }
        var rollingSum = 0.0
        var numerator = frequency.numerator
        var denominator = frequency.denominator
        let freq = frequency.toDouble()
        let values = computedEntries.getByInterval(from: from, to: to).map { $0.value.rawValue }
        
        // For non-daily boolean habits, we double the numerator and the denominator to smooth
        // out irregular repetition schedules (for example, weekly habits performed on different
        // days of the week)
        if !isNumerical && freq < 1.0 {
            numerator *= 2
            denominator *= 2
        }
        var previousValue = 0.0
        for i in values {
            let offset = values.count - i - 1
            if isNumerical {
                rollingSum += Double(values[offset])
                if offset + denominator < values.count {
                    rollingSum -= Double(values[offset + denominator])
                }
                let percentageCompleted = min(1.0, rollingSum / 1000 / targetValue)
                previousValue = Score.compute(frequency: freq, previousScore: previousValue, checkmarkValue: percentageCompleted)
            } else {
                if values[offset] == EntryValue.yesManual.rawValue {
                    rollingSum += 1.0
                }
                if offset + denominator < values.count {
                    if values[offset + denominator] == EntryValue.yesManual.rawValue {
                        rollingSum -= 1.0
                    }
                }
                if values[offset] != EntryValue.skip.rawValue {
                    let percentageCompleted = min(1.0, rollingSum / Double(numerator))
                    previousValue = Score.compute(frequency: freq, previousScore: previousValue, checkmarkValue: percentageCompleted)
                }
            }
            let date = from.adding(days: i)
            dictionary[date] = Score(date: date, value: previousValue)
            
        }
    }
}

