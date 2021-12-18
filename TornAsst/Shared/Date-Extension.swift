//
//  Date-Extension.swift
//  TornAsst
//
//  Created by Bryan Costanza on 15 Dec 2021.
//

import Foundation

extension Date {
    static var tornCalendar: Calendar {
        return Calendar.torn
    }

    static var nextCloseOfBusiness: Date {
        tornCalendar.nextDate(
            after: Date(),
            matching: DateComponents.init(hour: 18),
            matchingPolicy: .nextTime)
        ?? Date()
    }

    static var nextMidnight: Date {
        tornCalendar.nextDate(
            after: Date(),
            matching: DateComponents.init(hour: 0),
            matchingPolicy: .nextTime)
        ?? Date()
    }

    static var nextOnTheHour: Date {
        tornCalendar.nextDate(
            after: Date(),
            matching: DateComponents.init(minute: 00),
            matchingPolicy: .nextTime)
        ?? Date()
    }

    static var nextQuarterPast: Date {
        tornCalendar.nextDate(
            after: Date(),
            matching: DateComponents.init(minute: 15),
            matchingPolicy: .nextTime)
        ?? Date()
    }

    static var nextHalfPast: Date {
        tornCalendar.nextDate(
            after: Date(),
            matching: DateComponents.init(minute: 30),
            matchingPolicy: .nextTime)
        ?? Date()
    }

    static var nextQuarterTil: Date {
        tornCalendar.nextDate(
            after: Date(),
            matching: DateComponents.init(minute: 45),
            matchingPolicy: .nextTime)
        ?? Date()
    }

    static var nextQuarterHour: Date {
        [nextOnTheHour, nextQuarterPast, nextHalfPast, nextQuarterTil].min() ?? Date()
    }

    /// Use for debugging at a faster pace than for `nextQuarterHour`
    static var nextOn10Seconds: Date {
        var intervals: [Date] = []
        for mark in [0, 10, 20, 30, 40, 50] {
            let markDate = tornCalendar.nextDate(
                after: Date(),
                matching: DateComponents.init(second: mark),
                matchingPolicy: .nextTime)
            ?? Date()
            intervals.append(markDate)
        }
        return intervals.min() ?? Date()
    }
}
