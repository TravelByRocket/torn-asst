//
//  PeriodicSectionView.swift
//  TornAsst
//
//  Created by Bryan Costanza on 17 Dec 2021.
//

import SwiftUI

struct ReminderGroupSectionView: View {
    let systemImage: String
    let message: String
    let color: Color
    let date: Date?
    let tasks: [Reminder]

    var body: some View {
        Section {
            BigSectionBarView(
                systemImage: systemImage,
                message: message,
                color: color,
                date: date
            )
            ForEach(tasks) {task in
                if !task.isInactive {
                    PeriodicTaskToggleView(task: task)
                } else {
                    PeriodicTaskRowView(highlighted: false, task: task)
                }
            }
            NotificationHandlingPreferenceView(color: .orange, handling: NoticeHandling.exampleAllNormal)
            NoticeAdjustRow(parent: Travel.example)
        }
    }
}

struct PeriodicSectionView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            ReminderGroupSectionView(
                systemImage: "moon.stars",
                message: "Some Message",
                color: .purple,
                date: Date.nextMidnight,
            tasks: [Reminder.example, Reminder.example])
        }
    }
}
