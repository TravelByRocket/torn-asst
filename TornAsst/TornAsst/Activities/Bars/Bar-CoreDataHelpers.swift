//
//  Bar-CoreDataHelpers.swift
//  TornAsst (iOS)
//
//  Created by Bryan Costanza on 19 Dec 2021.
//

import Foundation
import SwiftUI

extension Bar: Notifying {
    /// "energy", "nerve", etc.
    var barName: String {
        name ?? "Coalesced Label"
    }

    /// Non-optional `Date` based on the API `server_time`
    var barDate: Date {
        date ?? Date()
    }

    /// Percentage of tick complete when fetched from server.
    var tickProgress: Double {
        Double(interval - ticktime) / Double(interval)
    }

    /// Percent full when fetched from server. Values 0.0 to 1.0.
    var barProgress: Double {
        Double(current) / Double(maximum)
    }

    /// Percent full when fetched from server. Clips at 1.0
    var barProgressClamped: Double {
        min(Double(current) / Double(maximum), 1.0)
    }

    /// True if `fullDate` is before now, and therefore also if `current > maximum`.
    /// Use `isOverFull` for more. Bars will not continue increasing if they are full.
    var isFull: Bool {
        barFull.isBefore(Date())
    }

    /// Compares the `current` and `maxiumum` values. Ignores overfull values that expire at the next tick.
    var isOverFull: Bool {
        current > maximum
    }

    /// `Int` version of `maximum`. Highest normal value of the bar; can be exceeded.
    var barMaximum: Int {
        Int(maximum)
    }

    /// `Int` version of `current`. Bar value when fetched from server.
    var barCurrent: Int {
        Int(current)
    }

    /// `Int` version of `fulltime`. Seconds until the bar is full. 0 if full or overfull.
    var barFulltime: Int {
        Int(fulltime)
    }

    /// `Int` version of `increment`. Amount the bar increases at each tick.
    var barIncrement: Int {
        Int(increment)
    }

    /// `Int` version of `ticktime`. Seconds until next tick from when fetched from server.
    var barTicktime: Int {
        Int(ticktime)
    }

    /// Seconds between ticks
    var barInterval: Int {
        Int(interval)
    }

    /// Moment of the tick that will make the bar full.
    var barFull: Date {
        barDate.addingTimeInterval(TimeInterval(fulltime))
    }

    var ticksToFill: Int {
        let increaseNeeded = barMaximum - barCurrent
        guard barIncrement > 0 else { return 0 }
        let ticksMinimum = increaseNeeded / barIncrement
        let remainder = increaseNeeded % barIncrement
        let partialTickNeeded = remainder > 0
        return ticksMinimum + (partialTickNeeded ? 1 : 0)
    }

    func timeNeededFor(_ ticks: Int) -> TimeInterval {
        var dateOfNextTick = barDate.addingTimeInterval(TimeInterval(barTicktime))
//        while dateOfNextTick.isBefore(Date()) {
//            dateOfNextTick.addTimeInterval(TimeInterval(barInterval))
//        }
        let interval = dateOfNextTick.timeIntervalSinceNow + TimeInterval(barInterval * (ticks - 1))
        return interval
    }

    var timeToFill: Int {
        var timeNeeded = 0
        if ticksToFill > 0 {
            timeNeeded += barTicktime
            timeNeeded += (ticksToFill - 1) * barInterval
        }
        return timeNeeded
    }

    var barNoticeHandling: NoticeHandling {
        if let handling = noticeHandling {
            return handling
        } else if let context = managedObjectContext {
            let handling = NoticeHandling(context: context)
            handling.bar = self
            return handling
        } else {
            let handling = NoticeHandling()
            handling.bar = self
            return handling
        }
    }

    var barSettings: BarSettings {
        if let settings = settings {
            return settings
        } else if let context = managedObjectContext {
            let settings = BarSettings(context: context)
            settings.bar = self
            return settings
        } else {
            let settings = BarSettings()
            settings.bar = self
            return settings
        }
    }

    func validMultiples(of value: Int) -> [Int] {
        if value == 0 || value >= barMaximum { return [] }
        let multiplesCount = barMaximum/value
        return (1...multiplesCount).map { $0 * value }
    }

//    func whenAt(value: Int) -> Date? {
//        let ticksNeeded = current
//    }
//
//    func whenAt(values: [Int]) -> [Date] {
//
//    }
}
