//
//  StreakList.swift
//  LoopHabitTracker
//
//  Created by Shahriar Nasim Nafi on 21/4/21.
//

import SwiftUI

struct StreakList {
    private var streakList = [Streak]()
    
    mutating func getBest(limit: Int) -> [Streak]  {
        streakList.sort{ $1.compareLonger(to: $0) == CompareDate.newer }
        return [Streak](streakList.prefix(min(streakList.count, limit)))
            .sorted { $1.compareNewer(to: $0) == CompareDate.newer }
    }
    
}

