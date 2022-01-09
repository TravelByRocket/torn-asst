//
//  Reminder-CoreDataHelpers.swift
//  TornAsst
//
//  Created by Bryan Costanza on 16 Dec 2021.
//

import Foundation

extension Reminder {
    enum Labels: String {
        case refillEnergy = "Refill Energy"
        case refillNerve = "Refill Nerve"
        case wheelOfAwesome = "Wheel of Awesome"
        case wheelOfMediocrity = "Wheel of Mediocrity"
        case wheelOfLame = "Wheel of Lame"
        case cityPurchases = "City Purchases"
        case missionAccepted = "Mission Accepted"
        case missionCompleted = "Mission Completed"
        case trains = "Company Trains"
        case stock = "Company Stock"
        case points = "Job Points"
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
        if let completion = lastCompleted {
            let elapsedTime = nextReset.timeIntervalSince(completion)
            return elapsedTime.isLess(than: resetInterval)
        } else {
            return false
        }
    }

    var triggerMinute: Int {
        let timeCode = Int(hourCode)
        return timeCode % 100
    }

    var triggerHour: Int {
        let timeCode = Int(hourCode)
        return (timeCode - triggerMinute) / 100
    }

    var nextResetComponents: DateComponents {
        DateComponents.init(hour: triggerHour, minute: triggerMinute)
    }

    var itemName: String {
        name ?? "New Name"
    }

    static var midnightHourCode = 0000
    static var midnightHourCode16 = Int16(0000)

    static var closeOfBusinessHourCode = 1800
    static var closeOfBusinessHourCode16 = Int16(1800)

    static var example: Reminder {
        let dataController = DataController.preview
        let viewContext = dataController.container.viewContext

        let task = Reminder(context: viewContext)
        task.name = "Example Task"
        task.lastCompleted = nil
        task.intervalDays = 1
        task.isInactive = false
        task.hourCode = midnightHourCode16

        return task
    }

    static var exampleWeekly: Reminder {
        let dataController = DataController.preview
        let viewContext = dataController.container.viewContext

        let task = Reminder(context: viewContext)
        task.name = "Example Task"
        task.lastCompleted = nil
        task.intervalDays = 7
        task.isInactive = false
        task.hourCode = midnightHourCode16

        return task
    }
}
