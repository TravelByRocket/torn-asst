//
//  DailyToggleView.swift
//  TornAsst
//
//  Created by Bryan Costanza on 15 Dec 2021.
//

import SwiftUI

struct PeriodicTaskToggleView: View {
    @State private var completed = false
    @ObservedObject var task: DatedResetItem

    init(task: DatedResetItem) {
        _task = ObservedObject(wrappedValue: task)
        _completed = State(wrappedValue: task.isCompletedThisPeriod)
    }

    var body: some View {
        if task.isHidden {
            PeriodicTaskRowView(completed: $completed, task: task)
        } else {
            Toggle(isOn: $completed) {
                PeriodicTaskRowView(completed: $completed, task: task)
            }
            .onChange(of: completed) { isNowCompleted in
                task.daily?.objectWillChange.send()
                task.objectWillChange.send()
                if isNowCompleted {
                    task.dateCompleted = Date()
                } else {
                    task.dateCompleted = nil
                }
            }
        }
    }
}

struct PeriodicToggleView_Previews: PreviewProvider {
    @ObservedObject static var task = DatedResetItem.example

    static var previews: some View {
        Form {
            PeriodicTaskToggleView(task: task)
            Text(task.dateCompleted.debugDescription)
        }
    }
}
