//
//  TravelNotificationsView.swift
//  TornAsst (iOS)
//
//  Created by Bryan Costanza on 19 Dec 2021.
//

import SwiftUI

struct TravelNoticesSection: View {
    let isOutbound: Bool

    @ObservedObject var travel: Travel

    @State private var isAddingItem = false
    @State private var offset = 1.0

    @EnvironmentObject var player: Player
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    var notices: [Notice] {
        isOutbound
        ? travel.flightNoticesOutbound
        : travel.flightNoticesInbound
    }

    var body: some View {
        Section(header: TravelNoticesSectionHeader(isOutbound: isOutbound)) {
            if isOutbound {
                MarketplaceTicksRow()
            }
            ForEach(notices) { notice in
                AddAdjustItemRow(isOutbound: isOutbound, notice: notice)
            }
            AddAdjustItemRow(isOutbound: isOutbound, travel: travel)
        }
        .onReceive(player.objectWillChange) { _ in
            for notice in travel.flightNotices {
                notice.processFlightNoticeChange()
            }
        }
    }
}

struct TravelNoticesSection_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        List {
            TravelNoticesSection(isOutbound: true, travel: Travel.example)
            TravelNoticesSection(isOutbound: false, travel: Travel.example)
        }
        .environment(\.managedObjectContext, dataController.container.viewContext)
        .environmentObject(dataController)
        .environmentObject(Player.example)
    }
}
