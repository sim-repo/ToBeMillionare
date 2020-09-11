//
//  Date+Extensions.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 30.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation

func daysBetweenDates(startDate: Date, endDate: Date) -> Int{
    return Calendar.current.dateComponents([.day], from: startDate, to: endDate).day!
}

func daysAdd(date: Date, days: Int) -> Date {
    return Calendar.current.date(byAdding: .day, value: days, to: date) ?? Date()
}
