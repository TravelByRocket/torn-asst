//
//  DataController-Extension.swift
//  TornAsst
//
//  Created by Bryan Costanza on 16 Dec 2021.
//

import Foundation

extension DataController {
    func createDailyDefaults() throws {
        let viewContext = container.viewContext

        let daily = Daily(context: viewContext)

        let refillEnergy = DatedResetItem(context: viewContext)
        refillEnergy.label = DatedResetItem.Labels.refillEnergy.rawValue
        refillEnergy.isHidden = false
        refillEnergy.intervalDays = 1
        refillEnergy.triggerHourCode = DatedResetItem.midnightHourCode16
        refillEnergy.section = "Refills"
        refillEnergy.daily = daily

        let refillNerve = DatedResetItem(context: viewContext)
        refillNerve.label = DatedResetItem.Labels.refillNerve.rawValue
        refillNerve.isHidden = false
        refillNerve.intervalDays = 1
        refillNerve.triggerHourCode = DatedResetItem.midnightHourCode16
        refillNerve.section = "Refills"
        refillNerve.daily = daily

        let wheelOfAwesome = DatedResetItem(context: viewContext)
        wheelOfAwesome.label = DatedResetItem.Labels.wheelOfAwesome.rawValue
        wheelOfAwesome.isHidden = false
        wheelOfAwesome.intervalDays = 1
        wheelOfAwesome.triggerHourCode = DatedResetItem.midnightHourCode16
        wheelOfAwesome.section = "Spin the Wheel"
        wheelOfAwesome.daily = daily

        let wheelOfMediocrity = DatedResetItem(context: viewContext)
        wheelOfMediocrity.label = DatedResetItem.Labels.wheelOfMediocrity.rawValue
        wheelOfMediocrity.isHidden = false
        wheelOfMediocrity.intervalDays = 1
        wheelOfMediocrity.triggerHourCode = DatedResetItem.midnightHourCode16
        wheelOfMediocrity.section = "Spin the Wheel"
        wheelOfMediocrity.daily = daily

        let wheelOfLame = DatedResetItem(context: viewContext)
        wheelOfLame.label = DatedResetItem.Labels.wheelOfLame.rawValue
        wheelOfLame.isHidden = false
        wheelOfLame.intervalDays = 1
        wheelOfLame.triggerHourCode = DatedResetItem.midnightHourCode16
        wheelOfLame.section = "Spin the Wheel"
        wheelOfLame.daily = daily

        let cityPurchases = DatedResetItem(context: viewContext)
        cityPurchases.label = DatedResetItem.Labels.cityPurchases.rawValue
        cityPurchases.isHidden = false
        cityPurchases.intervalDays = 1
        cityPurchases.triggerHourCode = DatedResetItem.midnightHourCode16
        cityPurchases.section = "Actions"
        cityPurchases.daily = daily

        let missionAccepted = DatedResetItem(context: viewContext)
        missionAccepted.label = DatedResetItem.Labels.missionAccepted.rawValue
        missionAccepted.isHidden = false
        missionAccepted.intervalDays = 1
        missionAccepted.triggerHourCode = DatedResetItem.midnightHourCode16
        missionAccepted.section = "Actions"
        missionAccepted.daily = daily

        let missionCompleted = DatedResetItem(context: viewContext)
        missionCompleted.label = DatedResetItem.Labels.missionCompleted.rawValue
        missionCompleted.isHidden = false
        missionCompleted.intervalDays = 1
        missionCompleted.triggerHourCode = DatedResetItem.midnightHourCode16
        missionCompleted.section = "Actions"
        missionCompleted.daily = daily

        let trains = DatedResetItem(context: viewContext)
        trains.label = DatedResetItem.Labels.trains.rawValue
        trains.isHidden = false
        trains.intervalDays = 1
        trains.triggerHourCode = DatedResetItem.closeOfBusinessHourCode16
        trains.section = "Job"
        trains.daily = daily

        let stock = DatedResetItem(context: viewContext)
        stock.label = DatedResetItem.Labels.stock.rawValue
        stock.isHidden = false
        stock.intervalDays = 1
        stock.triggerHourCode = DatedResetItem.closeOfBusinessHourCode16
        stock.section = "Job"
        stock.daily = daily

        let points = DatedResetItem(context: viewContext)
        points.label = DatedResetItem.Labels.points.rawValue
        points.isHidden = false
        points.intervalDays = 1
        points.triggerHourCode = DatedResetItem.closeOfBusinessHourCode16
        points.section = "Job"
        points.daily = daily

        let missionRewards = DatedResetItem(context: viewContext)
        missionRewards.label = DatedResetItem.Labels.missionRewards.rawValue
        missionRewards.isHidden = false
        missionRewards.intervalDays = 7
        missionRewards.triggerHourCode = DatedResetItem.midnightHourCode16
        missionRewards.section = ""
        missionRewards.daily = daily

        try viewContext.save()
    }
}
