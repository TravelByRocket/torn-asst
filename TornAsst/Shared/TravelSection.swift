//
//  Traveling.swift
//  TornAsst
//
//  Created by Bryan Costanza on 11/26/20.
//

// swiftlint:disable all
import SwiftUI

struct TravelSection: View {
    let travel: TravelDetailsJSON
    let server_time: Int
    
    var localTime: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = .none
        dateFormatter.timeStyle = .long
        return dateFormatter
    }
    
    var tornTime: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = .none
        dateFormatter.timeStyle = .medium
        return dateFormatter
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
            if travel.time_left > 0 {
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

//struct Traveling_Previews: PreviewProvider {
//    static var previews: some View {
//        TravelSection(travel: TravelResult.default, server_time: TornResponse.default.server_time)
//    }
//}
