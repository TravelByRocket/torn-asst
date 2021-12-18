//
//  Ticking.swift
//  TornAsst
//
//  Created by Bryan Costanza on 1/10/21.
//

import Foundation

/// A statistic that increases predictably with time. This is only intended as a base protocol.
protocol Ticking {
    /// value at server check
    var current: Int {get set}
    /// increase in value for each interval
    var increment: Int {get set}
    /// time betweeen increments
    var interval: Seconds {get set}
    /// time to next increment since server check
    var ticktime: Seconds {get set}
    
//    @available(*, deprecated)
//    var serverTime: Date {get set} // This is covered in UserState.stats.serverDate
    
}

extension Ticking {
    /// 0.0-1.0, clamped
    var tickProgressDecimal: Float {
        let decimal = ticktime / interval
        return Float(min(decimal, 1.0)) // clamp output max
    }
    
    func whenAtValue(of value: Int, since serverDate: Date) -> Date? {
        let ticksNeeded = (value - current) / increment
        let timeNeeded = ticktime + interval * Double((ticksNeeded - 1))
        let date = Date(timeInterval: timeNeeded, since: serverDate)
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

//typealias JobPoints = TickDefinite // shouldn't this be Indefinite?

/// A statistic that increases predictably with time and has no maximum
protocol TickIndefinite: Ticking {
    
}

extension TickIndefinite {
    /// daily at close-of-busines 18:00 TCT
//    static func dailyCOB(current: Int, increment: Int, server_time: UnixTime) -> TickIndefinite {
//        let timeTo1800: Seconds = DateInterval(start: Date(), end: Date.next1800TCT).duration
//        let ticker = TickIndefinite(current: current, increment: increment, interval: 86_400, ticktime: timeTo1800, server_time: server_time)
//        return ticker
//    }
}

typealias BarValue = TickDefinite
protocol TickDefinite: Ticking {
    /// largest normal value
    var maximum: Int {get set}
    /// time to full TODO does it return 0 when FULL or OVER?
    var fulltime: Seconds {get set}
    
//    init(current: Int, maximum: Int, increment: Int, interval: Seconds, ticktime: Seconds, fulltime: Seconds, server_time: UnixTime) {
//        self.maximum = maximum
//        self.fulltime = fulltime
//        super.init(current: current, increment: increment, interval: interval, ticktime: ticktime, server_time: server_time)
//    }
}

extension TickDefinite {
    var fullAt: Date? {
        return Date()
    }
    
    var isFull: Bool {
        current >= maximum
    }
    
    var isOverFull: Bool {
        current > maximum
    }
}
