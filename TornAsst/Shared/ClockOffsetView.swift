//
//  ClockOffsetView.swift
//  TornAsst
//
//  Created by Bryan Costanza on 19 Dec 2021.
//

import SwiftUI

struct ClockOffsetView: View {
    @State private var timeOffset = 2

    static var offsetNote: some View {
        Text("Positive values make in-app events occur before in-game events. Default is +02 seconds.")
                .font(.caption)
                .foregroundColor(.secondary)
    }

    var body: some View {
        VStack {
            BigSectionBarView(
                systemImage: "clock.arrow.2.circlepath",
                message: "Clock Offset",
                color: .accentColor)
            Stepper(
                "Advance \(timeOffset, specifier: "%+02d") Seconds",
                value: $timeOffset,
                in: -10...30,
                step: 1)
        }
    }
}

struct ClockOffsetView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            Section(footer: ClockOffsetView.offsetNote) {
                ClockOffsetView()
            }
        }
    }
}
