//
//  Array+Ex.swift
//  LoopHabitTracker
//
//  Created by Shahriar Nasim Nafi on 24/4/21.
//

import Foundation

extension Array where Element == Int {
    /**
     Convert `[Int]` to `Int`
      - Returns :  Given `[1,5,2,4,3,24,4]` ->  15243244
     */
    func toInt() -> Int {
        var myString = ""
        _ = self.map{ myString = myString + "\($0)" }
        return Int(myString)!
    }
}
