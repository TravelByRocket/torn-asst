//
//  MarketplaceTicksRow.swift
//  TornAsst
//
//  Created by Bryan Costanza on 23 Dec 2021.
//

import SwiftUI
import UserNotifications

struct MarketplaceTicksRow: View {
    @State private var isOn = false

    @EnvironmentObject var player: Player
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    let ticks = [0, 15, 30, 45]

    var travel: Travel {
        player.playerTravel
    }

    var body: some View {
        Toggle(isOn: $isOn) {
            VStack(alignment: .leading) {
                Text("Marketplace Tick Notices")
                Text("Every 15 minutes on the hour")
                    .italic()
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
        }
        .onAppear {
            isOn = travel.enabledMarketTicks
        }
        .onChange(of: isOn) { _ in
            travel.enabledMarketTicks = isOn
            dataController.save()
            updateNotifications()
        }
        .onReceive(player.objectWillChange) { _ in
            updateNotifications()
        }
    }

    func updateNotifications() {
//        travel.isActiveMarketplaceTicks
//        if isNowOn {
        if isOn && travel.isOnGround && travel.destination != "Torn" {
            setUpRepeatingNotification()
        } else {
            deleteRepeatingNotifications()
        }
    }

    func setUpRepeatingNotification() {
        for tick in ticks {
            let content = UNMutableNotificationContent()
            content.title = "Marketplace Restock Tick Now"
            content.body = "This will repeat every 15 minutes on the hour until deactivated or you are flying back to Torn." // swiftlint:disable:this line_length
            content.sound = UNNotificationSound.default
//            let components = DateComponents(calendar: Calendar.torn, second: tick)
            let components = DateComponents(calendar: Calendar.torn, minute: tick)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
            let identifier = "marketplacetick\(tick)"
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        }
    }

    func deleteRepeatingNotifications() {
        for tick in ticks {
            UNUserNotificationCenter.current().removePendingNotificationRequests(
                withIdentifiers: ["marketplacetick\(tick)"])
            UNUserNotificationCenter.current().removeDeliveredNotifications(
                withIdentifiers: ["marketplacetick\(tick)"])
        }
    }
}

struct MarketplaceTicksRow_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        List {
            MarketplaceTicksRow()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
                .environmentObject(Player.example)
        }
    }
}
