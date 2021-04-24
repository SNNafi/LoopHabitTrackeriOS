//
//  Date+Ex.swift
//  LoopHabitTracker
//
//  Created by Shahriar Nasim Nafi on 21/4/21.
//

import Foundation

extension Date {
    
    /// Returns -1 if this date is older than the given date, 1 if this date is newer, or zero if they are equal.
    func compare(to date: Date) -> CompareDate {
//        if self == date {
//            return .equal
//        } else if self < date {
//            return .older
//        } else {
//            return .newer
//        }
        return CompareDate(rawValue: Int((self.timeIntervalSince1970 - date.timeIntervalSince1970)).signum())!
    }
    
    
    func isNewer(than: Date) -> Bool {
        return compare(to: than).rawValue > 0
    }
    
    func isOlder(than: Date) -> Bool {
            return compare(to: than).rawValue < 0
        }
    
    /// Returns the number of days between this date and the given one. If the other date equals this one, returns zero. If the other timestamp is older than this one, returns a negative number.
    
    func days(until date: Date) -> Int {
        Calendar.current.dateComponents([.day], from: self, to: date).day!
    }
    
    /// Add day(s) to a date
    func adding(days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
    
    /// Add week(s) to a date
    func adding(weeks: Int) -> Date {
        Calendar.current.date(byAdding: .weekOfYear, value: weeks, to: self)!
    }
    
    /// Add year(s) to a date
    func adding(years: Int) -> Date {
        Calendar.current.date(byAdding: .year, value: years, to: self)!
    }
    
    /// Truncates a date according to the  given `Calendar.Component` i.e. `.day` , `.month`
    
    func startOf(_ dateComponent: Calendar.Component) -> Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.autoupdatingCurrent
        var startOfComponent = self
        var timeInterval : TimeInterval = 0.0
        calendar.dateInterval(of: dateComponent, start: &startOfComponent, interval: &timeInterval, for: self)
        return startOfComponent
    }
    
//    func startOf(_ dateComponent: Calendar.Component, firstWeekDay: WeekDay) -> Date {
//        var calendar = Calendar(identifier: .gregorian)
//        calendar.firstWeekday = firstWeekDay.rawValue
//        calendar.timeZone = TimeZone.autoupdatingCurrent
//        var startOfComponent = self
//        var timeInterval : TimeInterval = 0.0
//        calendar.dateInterval(of: dateComponent, start: &startOfComponent, interval: &timeInterval, for: self)
//        return startOfComponent
//    }
    
    func weekDay() -> Int {
        let calendar = Calendar.current
        return (calendar.component(.weekday, from: self) - calendar.firstWeekday + 7) % 7 + 1
    }
    
//    func weekDay(firstWeekDay: WeekDay) -> Int {
//        var calendar = Calendar(identifier: .gregorian)
//        calendar.firstWeekday = firstWeekDay.rawValue
//        return (calendar.component(.weekday, from: self) - calendar.firstWeekday + 7) % 7 + 1
//    }
    
    var hour: Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: self)
    }
    
    var minute: Int {
        let calendar = Calendar.current
        return calendar.component(.minute, from: self)
    }
    
    var day: Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: self)
    }
    
    var dayOfTheWeek: WeekDay {
        let calendar = Calendar.current
        return WeekDay(rawValue: calendar.component(.weekday, from: self))!
    }
    
    var month: Int {
        let calendar = Calendar.current
        return calendar.component(.month, from: self)
    }
    
    var year: Int {
        let calendar = Calendar.current
        return calendar.component(.year, from: self)
    }
    
    var dayMonthYear: Int {
        Int("\(day)\(month)\(year)")!
    }
    
    static func from(hour: Int, minutes: Int) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.date(from: "\(hour):\(minutes)")!
//        let finalTime = formatter.string(from: time)
    }
}

/// Returns -1 if this date is older than the given date, 1 if this timestamp is newer, or zero if they are equal.
enum CompareDate: Int {
    case older = -1
    case equal = 0
    case newer = 1
}

enum WeekDay: Int {
    case sunday = 1
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
}
