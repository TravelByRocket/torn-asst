//
//  TravelNotificationsView.swift
//  TornAsst (iOS)
//
//  Created by Bryan Costanza on 19 Dec 2021.
//

import SwiftUI

struct TravelNoticesSection: View {
    let isOutbound: Bool

    @State private var isAddingItem = false

    @EnvironmentObject var player: Player
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    var travel: Travel {
        player.playerTravel
    }

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
                NoticeAdjustRow(notice: notice)
            }
            NoticeAdjustRow(parent: travel, tag: isOutbound ? "outbound" : "inbound")
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
            TravelNoticesSection(isOutbound: true)
            TravelNoticesSection(isOutbound: false)
        }
        .environment(\.managedObjectContext, dataController.container.viewContext)
        .environmentObject(dataController)
        .environmentObject(Player.example)
    }
}
