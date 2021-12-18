//
//  TaskRowView.swift
//  TornAsst
//
//  Created by Bryan Costanza on 17 Dec 2021.
//

import SwiftUI

struct PeriodicTaskRowView: View {
    @Binding var completed: Bool
    @ObservedObject var task: DatedResetItem

    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some View {
        HStack {
            Button {
                withAnimation(.easeInOut) {
                    task.daily?.objectWillChange.send()
                    task.isHidden.toggle()
                    dataController.save()
                }
            } label: {
                Label("Hide", systemImage: task.isHidden ? "arrow.up.circle" : "xmark.circle")
                    .labelStyle(.iconOnly)
            }
            .foregroundColor(task.isHidden ? .green : .secondary)
            .buttonStyle(BorderlessButtonStyle())
            VStack(alignment: .leading) {
                Text(task.itemLabel)
                    .foregroundColor(completed || task.isHidden ? .secondary : .primary)
                    .underline(!completed && !task.isHidden, color: .orange)
                if task.intervalDays != 1 {
                    Text("Every \(task.intervalDays) days")
                        .italic()
                        .foregroundColor(.secondary)
                        .font(.caption)
                }
            }
            Spacer()
        }
        .animation(.default, value: completed)
    }
}

struct TaskRowView_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        Form {
            PeriodicTaskRowView(completed: .constant(true), task: DatedResetItem.example)
            PeriodicTaskRowView(completed: .constant(true), task: DatedResetItem.exampleWeekly)
        }
        .environment(\.managedObjectContext, dataController.container.viewContext)
        .environmentObject(dataController)
    }
}
