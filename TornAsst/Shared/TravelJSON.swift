//
//  TravelResult.swift
//  TornAsst
//
//  Created by Bryan Costanza on 1/31/21.
//

// swiftlint:disable all
import Foundation


struct TravelJSON: DirectlyMatchedAPI {
    static var apiFields = ["travel", "timestamp"]
    
    var travel: TravelDetailsJSON
//    /// Unix time on server at time of request
//    let timestamp: Int
}

struct TravelDetailsJSON: InternallyMatchedAPI {
    
    /// Tends to be (or always?) country name
    var destination: String
    /// Not currently used
    let method: String
    /// Arrival UNIX Epoch time
    var timestamp: Int
    /// Departure UNIX Epoch time
    var departed: Int
    /// Seconds until landing since server refresh. Discourage use because server time is not included with 'travel' query in the API.
    var time_left: Int
    
    static var `default` = TravelDetailsJSON(destination: "UAE", method: "Airstrip", timestamp: 1606434011, departed: 1606422491, time_left: 10063)
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
