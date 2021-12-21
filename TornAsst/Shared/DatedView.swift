//
//  Dailies.swift
//  TornAsst
//
//  Created by Bryan Costanza on 13 Dec 2021.
//

import SwiftUI

struct DatedView: View {
    static let tag: String = "Dailies"

    @FetchRequest(
        entity: DatedTask.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \DatedTask.label, ascending: true)
        ]
    ) private var tasks: FetchedResults<DatedTask>

    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    var tasksAlphabetical: [DatedTask] {
        tasks.sorted(by: \DatedTask.itemLabel)
    }

    var tasksMidnight: [DatedTask] {
        tasksAlphabetical.filter { task in
            task.triggerHourCode == DatedTask.midnightHourCode16 &&
            task.intervalDays == 1 &&
            !task.isHidden
        }
    }

    var tasksCOB: [DatedTask] {
        tasksAlphabetical.filter { task in
            task.triggerHourCode == DatedTask.closeOfBusinessHourCode16 &&
            task.intervalDays == 1 &&
            !task.isHidden
        }
    }

    var tasksOther: [DatedTask] {
        tasksAlphabetical.filter { task in
            (
                task.triggerHourCode != DatedTask.midnightHourCode16 &&
                task.triggerHourCode != DatedTask.closeOfBusinessHourCode16
            ) || task.intervalDays != 1 && !task.isHidden
        }
    }

    var tasksInactive: [DatedTask] {
        tasksAlphabetical.filter { task in
            task.isHidden
        }
    }

    let labels = DatedTask.Labels.self // swiftling:ignore

    var body: some View {
        Form {
            PeriodicSectionView(
                systemImage: "moon.stars",
                message: "Reset at Midnight",
                color: .purple,
                date: Date.nextMidnight,
                tasks: tasksMidnight)
            PeriodicSectionView(
                systemImage: "sunset",
                message: "Reset at C.O.B.",
                color: .cyan,
                date: Date.nextCloseOfBusiness,
                tasks: tasksCOB)
            PeriodicSectionView(
                systemImage: "scribble.variable",
                message: "Other",
                color: .indigo,
                date: nil,
                tasks: tasksOther)
            PeriodicSectionView(
                systemImage: "xmark.circle",
                message: "Inactive",
                color: .gray,
                date: nil,
                tasks: tasksInactive)
        }
        .onAppear {
            if tasks.isEmpty {
                try? dataController.createDailyDefaults()
            }
        }
    }
}

struct DatedView_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        DatedView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
