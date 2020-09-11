//
//  Date+Extentions.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 25.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation


extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var dayBeforeYesterday: Date { return Date().days2Before }
    static var threeDaysBefore: Date { return Date().days3Before }
    static var fourDaysBefore: Date { return Date().days4Before }
    static var fiveDaysBefore: Date { return Date().days5Before }
    static var sixDaysBefore: Date { return Date().days6Before }
    static var sevenDaysBefore: Date { return Date().days7Before }
    static var eightDaysBefore: Date { return Date().days8Before }
    static var nineDaysBefore: Date { return Date().days9Before }
    static var tenDaysBefore: Date { return Date().days10Before }
    
    static var tomorrow:  Date { return Date().dayAfter }
    
    
    public static func daysAdd(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: noon)!
    }
    
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date.noon)!
    }
    var days2Before: Date {
        return Calendar.current.date(byAdding: .day, value: -2, to: Date.noon)!
    }
    var days3Before: Date {
        return Calendar.current.date(byAdding: .day, value: -3, to: Date.noon)!
    }
    var days4Before: Date {
        return Calendar.current.date(byAdding: .day, value: -4, to: Date.noon)!
    }
    var days5Before: Date {
        return Calendar.current.date(byAdding: .day, value: -5, to: Date.noon)!
    }
    var days6Before: Date {
        return Calendar.current.date(byAdding: .day, value: -6, to: Date.noon)!
    }
    var days7Before: Date {
        return Calendar.current.date(byAdding: .day, value: -7, to: Date.noon)!
    }
    var days8Before: Date {
        return Calendar.current.date(byAdding: .day, value: -8, to: Date.noon)!
    }
    var days9Before: Date {
        return Calendar.current.date(byAdding: .day, value: -9, to: Date.noon)!
    }
    var days10Before: Date {
        return Calendar.current.date(byAdding: .day, value: -10, to: Date.noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: Date.noon)!
    }
    static var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date().self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}


extension Date {

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}
