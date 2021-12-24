//
//  TravelResult.swift
//  TornAsst
//
//  Created by Bryan Costanza on 1/31/21.
//

import Foundation

struct TravelJSON: DirectlyMatchedAPI {
    static var apiFields = ["travel", "timestamp"]

    let travel: TravelDetailsJSON

    /// Unix time on server at time of request
    let timestamp: Int

    static var example: TravelJSON {
        TravelJSON(
            travel: TravelDetailsJSON.example,
            timestamp: TravelDetailsJSON.example.timestamp - 100)
    }
}

struct TravelDetailsJSON: InternallyMatchedAPI {
    /// Always (or just usually?) country name
    var destination: String

    /// Type of flight taken. Not currently used.
    let method: String

    /// Arrival Unix Time. Yes, this is a bad name that they chose.
    var timestamp: Int

    /// Departure Unix Time
    var departed: Int

    /// Seconds until landing since server refresh. Discourage use because server time is not included with 'travel'
    /// query in the API.
    @available(*, deprecated) // change to private
    var time_left: Int // swiftlint:disable:this identifier_name

    static var example = TravelDetailsJSON(
        destination: "UAE",
        method: "Airstrip",
        timestamp: Int(Date().timeIntervalSince1970 + 100),
        departed: Int(Date().timeIntervalSince1970 - 1000),
        time_left: 100)
}
