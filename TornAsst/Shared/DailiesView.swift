//
//  Dailies.swift
//  TornAsst
//
//  Created by Bryan Costanza on 13 Dec 2021.
//

import SwiftUI

struct DailiesView: View {
    static let tag: String = "Dailies"

    @FetchRequest(
        entity: DatedResetItem.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \DatedResetItem.label, ascending: true)
        ]
    ) private var tasks: FetchedResults<DatedResetItem>

    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    var tasksAlphabetical: [DatedResetItem] {
        tasks.sorted(by: \DatedResetItem.itemLabel)
    }

    var tasksMidnight: [DatedResetItem] {
        tasksAlphabetical.filter { task in
            task.triggerHourCode == DatedResetItem.midnightHourCode16 &&
            task.intervalDays == 1 &&
            !task.isHidden
        }
    }

    var tasksCOB: [DatedResetItem] {
        tasksAlphabetical.filter { task in
            task.triggerHourCode == DatedResetItem.closeOfBusinessHourCode16 &&
            task.intervalDays == 1 &&
            !task.isHidden
        }
    }

    var tasksOther: [DatedResetItem] {
        tasksAlphabetical.filter { task in
            (
                task.triggerHourCode != DatedResetItem.midnightHourCode16 &&
                task.triggerHourCode != DatedResetItem.closeOfBusinessHourCode16
            ) || task.intervalDays != 1 && !task.isHidden
        }
    }

    var tasksInactive: [DatedResetItem] {
        tasksAlphabetical.filter { task in
            task.isHidden
        }
    }

    let labels = DatedResetItem.Labels.self // swiftling:ignore

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

struct DailiesView_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        DailiesView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
