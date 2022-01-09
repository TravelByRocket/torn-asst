//
//  ClockOffsetView.swift
//  TornAsst
//
//  Created by Bryan Costanza on 19 Dec 2021.
//

import SwiftUI

struct ClockOffsetView: View {
    @State private var timeOffset: Int

    @EnvironmentObject var player: Player
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    init(player: Player) {
        _timeOffset = State(initialValue: player.playerClockOffset)
    }

    static var offsetNote: some View {
        Text("Positive values make in-app events occur before in-game events. Default is +02 seconds.")
                .font(.caption)
                .foregroundColor(.secondary)
    }

    var fastSlowNone: String {
        if timeOffset > 0 {
            return " (i.e., fast)"
        } else if timeOffset < 0 {
            return " (i.e., slow)"
        } else {
            return " (i.e., on time)"
        }
    }

    var body: some View {
        VStack {
            BigSectionBarView(
                systemImage: "clock.arrow.2.circlepath",
                message: "Clock Offset",
                color: .accentColor)
            Stepper(
                "\(timeOffset, specifier: "%+02d") Seconds\(fastSlowNone)",
                value: $timeOffset,
                in: -10...30,
                step: 1)
                .monospacedDigit()
                .onChange(of: timeOffset) { newValue in
                    player.playerClockOffset = newValue
                    dataController.save()
                }
        }
    }
}

struct ClockOffsetView_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        Form {
            Section(footer: ClockOffsetView.offsetNote) {
                ClockOffsetView(player: Player.example)
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .environmentObject(dataController)
                    .environmentObject(Player.example)
            }
        }
    }
}
