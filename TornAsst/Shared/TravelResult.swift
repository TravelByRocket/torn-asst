//
//  TravelResult.swift
//  TornAsst
//
//  Created by Bryan Costanza on 1/31/21.
//

// swiftlint:disable all
import Foundation

struct TravelResult: Codable {
    var destination: String
    /// Arrival UNIX Epoch time
    var timestamp: Int
    /// Departure UNIX Epoch time
    var departed: Int
    /// Seconds until landing since server refresh. Discourage use because server time is not included with 'travel' query in the API.
    var time_left: Int
    
    static var `default` = TravelResult(destination: "UAE", timestamp: 1606434011, departed: 1606422491, time_left: 10063)
}

//{
//    "travel": {
//        "destination": "Torn",
//        "method": "Airstrip",
//        "timestamp": 1622421463,
//        "departed": 1622410423,
//        "time_left": 7510
//    }
//}
