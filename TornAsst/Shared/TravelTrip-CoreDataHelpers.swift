//
//  TravelTrip-CoreDataHelpers.swift
//  TornAsst
//
//  Created by Bryan Costanza on 18 Dec 2021.
//

import Foundation

extension TravelTrip {
    /// Returns true if unsure
    var isOnGround: Bool {
        if let date = arrival {
            if date > Date() {
                return false
            }
        }
        return true
    }

    static var example: TravelTrip {
        let dataController = DataController.preview
        let viewContext = dataController.container.viewContext

        let trip = TravelTrip(context: viewContext)
        trip.arrival = Date().addingTimeInterval(1 * 60 * 60)
        trip.departed = Date().addingTimeInterval(-1000)
        trip.destination = "UAE"

        return trip
    }
}
