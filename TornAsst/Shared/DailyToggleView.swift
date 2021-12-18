//
//  DailyToggleView.swift
//  TornAsst
//
//  Created by Bryan Costanza on 15 Dec 2021.
//

import SwiftUI

struct DailyToggleView: View {
    @State private var completed = false
    
    let message: String
    let task: DatedResetItem
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    
    init(task: DatedResetItem) {
        self.task = task
        message = task.label ?? "New Task"
        _completed = State(wrappedValue: task.isCompletedThisPeriod)
    }
    
    @available(*, deprecated)
    init(message: String) {
        self.task = DatedResetItem.example
        self.message = message
    }
    
    var body: some View {
        Toggle(isOn: $completed) {
            HStack {
                Text(message)
                    .foregroundColor(completed ? .secondary : .primary)
                    .underline(!completed, color: .orange)
                Spacer()
            }
            .animation(.default, value: completed)
        }
        .onChange(of: completed) { isNowCompleted in
            if isNowCompleted {
                task.dateCompleted = Date()
            } else {
                task.dateCompleted = nil
            }
        }
    }
}

struct DailyToggleView_Previews: PreviewProvider {
    static var dataController = DataController.preview
    
    static var previews: some View {
        Form {
            DailyToggleView(task: DatedResetItem.example)
        }
        .environment(\.managedObjectContext, dataController.container.viewContext)
        .environmentObject(dataController)
    }
}
