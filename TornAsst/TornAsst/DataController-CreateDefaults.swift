//
//  DataController-Extension.swift
//  TornAsst
//
//  Created by Bryan Costanza on 16 Dec 2021.
//

import Foundation

extension DataController {
    func createDailyDefaults(player: Player) throws {
        let viewContext = container.viewContext

        let refillEnergy = Reminder(context: viewContext)
        refillEnergy.name = Reminder.Labels.refillEnergy.rawValue
        refillEnergy.isInactive = false
        refillEnergy.intervalDays = 1
        refillEnergy.hourCode = Reminder.midnightHourCode16
        refillEnergy.player = player

        let refillNerve = Reminder(context: viewContext)
        refillNerve.name = Reminder.Labels.refillNerve.rawValue
        refillNerve.isInactive = false
        refillNerve.intervalDays = 1
        refillNerve.hourCode = Reminder.midnightHourCode16
        refillNerve.player = player

        let wheelOfAwesome = Reminder(context: viewContext)
        wheelOfAwesome.name = Reminder.Labels.wheelOfAwesome.rawValue
        wheelOfAwesome.isInactive = false
        wheelOfAwesome.intervalDays = 1
        wheelOfAwesome.hourCode = Reminder.midnightHourCode16
        wheelOfAwesome.player = player

        let wheelOfMediocrity = Reminder(context: viewContext)
        wheelOfMediocrity.name = Reminder.Labels.wheelOfMediocrity.rawValue
        wheelOfMediocrity.isInactive = false
        wheelOfMediocrity.intervalDays = 1
        wheelOfMediocrity.hourCode = Reminder.midnightHourCode16
        wheelOfMediocrity.player = player

        let wheelOfLame = Reminder(context: viewContext)
        wheelOfLame.name = Reminder.Labels.wheelOfLame.rawValue
        wheelOfLame.isInactive = false
        wheelOfLame.intervalDays = 1
        wheelOfLame.hourCode = Reminder.midnightHourCode16
        wheelOfLame.player = player

        let cityPurchases = Reminder(context: viewContext)
        cityPurchases.name = Reminder.Labels.cityPurchases.rawValue
        cityPurchases.isInactive = false
        cityPurchases.intervalDays = 1
        cityPurchases.hourCode = Reminder.midnightHourCode16
        cityPurchases.player = player

        let missionAccepted = Reminder(context: viewContext)
        missionAccepted.name = Reminder.Labels.missionAccepted.rawValue
        missionAccepted.isInactive = false
        missionAccepted.intervalDays = 1
        missionAccepted.hourCode = Reminder.midnightHourCode16
        missionAccepted.player = player

        let missionCompleted = Reminder(context: viewContext)
        missionCompleted.name = Reminder.Labels.missionCompleted.rawValue
        missionCompleted.isInactive = false
        missionCompleted.intervalDays = 1
        missionCompleted.hourCode = Reminder.midnightHourCode16
        missionCompleted.player = player

        let trains = Reminder(context: viewContext)
        trains.name = Reminder.Labels.trains.rawValue
        trains.isInactive = false
        trains.intervalDays = 1
        trains.hourCode = Reminder.closeOfBusinessHourCode16
        trains.player = player

        let stock = Reminder(context: viewContext)
        stock.name = Reminder.Labels.stock.rawValue
        stock.isInactive = false
        stock.intervalDays = 1
        stock.hourCode = Reminder.closeOfBusinessHourCode16
        stock.player = player

        let points = Reminder(context: viewContext)
        points.name = Reminder.Labels.points.rawValue
        points.isInactive = false
        points.intervalDays = 1
        points.hourCode = Reminder.closeOfBusinessHourCode16
        points.player = player

        let missionRewards = Reminder(context: viewContext)
        missionRewards.name = Reminder.Labels.missionRewards.rawValue
        missionRewards.isInactive = false
        missionRewards.intervalDays = 7
        missionRewards.hourCode = Reminder.midnightHourCode16
        missionRewards.player = player

        try viewContext.save()
    }
}
