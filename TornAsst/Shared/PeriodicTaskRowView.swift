//
//  TaskRowView.swift
//  TornAsst
//
//  Created by Bryan Costanza on 17 Dec 2021.
//

import SwiftUI

struct PeriodicTaskRowView: View {
    var highlighted: Bool
    var task: DatedTask

    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    var isInactive: Bool {
        task.isHidden
    }

    var body: some View {
        HStack {
            Button {
                withAnimation {
                    task.isHidden.toggle()
                    dataController.save()
                }
            } label: {
                Label("Hide", systemImage: isInactive ? "arrow.up.circle" : "xmark.circle")
                    .labelStyle(.iconOnly)
            }
            .foregroundColor(isInactive ? .green : .secondary)
            .buttonStyle(BorderlessButtonStyle())
            VStack(alignment: .leading) {
                Text(task.itemLabel)
                    .foregroundColor(highlighted || isInactive ? .secondary : .primary)
                    .underline(!highlighted && !isInactive, color: .orange)
                if task.intervalDays != 1 {
                    Text("Every \(task.intervalDays) days")
                        .italic()
                        .foregroundColor(.secondary)
                        .font(.caption)
                }
            }
            Spacer()
        }
        .animation(.default, value: highlighted)
    }
}

struct TaskRowView_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        Form {
            PeriodicTaskRowView(highlighted: true, task: DatedTask.example)
            PeriodicTaskRowView(highlighted: false, task: DatedTask.example)
            PeriodicTaskRowView(highlighted: true, task: DatedTask.exampleWeekly)
        }
        .environment(\.managedObjectContext, dataController.container.viewContext)
        .environmentObject(dataController)
    }
}
