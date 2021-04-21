//
//  Interval.swift
//  LoopHabitTracker
//
//  Created by Shahriar Nasim Nafi on 21/4/21.
//

import SwiftUI

struct Interval {
    let begin: Date
    let center: Date
    let end: Date
    
    var length: Int {
        begin.days(until: end) + 1
    }
}

