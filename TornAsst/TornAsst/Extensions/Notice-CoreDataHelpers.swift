//
//  Notice-CoreDataHelpers.swift
//  TornAsst
//
//  Created by Bryan Costanza on 23 Dec 2021.
//

import Foundation
import UserNotifications

extension Notice {
    /// Seconds offset from a point in time
    var noticeOffset: Int {
        get {
            Int(offset)
        }
        set (newValue) {
            offset = Int32(newValue)
        }
    }

    var noticeOffsetSecondsOnly: Int {
        noticeOffset % 60
    }

    var noticeOffsetMinutesOnly: Int {
        (noticeOffset - noticeOffsetSecondsOnly) / 60
    }

    func processFlightNoticeChange() {
        removeAssociatedNotification()
        guard isActive else { return }
        guard let travel = travel else { return }
        let interval = travel.flightArrival.timeIntervalSinceNow - Double(noticeOffset)
        guard interval > 0 else { return }
        let isNoticeInboundAndDestinationTorn = travel.flightDestination == "Torn" && note == "inbound"
        let isNoticeOutboundAndDestinationNotTorn = travel.flightDestination != "Torn" && note == "outbound"
        guard isNoticeInboundAndDestinationTorn || isNoticeOutboundAndDestinationNotTorn else { return }

        let content = UNMutableNotificationContent()
        content.title =
        noticeOffset == 0
        ? "Landed in \(travel.flightDestination)"
        : "Landing in \(noticeOffset) seconds"
        content.subtitle =
        noticeOffset == 0
        ? "Stay safe out there"
        : "Destination: \(travel.flightDestination)"
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: travel.flightArrival.timeIntervalSinceNow - Double(noticeOffset),
            repeats: false)
        let identifer = id?.uuidString ?? "invalid ID"
        let request = UNNotificationRequest(identifier: identifer, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }

    func removeAssociatedNotification() {
        UNUserNotificationCenter.current().removeDeliveredNotifications(
            withIdentifiers: [id?.uuidString ?? "invalid ID"])
        UNUserNotificationCenter.current().removePendingNotificationRequests(
            withIdentifiers: [id?.uuidString ?? "invalid ID"])
    }

    static var exampleActive: Notice {
        let dataController = DataController.preview
        let viewContext = dataController.container.viewContext

        let notice = Notice(context: viewContext)
        notice.isActive = true
        notice.offset = 5
        notice.note = "outbound"
        notice.id = UUID()

        return notice
    }

    static var exampleInactive: Notice {
        let dataController = DataController.preview
        let viewContext = dataController.container.viewContext

        let notice = Notice(context: viewContext)
        notice.isActive = false
        notice.offset = 7
        notice.note = "outbound"
        notice.id = UUID()

        return notice
    }
}
