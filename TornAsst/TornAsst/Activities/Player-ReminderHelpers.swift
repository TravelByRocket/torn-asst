//
//  Daily-CoreDataHelpers.swift
//  TornAsst
//
//  Created by Bryan Costanza on 16 Dec 2021.
//

import Foundation

extension Player {
    var dailyTasks: [Reminder] {
        reminders?.allObjects as? [Reminder] ?? []
    }

    var dailyTasksAlphabetical: [Reminder] {
        dailyTasks.sorted(by: \Reminder.itemName)
    }

    var dailyTasksMidnight: [Reminder] {
        dailyTasksAlphabetical.filter {
            $0.hourCode == Reminder.midnightHourCode16 &&
            $0.intervalDays == 1 &&
            !$0.isInactive
        }
    }

    var dailyTasksCOB: [Reminder] {
        dailyTasksAlphabetical.filter {
            $0.hourCode == Reminder.closeOfBusinessHourCode16 &&
            $0.intervalDays == 1 &&
            !$0.isInactive
        }
    }

    var otherTasks: [Reminder] {
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
        return tasksConsidered.filter { !$0.isInactive }
    }

    var inactiveTasks: [Reminder] {
        dailyTasksAlphabetical.filter { $0.isInactive }
    }

    func getTask(labeled label: String) -> Reminder? {
        dailyTasks.first { item in
            item.name == label
        }
    }

    static var exampleReminder: Reminder {
        let dataController = DataController.preview
        let viewContext = dataController.container.viewContext

        let datedConfig = Reminder(context: viewContext)

        let task = Reminder(context: viewContext)
        task.name = "Energy"
        task.hourCode = Reminder.midnightHourCode16
        task.intervalDays = Int16(1)
        task.isInactive = false

        return datedConfig
    }
}
