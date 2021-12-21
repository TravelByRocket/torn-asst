//
//  DailyToggleView.swift
//  TornAsst
//
//  Created by Bryan Costanza on 15 Dec 2021.
//

import SwiftUI

struct PeriodicTaskToggleView: View {
    @State private var completed = false
    var task: DatedTask

    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    init(task: DatedTask) {
        self.task = task
        _completed = State(wrappedValue: task.isCompletedThisPeriod)
    }

    var body: some View {
        Toggle(isOn: $completed) {
            PeriodicTaskRowView(highlighted: completed, task: task)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(
                deadline: .now() + task.nextReset.timeIntervalSinceNow) {
                    completed = false
                }
        }
        .onChange(of: completed) { isNowCompleted in
            if isNowCompleted {
                task.dateCompleted = Date()
            } else {
                task.dateCompleted = nil
            }
            dataController.save()
        }
    }
}

struct PeriodicToggleView_Previews: PreviewProvider {
    static var task = DatedTask.example
    static var dataController = DataController.preview

    static var previews: some View {
        Form {
            PeriodicTaskToggleView(task: DatedTask.example)
            PeriodicTaskToggleView(task: DatedTask.exampleWeekly)
        }
        .environment(\.managedObjectContext, dataController.container.viewContext)
        .environmentObject(dataController)
    }
}
