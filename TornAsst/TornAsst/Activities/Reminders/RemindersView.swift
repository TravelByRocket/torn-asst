//
//  Dailies.swift
//  TornAsst
//
//  Created by Bryan Costanza on 13 Dec 2021.
//

import SwiftUI

struct RemindersView: View {
    static let tag: String = "Reminders"

    @FetchRequest(
        entity: Reminder.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Reminder.name, ascending: true)
        ]
    ) private var tasks: FetchedResults<Reminder>

//    var tasks: [Reminder] {
//        let tasks = player.reminders?.allObjects as? [Reminder] ?? []
//        if tasks.isEmpty {
//        print(tasks.count)
//        return tasks
//    }

    @EnvironmentObject var player: Player
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    var tasksAlphabetical: [Reminder] {
        tasks.sorted(by: \Reminder.itemName)
    }

    var tasksMidnight: [Reminder] {
        tasksAlphabetical.filter { task in
            task.hourCode == Reminder.midnightHourCode16 &&
            task.intervalDays == 1 &&
            !task.isInactive
        }
    }

    var tasksCOB: [Reminder] {
        tasksAlphabetical.filter { task in
            task.hourCode == Reminder.closeOfBusinessHourCode16 &&
            task.intervalDays == 1 &&
            !task.isInactive
        }
    }

    var tasksOther: [Reminder] {
        tasksAlphabetical.filter { task in
            (
                task.hourCode != Reminder.midnightHourCode16 &&
                task.hourCode != Reminder.closeOfBusinessHourCode16
            ) || task.intervalDays != 1 && !task.isInactive
        }
    }

    var tasksInactive: [Reminder] {
        tasksAlphabetical.filter { task in
            task.isInactive
        }
    }

    let labels = Reminder.Labels.self // swiftling:ignore

    var body: some View {
        Form {
            MarketplaceTicksRow()
            ReminderGroupSectionView(
                systemImage: "moon.stars",
                message: "Reset at Midnight",
                color: .purple,
                date: Date.nextMidnight,
                tasks: tasksMidnight)
            ReminderGroupSectionView(
                systemImage: "sunset",
                message: "Reset at C.O.B.",
                color: .cyan,
                date: Date.nextCloseOfBusiness,
                tasks: tasksCOB)
            ReminderGroupSectionView(
                systemImage: "scribble.variable",
                message: "Other",
                color: .indigo,
                date: nil,
                tasks: tasksOther)
            ReminderGroupSectionView(
                systemImage: "xmark.circle",
                message: "Inactive",
                color: .gray,
                date: nil,
                tasks: tasksInactive)
        }
        .onAppear {
            if tasks.isEmpty {
                player.objectWillChange.send()
                try? dataController.createDailyDefaults(player: player)
                dataController.save()
            }
        }
    }
}

struct RemindersView_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        RemindersView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
            .environmentObject(Player.example)
    }
}
