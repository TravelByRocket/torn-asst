//
//  TravelNotificationsView.swift
//  TornAsst (iOS)
//
//  Created by Bryan Costanza on 19 Dec 2021.
//

import SwiftUI

struct TravelNotificationsView: View {
    let isOutbound: Bool

    var label: some View {
        let msg = isOutbound ? "Going Abroad" : "Returning to Torn"
        if isOutbound {
            return Label(msg, systemImage: "airplane.arrival")
        } else {
            return Label(msg, image: "airplane.arrival.left")
        }
    }

    var header: some View {
        HStack {
            label
            Spacer()
            EditButton()
        }
    }

    var body: some View {
        Section(header: header) {
            if isOutbound {
                Toggle(isOn: .constant(false)) {
                    VStack(alignment: .leading) {
                        Text("Marketplace Tick Notices")
                        Text("Every 15 minutes on the hour")
                            .italic()
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                }
            }
            NotifyQuickActionRow(message: "When I Land", isActive: .constant(true))
            NotifyQuickActionRow(message: "1 Minute Before Landing", isActive: .constant(false))
            NotifyQuickActionRow(message: "5 Minutes Before Landing", isActive: .constant(false))
            Button {
                // add item magic
            } label: {
                Label("Add Item", systemImage: "plus")
            }
        }
    }
}

struct TravelNotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            TravelNotificationsView(isOutbound: true)
            TravelNotificationsView(isOutbound: false)
        }
    }
}
