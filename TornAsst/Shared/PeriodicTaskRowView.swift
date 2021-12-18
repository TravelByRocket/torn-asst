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

    var body: some View {
        HStack {
            Button {
                withAnimation(.easeInOut) {
                    task.daily?.objectWillChange.send()
                    task.dateCompleted = nil
                    task.isHidden.toggle()
                }
                completed = false // add behavior is placed inside withAnimation
            } label: {
                Label("Hide", systemImage: task.isHidden ? "arrow.up.circle" : "xmark.circle")
                    .labelStyle(.iconOnly)
            }
            .foregroundColor(task.isHidden ? .green : .secondary)
            .buttonStyle(BorderlessButtonStyle())
            Text(task.itemLabel)
                .foregroundColor(completed || task.isHidden ? .secondary : .primary)
                .underline(!completed && !task.isHidden, color: .orange)
            Spacer()
        }
        .animation(.default, value: completed)
    }
}

struct TaskRowView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            PeriodicTaskRowView(completed: .constant(true), task: DatedResetItem.example)
        }
    }
}
