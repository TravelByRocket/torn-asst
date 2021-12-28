//
//  TravelSummaryLabel.swift
//  TornAsst
//
//  Created by Bryan Costanza on 27 Dec 2021.
//

import SwiftUI

struct TravelSummaryLabel: View {
    @ObservedObject var travel: Travel

    var body: some View {
        if travel.isOnGround {
            return Label(
                "You are in \(travel.flightDestination)",
                systemImage: travel.flightDestination == "Torn" ? "mappin.and.ellipse" : "camera.viewfinder"
            )
        } else {
            let msg = "Flying to \(travel.flightDestination)"
            if travel.destination == "Torn" {
                return Label(msg, image: "airplane.left")
            } else {
                return Label(msg, systemImage: "airplane")
            }
        }
    }
}

struct TravelSummaryLabel_Previews: PreviewProvider {
    static var previews: some View {
        TravelSummaryLabel(travel: Travel.example)
    }
}
