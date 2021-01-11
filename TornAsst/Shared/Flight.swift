//
//  Flight.swift
//  TornAsst
//
//  Created by Bryan Costanza on 1/10/21.
//

import Foundation

/// Contains all flight information converted to Swift-convenient types, like `Date` instead of Unix timestamp. TODO Consider it could be `struct` but there can only be one Flight anyway and would using a custom init regardless.
class Flight {
    var destination: Location
    var arrival: Date
    var departure: Date
    
    /// Create a Flight object from Torn API results. Parameter names match API but property names vary slightly to be more succinct.
    /// - Parameters:
    ///   - destination: Matches the exact string return from the API. Contains current city if not flying.
    ///   - timestamp: Arrival time as UNIX timestamp (not server time, as might be assumed). Contains 0 if not flying.
    ///   - departed: Departure time of curent flight as UNIX timestamp or most recent flight if not flying. *TODO Confirm that is it always departure time of the current/last flight. TODO What if user has never flown?*
    ///   - time_left: Seconds remaining on flight at server time. *TODO consider removing since this is not used based on current understanding of API value but should perhaps retain it for completeness and to match class description*
    init(destination: String, timestamp: UnixTime, departed: UnixTime, time_left: Seconds) {
        self.destination = Location(rawValue: destination)! // current city even if not flying
        self.arrival = Date(timeIntervalSince1970: timestamp)
        self.departure = Date(timeIntervalSince1970: departed)
    }
    
    var isInbound: Bool {
        destination == .Torn && isFlying
    }
    
    var isOutbound: Bool {
        destination != .Torn && isFlying
    }
    
    var isFlying: Bool {
        arrival > Date()
    }
    
    func isStillFlying(at date: Date) -> Bool {
        date < arrival
    }
    
    /// Range of 0.0-1.0
    var progressDecimal: Float {
        let flightDuration = DateInterval(start: departure, end: arrival).duration
        return Float(timeRemaining / flightDuration)
    }
    
    var timeRemaining: Seconds {
        let interval = DateInterval(start: Date(), end: arrival)
        return interval.duration
    }
    
    var flightDuration: Seconds {
        let interval = DateInterval(start: departure, end: arrival)
        return interval.duration
    }
}
