//
//  NotifyQuickActionRow.swift
//  TornAsst (iOS)
//
//  Created by Bryan Costanza on 20 Dec 2021.
//

import SwiftUI
import UserNotifications

struct NotifyQuickActionRow: View {
    let message: String
    @ObservedObject var notice: Notice

    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some View {
        HStack {
            Button {
                notice.isActive.toggle()
                dataController.save()
                processNoticeChange()
            } label: {
                Label(message, systemImage: notice.isActive ? "bell" : "bell.slash")
            }
        }
        .foregroundColor(notice.isActive ? .accentColor : .secondary)
        .onReceive(notice.objectWillChange, perform: processNoticeChange)
    }

    func processNoticeChange() {
        UNUserNotificationCenter.current().removeDeliveredNotifications(
            withIdentifiers: [notice.id?.uuidString ?? "invalid ID"])
        guard notice.isActive else { return }
        guard let travel = notice.travel else { return }
        let interval = travel.flightArrival.timeIntervalSinceNow - Double(notice.noticeOffset)
        guard interval > 0 else { return }

        let content = UNMutableNotificationContent()
        content.title =
            notice.noticeOffset == 0
            ? "Landed in \(travel.flightDestination)"
            : "Landing in \(notice.noticeOffset) seconds"
        content.subtitle =
            notice.noticeOffset == 0
            ? "Stay safe out there"
            : "Destination: \(travel.flightDestination)"
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: travel.flightArrival.timeIntervalSinceNow - Double(notice.noticeOffset),
            repeats: false)
        let identifer = notice.id?.uuidString ?? "invalid ID"
        let request = UNNotificationRequest(identifier: identifer, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}

struct NotifyQuickActionRow_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        List {
            NotifyQuickActionRow(
                message: "\(Notice.exampleActive.offset) seconds before whatever",
                notice: Notice.exampleActive)
            NotifyQuickActionRow(
                message: "\(Notice.exampleInactive.offset) seconds before whatever",
                notice: Notice.exampleInactive)
        }
        .environment(\.managedObjectContext, dataController.container.viewContext)
        .environmentObject(dataController)
    }
}
