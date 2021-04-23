//
//  String+Ex.swift
//  LoopHabitTracker
//
//  Created by Shahriar Nasim Nafi on 24/4/21.
//

extension StringProtocol  {
    /**
     Reverse of `toInt()`
     
     See `Array+Ex` for more details
     */
    var digits: [Int] { compactMap(\.wholeNumberValue) }
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}

extension Numeric where Self: LosslessStringConvertible {
    /**
     Reverse of `toInt()`
     
     See `Array+Ex` for more details
     */
    var digits: [Int] { string.digits }
}
