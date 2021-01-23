//
//  Ticking.swift
//  TornAsst
//
//  Created by Bryan Costanza on 1/10/21.
//

import Foundation

/// A statistic that increases predictably with time
class Ticking {
    /// value at server check
    var current: Int
    /// increase in value for each interval
    var increment: Int
    /// time betweeen increments
    var interval: Seconds
    /// time to next increment since server check
    var ticktime: Seconds
    
    var serverTime: Date
    
    /// 0.0-1.0, clamped
    var tickProgressDecimal: Float {
        let decimal = ticktime / interval
        return Float(min(decimal, 1.0)) // clamp output max
    }
    
    init(current: Int, increment: Int, interval: Seconds, ticktime: Seconds, server_time: UnixTime) {
        self.current = current
        self.increment = increment
        self.interval = interval
        self.ticktime = ticktime
        self.serverTime = Date(timeIntervalSince1970: server_time)
    }
    
    func whenAtValue(of value: Int) -> Date? {
        let ticksNeeded = (value - current) / increment
        let timeNeeded = ticktime + interval * Double((ticksNeeded - 1))
        let date = Date(timeInterval: timeNeeded, since: serverTime)
        return date
    }
    
    func whenAtMultiple(of value: Int) -> [Date]? { // OR [Date?] // must limit if indefinite
        print("Issue: whenAtMultiple is placeholder")
        return [Date(timeIntervalSinceNow: 5.0)]
    }
    
    func whenAt(valueOf: Int, multipleOf: Int) -> [Date]? { // OR [Date?] // must limit if indefinite // TODO could take Int? and be the only public method for this
        print("Issue: whenAtMultiple is placeholder")
        return [Date(timeIntervalSinceNow: 10.0)]
    }

}

typealias JobPoints = TickDefinite
class TickIndefinite: Ticking {
    
    /// daily at close-of-busines 18:00 TCT
    static func dailyCOB(current: Int, increment: Int, server_time: UnixTime) -> TickIndefinite {
        let timeTo1800: Seconds = DateInterval(start: Date(), end: Date.next1800TCT).duration
        let ticker = TickIndefinite(current: current, increment: increment, interval: 86_400, ticktime: timeTo1800, server_time: server_time)
        return ticker
    }
}

typealias BarValue = TickDefinite
class TickDefinite: Ticking {
    /// largest normal value
    var maximum: Int
    /// time to full TODO what is it when over?
    var fulltime: Seconds
    
    var fullAt: Date? {
        return Date()
    }
    
    var isFull: Bool {
        current >= maximum
    }
    
    var isOverFull: Bool {
        current > maximum
    }
    
    init(current: Int, maximum: Int, increment: Int, interval: Seconds, ticktime: Seconds, fulltime: Seconds, server_time: UnixTime) {
        self.maximum = maximum
        self.fulltime = fulltime
        super.init(current: current, increment: increment, interval: interval, ticktime: ticktime, server_time: server_time)
    }
}

extension Date {
    static var next1800TCT: Date {
        var calendar = Calendar(identifier: .gregorian)
        let gmt = TimeZone(secondsFromGMT: 0)!
        calendar.timeZone = gmt
        let components = calendar.dateComponents(in: gmt, from: Date())
        let day = components.hour! < 18 ? components.hour! : components.hour! + 1
        let next = DateComponents(calendar: calendar, timeZone: gmt, year: components.year, month: components.month, day: day, hour: components.hour, minute: 0, second: 0)
        return calendar.date(from: next)!
    }
}
