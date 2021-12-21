//
//  Daily-CoreDataHelpers.swift
//  TornAsst
//
//  Created by Bryan Costanza on 16 Dec 2021.
//

import Foundation

extension DatedConfig { // maybe `Dated` or `Periodic`
    var dailyTasks: [DatedTask] {
        tasks?.allObjects as? [DatedTask] ?? []
    }

    var dailyTasksAlphabetical: [DatedTask] {
        dailyTasks.sorted(by: \DatedTask.itemLabel)
    }

    var dailySpinTheWheel: [DatedTask] {
        dailyTasks.filter { $0.section == "Spin the Wheel"}
    }

    var dailyRefills: [DatedTask] {
        dailyTasks.filter { $0.section == "Refills"}
    }

    var dailyActions: [DatedTask] {
        dailyTasks.filter { $0.section == "Actions"}
    }

    var dailyJob: [DatedTask] {
        dailyTasks.filter { $0.section == "Job"}
    }

    var dailyTasksMidnight: [DatedTask] {
        dailyTasksAlphabetical.filter {
            $0.triggerHourCode == DatedTask.midnightHourCode16 &&
            $0.intervalDays == 1 &&
            !$0.isHidden
        }
    }

    var dailyTasksCOB: [DatedTask] {
        dailyTasksAlphabetical.filter {
            $0.triggerHourCode == DatedTask.closeOfBusinessHourCode16 &&
            $0.intervalDays == 1 &&
            !$0.isHidden
        }
    }

    var otherTasks: [DatedTask] {
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

    var inactiveTasks: [DatedTask] {
        dailyTasksAlphabetical.filter { $0.isHidden }
    }

    func getTask(labeled label: String) -> DatedTask? {
        dailyTasks.first { item in
            item.label == label
        }
    }

    static var example: DatedConfig {
        let dataController = DataController.preview
        let viewContext = dataController.container.viewContext

        let datedConfig = DatedConfig(context: viewContext)

        let task = DatedTask(context: viewContext)
        task.label = "Energy"
        task.section = "Refills"
        task.triggerHourCode = DatedTask.midnightHourCode16
        task.intervalDays = Int16(1)
        task.isHidden = false
        task.config = datedConfig

        return datedConfig
    }
}
