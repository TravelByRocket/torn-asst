//
//  DatedResetItem-CoreDataHelpers.swift
//  TornAsst
//
//  Created by Bryan Costanza on 16 Dec 2021.
//

import Foundation

extension DatedResetItem {
    enum Labels: String {
        case refillEnergy = "Refill Energy"
        case refillNerve = "Refill Nerve"
        case wheelOfAwesome = "Wheel of Awesome"
        case wheelOfMediocrity = "Wheel of Mediocrity"
        case wheelOfLame = "Wheel of Lame"
        case cityPurchases = "City Purchases"
        case missionAccepted = "Mission Accepted"
        case missionCompleted = "Mission Completed"
        case trains = "Trains"
        case stock = "Stock"
        case points = "Points"
        case missionRewards = "Mission Rewards"
    }

    var nextReset: Date {
        Calendar.torn.nextDate(
            after: Date(),
            matching: nextResetComponents,
            matchingPolicy: .nextTime
        ) ?? Date()
    }

    var isCompletedThisPeriod: Bool {
        let resetInterval = 86_400 * Double(intervalDays)
        if let completion = dateCompleted {
            let elapsedTime = nextReset.timeIntervalSince(completion)
            return elapsedTime.isLess(than: resetInterval)
        } else {
            return false
        }
    }

    var triggerMinute: Int {
        let timeCode = Int(triggerHourCode)
        return timeCode % 100
    }

    var triggerHour: Int {
        let timeCode = Int(triggerHourCode)
        return (timeCode - triggerMinute) / 100
    }

    var nextResetComponents: DateComponents {
        DateComponents.init(hour: triggerHour, minute: triggerMinute)
    }

    var itemLabel: String {
        label ?? "New Label"
    }

    static var midnightHourCode = 0000
    static var midnightHourCode16 = Int16(0000)

    static var closeOfBusinessHourCode = 1800
    static var closeOfBusinessHourCode16 = Int16(1800)

    static var example: DatedResetItem {
        let dataController = DataController.preview
        let viewContext = dataController.container.viewContext

        let task = DatedResetItem(context: viewContext)
        task.label = "Example Task"
        task.dateCompleted = nil
        task.intervalDays = 1
        task.isHidden = false
        task.section = "Spin the Wheel"
        task.triggerHourCode = midnightHourCode16
        let daily = Daily(context: viewContext)
        task.daily = daily

        return task
    }
}
