//
//  TravelNoticesSectionHeader.swift
//  TornAsst
//
//  Created by Bryan Costanza on 27 Dec 2021.
//

import SwiftUI

struct TravelNoticesSectionHeader: View {
    let isOutbound: Bool

    var message: String {
        isOutbound ? "Going Abroad" : "Returning to Torn"
    }

    var body: some View {
        if isOutbound {
            Label(message, systemImage: "airplane.arrival")
        } else {
            Label(message, image: "airplane.arrival.left")
        }
    }
}

struct TravelNoticesSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Section(header: TravelNoticesSectionHeader(isOutbound: true)) {
                Text("Outbound")
            }
            Section(header: TravelNoticesSectionHeader(isOutbound: false)) {
                Text("Inbound")
            }
        }
    }
}
