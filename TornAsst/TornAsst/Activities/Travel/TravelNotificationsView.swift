//
//  TravelNotificationsView.swift
//  TornAsst (iOS)
//
//  Created by Bryan Costanza on 19 Dec 2021.
//

import SwiftUI

struct TravelNotificationsView: View {
    let isOutbound: Bool

    @ObservedObject var travel: Travel

    @State private var isAddingItem = false
    @State private var offset = 1.0

    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    var label: some View {
        let msg = isOutbound ? "Going Abroad" : "Returning to Torn"
        if isOutbound {
            return Label(msg, systemImage: "airplane.arrival")
        } else {
            return Label(msg, image: "airplane.arrival.left")
        }
    }

    var notices: [Notice] {
        isOutbound
        ? travel.flightNoticesOutbound
        : travel.flightNoticesInbound
    }

    var body: some View {
        Section(header: label) {
            if isOutbound {
                MarketplaceTicksRow()
            }
            ForEach(notices) { notice in
                AddAdjustItemRow(isOutbound: isOutbound, notice: notice)
            }
            AddAdjustItemRow(isOutbound: isOutbound, travel: travel)
        }
        .onReceive(travel.objectWillChange) { _ in
            for notice in travel.flightNotices {
                notice.processFlightNoticeChange()
            }
        }
    }
}

struct TravelNotificationsView_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        List {
            TravelNotificationsView(isOutbound: true, travel: Travel.example)
            TravelNotificationsView(isOutbound: false, travel: Travel.example)
        }
        .environment(\.managedObjectContext, dataController.container.viewContext)
        .environmentObject(dataController)
    }
}
