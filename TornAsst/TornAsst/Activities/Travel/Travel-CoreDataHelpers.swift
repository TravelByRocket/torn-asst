//
//  TravelTrip-CoreDataHelpers.swift
//  TornAsst
//
//  Created by Bryan Costanza on 18 Dec 2021.
//

import Foundation

extension Travel: Notifying {
    /// When the flight arrives, otherwise distant past
    var flightArrival: Date {
        arrival ?? Date.distantPast
    }

    /// When the flight departed, otherwise distant past
    var flightDeparture: Date {
        departed ?? Date.distantPast
    }

    /// Usually (always?) the country
    var flightDestination: String {
        destination ?? "Unknown"
    }

    /// Based on departure and arrival
    var flightDuration: TimeInterval {
        DateInterval(start: flightDeparture, end: flightArrival).duration
    }

    /// Compared to now
    var flightTimeRemaining: TimeInterval {
        flightArrival.distance(to: Date())
    }

    /// Range of 0.0-1.0, returning 1.0 if there is no flight duration available
    var flightProgress: TimeInterval {
        guard flightDuration > 0.0 else { return 1.0 } // guard div by 0
        return flightTimeRemaining / flightDuration
    }

    var flightNotices: [Notice] {
        notices?.allObjects as? [Notice] ?? []
    }

    var flightNoticesAscending: [Notice] {
        flightNotices.sorted { first, second in
            return first.offset < second.offset
        }
    }

    var flightNoticesOutbound: [Notice] {
        flightNoticesAscending.filter { $0.note == "outbound" }
    }

    var flightNoticesInbound: [Notice] {
        flightNoticesAscending.filter { $0.note == "inbound" }
    }

    /// True if now is after arrival (or if arrival is nil)
    var isOnGround: Bool {
        Date().isAfter(flightArrival)
    }

    static var example: Travel {
        let dataController = DataController.preview
        let viewContext = dataController.container.viewContext

        let trip = Travel(context: viewContext)
        trip.arrival = Date().addingTimeInterval(1 * 60 * 60)
        trip.departed = Date().addingTimeInterval(-1000)
        trip.destination = "UAE"

        return trip
    }
}
