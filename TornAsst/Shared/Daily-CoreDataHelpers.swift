//
//  Daily-CoreDataHelpers.swift
//  TornAsst
//
//  Created by Bryan Costanza on 16 Dec 2021.
//

import Foundation

extension Daily { // maybe `Dated` or `Periodic`
    var dailyTasks: [DatedResetItem] {
        tasks?.allObjects as? [DatedResetItem] ?? []
    }

    var dailyTasksAlphabetical: [DatedResetItem] {
        dailyTasks.sorted(by: \DatedResetItem.itemLabel)
    }

    var dailySpinTheWheel: [DatedResetItem] {
        dailyTasks.filter { $0.section == "Spin the Wheel"}
    }

    var dailyRefills: [DatedResetItem] {
        dailyTasks.filter { $0.section == "Refills"}
    }

    var dailyActions: [DatedResetItem] {
        dailyTasks.filter { $0.section == "Actions"}
    }

    var dailyJob: [DatedResetItem] {
        dailyTasks.filter { $0.section == "Job"}
    }

    var dailyTasksMidnight: [DatedResetItem] {
        dailyTasksAlphabetical.filter {
            $0.triggerHourCode == DatedResetItem.midnightHourCode16 &&
            $0.intervalDays == 1 &&
            !$0.isHidden
        }
    }

    var dailyTasksCOB: [DatedResetItem] {
        dailyTasksAlphabetical.filter {
            $0.triggerHourCode == DatedResetItem.closeOfBusinessHourCode16 &&
            $0.intervalDays == 1 &&
            !$0.isHidden
        }
    }

    var otherTasks: [DatedResetItem] {
        var tasksConsidered = dailyTasksAlphabetical
        for midnightly in dailyTasksMidnight {
            if let index = tasksConsidered.firstIndex(of: midnightly) {
                tasksConsidered.remove(at: index)
            }
        }
        for cob in dailyTasksCOB {
            if let index = tasksConsidered.firstIndex(of: cob) {
                tasksConsidered.remove(at: index)
            }
        }
        return tasksConsidered.filter { !$0.isHidden }
    }

    var inactiveTasks: [DatedResetItem] {
        dailyTasksAlphabetical.filter { $0.isHidden }
    }

    func getTask(labeled label: String) -> DatedResetItem? {
        dailyTasks.first { item in
            item.label == label
        }
    }

    static var example: Daily {
        let dataController = DataController.preview
        let viewContext = dataController.container.viewContext

        let daily = Daily(context: viewContext)

        let task = DatedResetItem(context: viewContext)
        task.label = "Energy"
        task.section = "Refills"
        task.triggerHourCode = DatedResetItem.midnightHourCode16
        task.intervalDays = Int16(1)
        task.isHidden = false
        task.daily = daily

        return daily
    }
}
