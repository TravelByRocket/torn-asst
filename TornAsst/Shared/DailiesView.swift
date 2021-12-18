//
//  Dailies.swift
//  TornAsst
//
//  Created by Bryan Costanza on 13 Dec 2021.
//

import SwiftUI

struct DailiesView: View {
    static let tag: String = "Dailies"
    @State private var refreshDate = Date.nextQuarterHour

    @FetchRequest(
        entity: Daily.entity(),
        sortDescriptors: [],
        predicate: nil) private var dailies: FetchedResults<Daily>

    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    let timer = Timer.publish(every: Date.nextQuarterHour.timeIntervalSinceNow, on: .main, in: .common).autoconnect()

    var daily: Daily {
        if let onlyOne = dailies.first {
            return onlyOne
        } else {
            try? dataController.createDailyDefaults()
        }
        return dailies.first ?? Daily.example
    }

    let labels = DatedResetItem.Labels.self // swiftling:ignore

    var body: some View {
        Form {
            Section {
                BigSectionBarView(
                    systemImage: "moon.stars",
                    message: "Reset at Midnight",
                    color: .purple,
                    date: Date.nextMidnight
                )
                ForEach(daily.dailyTasksMidnight) {task in
                    DailyToggleView(task: task)
                }
            }
            Section {
                BigSectionBarView(
                    systemImage: "sunset",
                    message: "Reset at C.O.B.",
                    color: .cyan,
                    date: Date.nextCloseOfBusiness
                )
                ForEach(daily.dailyTasksCOB) {task in
                    DailyToggleView(task: task)
                }
            }
            Section {
                BigSectionBarView(
                    systemImage: "scribble.variable",
                    message: "Other",
                    color: .indigo,
                    date: nil
                )
                ForEach(daily.otherTasks) {task in
                    DailyToggleView(task: task)
                }
                Text("Next Quarter Hour in \(refreshDate, style: .timer)")
                    .onReceive(timer) { _ in
                        refreshDate = Date.nextQuarterHour
                    }
            }
            BigSectionBarView(
                systemImage: "xmark.circle",
                message: "Hidden",
                color: .gray,
                date: nil
            )
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
