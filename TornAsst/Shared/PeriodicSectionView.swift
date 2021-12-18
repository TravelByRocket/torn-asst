//
//  PeriodicSectionView.swift
//  TornAsst
//
//  Created by Bryan Costanza on 17 Dec 2021.
//

import SwiftUI

struct PeriodicSectionView: View {
    let systemImage: String
    let message: String
    let color: Color
    let date: Date?
    let tasks: [DatedResetItem]

    var body: some View {
        Section {
            BigSectionBarView(
                systemImage: systemImage,
                message: message,
                color: color,
                date: date
            )
            ForEach(tasks) {task in
                PeriodicTaskToggleView(task: task)
            }
        }
    }
}

struct PeriodicSectionView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            PeriodicSectionView(
                systemImage: "moon.stars",
                message: "Some Message",
                color: .purple,
                date: Date.nextMidnight,
            tasks: [DatedResetItem.example, DatedResetItem.example])
        }
    }
}
