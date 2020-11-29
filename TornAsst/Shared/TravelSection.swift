//
//  Traveling.swift
//  TornAsst
//
//  Created by Bryan Costanza on 11/26/20.
//

import SwiftUI

struct TravelSection: View {
    let travel: TravelResult
    let server_time: Int
    
    var localTime: DateFormatter {
        let f = DateFormatter()
        f.dateFormat = .none
        f.timeStyle = .long
        return f
    }
    
    var tornTime: DateFormatter {
        let f = DateFormatter()
        f.timeZone = TimeZone(abbreviation: "UTC")
        f.dateFormat = .none
        f.timeStyle = .medium
        return f
    }
    
    var timeIntervalRemaining: TimeInterval {
        let dateRightNow = Date()
        let dateAtServerUpdate = Date(timeIntervalSince1970: TimeInterval(server_time))
        let timeSinceServerUpdate = dateRightNow.distance(to: dateAtServerUpdate)
        let timeLeftAtServerUpdate = TimeInterval(travel.time_left)
        let actualTimeLeft = timeLeftAtServerUpdate - timeSinceServerUpdate
        return actualTimeLeft
    }
    
    var dateArriving: Date {
        Date(timeIntervalSince1970: TimeInterval(travel.timestamp))
    }
    
    var dateDeparted: Date {
        Date(timeIntervalSince1970: TimeInterval(travel.departed))
    }
    
    var body: some View {
//        List(Array(TimeZone.abbreviationDictionary.keys), id: \.self) {zone in
//            Text(String(zone))
//        }
        VStack {
            if (travel.time_left > 0) {
                Text("Flying to \(travel.destination)")
                Text("Arriving at \(dateArriving, formatter: localTime) / \(tornTime.string(from: dateArriving)) TCT")
                Text("\(dateArriving, style: .timer) remaining")
            } else {
                Text("You are in \(travel.destination)")
            }
            DisclosureGroup("Notification Preferences") {
                TravelControls(travel: travel)
            }.padding(.horizontal)
        }
    }
}

struct Traveling_Previews: PreviewProvider {
    static var previews: some View {
        TravelSection(travel: TravelResult.default, server_time: TornResponse.default.server_time)
    }
}
