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

        let daily = DatedConfig(context: viewContext)

        let refillEnergy = DatedTask(context: viewContext)
        refillEnergy.label = DatedTask.Labels.refillEnergy.rawValue
        refillEnergy.isHidden = false
        refillEnergy.intervalDays = 1
        refillEnergy.triggerHourCode = DatedTask.midnightHourCode16
        refillEnergy.section = "Refills"
        refillEnergy.config = daily

        let refillNerve = DatedTask(context: viewContext)
        refillNerve.label = DatedTask.Labels.refillNerve.rawValue
        refillNerve.isHidden = false
        refillNerve.intervalDays = 1
        refillNerve.triggerHourCode = DatedTask.midnightHourCode16
        refillNerve.section = "Refills"
        refillNerve.config = daily

        let wheelOfAwesome = DatedTask(context: viewContext)
        wheelOfAwesome.label = DatedTask.Labels.wheelOfAwesome.rawValue
        wheelOfAwesome.isHidden = false
        wheelOfAwesome.intervalDays = 1
        wheelOfAwesome.triggerHourCode = DatedTask.midnightHourCode16
        wheelOfAwesome.section = "Spin the Wheel"
        wheelOfAwesome.config = daily

        let wheelOfMediocrity = DatedTask(context: viewContext)
        wheelOfMediocrity.label = DatedTask.Labels.wheelOfMediocrity.rawValue
        wheelOfMediocrity.isHidden = false
        wheelOfMediocrity.intervalDays = 1
        wheelOfMediocrity.triggerHourCode = DatedTask.midnightHourCode16
        wheelOfMediocrity.section = "Spin the Wheel"
        wheelOfMediocrity.config = daily

        let wheelOfLame = DatedTask(context: viewContext)
        wheelOfLame.label = DatedTask.Labels.wheelOfLame.rawValue
        wheelOfLame.isHidden = false
        wheelOfLame.intervalDays = 1
        wheelOfLame.triggerHourCode = DatedTask.midnightHourCode16
        wheelOfLame.section = "Spin the Wheel"
        wheelOfLame.config = daily

        let cityPurchases = DatedTask(context: viewContext)
        cityPurchases.label = DatedTask.Labels.cityPurchases.rawValue
        cityPurchases.isHidden = false
        cityPurchases.intervalDays = 1
        cityPurchases.triggerHourCode = DatedTask.midnightHourCode16
        cityPurchases.section = "Actions"
        cityPurchases.config = daily

        let missionAccepted = DatedTask(context: viewContext)
        missionAccepted.label = DatedTask.Labels.missionAccepted.rawValue
        missionAccepted.isHidden = false
        missionAccepted.intervalDays = 1
        missionAccepted.triggerHourCode = DatedTask.midnightHourCode16
        missionAccepted.section = "Actions"
        missionAccepted.config = daily

        let missionCompleted = DatedTask(context: viewContext)
        missionCompleted.label = DatedTask.Labels.missionCompleted.rawValue
        missionCompleted.isHidden = false
        missionCompleted.intervalDays = 1
        missionCompleted.triggerHourCode = DatedTask.midnightHourCode16
        missionCompleted.section = "Actions"
        missionCompleted.config = daily

        let trains = DatedTask(context: viewContext)
        trains.label = DatedTask.Labels.trains.rawValue
        trains.isHidden = false
        trains.intervalDays = 1
        trains.triggerHourCode = DatedTask.closeOfBusinessHourCode16
        trains.section = "Job"
        trains.config = daily

        let stock = DatedTask(context: viewContext)
        stock.label = DatedTask.Labels.stock.rawValue
        stock.isHidden = false
        stock.intervalDays = 1
        stock.triggerHourCode = DatedTask.closeOfBusinessHourCode16
        stock.section = "Job"
        stock.config = daily

        let points = DatedTask(context: viewContext)
        points.label = DatedTask.Labels.points.rawValue
        points.isHidden = false
        points.intervalDays = 1
        points.triggerHourCode = DatedTask.closeOfBusinessHourCode16
        points.section = "Job"
        points.config = daily

        let missionRewards = DatedTask(context: viewContext)
        missionRewards.label = DatedTask.Labels.missionRewards.rawValue
        missionRewards.isHidden = false
        missionRewards.intervalDays = 7
        missionRewards.triggerHourCode = DatedTask.midnightHourCode16
        missionRewards.section = ""
        missionRewards.config = daily

        try viewContext.save()
    }
}
