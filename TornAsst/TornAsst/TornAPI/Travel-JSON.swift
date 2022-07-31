//
//  TravelResult.swift
//  TornAsst
//
//  Created by Bryan Costanza on 1/31/21.
//

import Foundation

extension Travel {
    func setFromJSON(_ json: JSON) {
        departed = Date(timeIntervalSince1970: TimeInterval(json.travel.departed))
        arrival = Date(timeIntervalSince1970: TimeInterval(json.travel.timestamp))
        destination = json.travel.destination
    }

    struct JSON: DirectlyMatchedAPI {
        static var apiFields = ["travel", "timestamp"]

        /// The details you would expect from travel, but nested one level deeper than expected
        let travel: InnerJSON

        /// Unix time on server at time of request
        let timestamp: Int

        static var example: JSON {
            JSON(
                travel: InnerJSON.example,
                timestamp: InnerJSON.example.timestamp - 100)
        }
    }

    struct InnerJSON: InternallyMatchedAPI {
        /// Always (or just usually?) country name
        var destination: String

        /// Type of flight taken. Not currently used.
        let method: String

        /// Arrival Unix Time. Yes, this is a bad name that they chose.
        var timestamp: Int

        /// Departure Unix Time
        var departed: Int

        /// Seconds until landing since server refresh. Discourage use because server time is not included with
        /// 'travel' query in the API.
        private var time_left: Int // swiftlint:disable:this identifier_name

        static var example = InnerJSON(
            destination: "UAE",
            method: "Airstrip",
            timestamp: Int(Date().timeIntervalSince1970 + 100),
            departed: Int(Date().timeIntervalSince1970 - 1000),
            time_left: 100)
    }
}
