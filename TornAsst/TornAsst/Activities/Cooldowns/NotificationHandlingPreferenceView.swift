//
//  NotificationHandlingPreferenceView.swift
//  TornAsst
//
//  Created by Bryan Costanza on 2 Jan 2022.
//

import SwiftUI

struct NotificationHandlingPreferenceView: View {
    let color: Color
    let handling: NoticeHandling

    @State private var traveling: NoticeHandling.Strategy
    @State private var hospitalized: NoticeHandling.Strategy
    @State private var jailed: NoticeHandling.Strategy

    @State var previewing: Bool

    @EnvironmentObject var player: Player
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    init(color: Color, handling: NoticeHandling, previewing: Bool = false) {
        self.color = color
        self.handling = handling
        _traveling = State(initialValue: handling.noticeWhileTraveling)
        _jailed = State(initialValue: handling.noticeWhileJailed)
        _hospitalized = State(initialValue: handling.noticeWhileHospitalized)
        _previewing = State(initialValue: previewing)
    }

    var travelLabel: some View {
        Label("Traveling", systemImage: "airplane")
    }

    var hospitalLabel: some View {
        Label("Hospitalized", systemImage: "cross")
    }

    var jailLabel: some View {
        Label("Jailed", image: "face.smiling.upsidedown")
    }

    var body: some View {
        DisclosureGroup(isExpanded: $previewing) {
            VStack(alignment: .leading) {
                travelLabel
                Picker(selection: $traveling.onChange(update)) {
                    Text("Normal").tag(NoticeHandling.Strategy.normal)
                    Text("Defer").tag(NoticeHandling.Strategy.defer)
                    Text("Skip").tag(NoticeHandling.Strategy.skip)
                } label: {
                    travelLabel
                }
                .pickerStyle(.segmented)
            }
            VStack(alignment: .leading) {
                hospitalLabel
                Picker(selection: $hospitalized.onChange(update)) {
                    Text("Normal").tag(NoticeHandling.Strategy.normal)
                    Text("Defer").tag(NoticeHandling.Strategy.defer)
                    Text("Skip").tag(NoticeHandling.Strategy.skip)
                } label: {
                    hospitalLabel
                }
                .pickerStyle(.segmented)
            }
            VStack(alignment: .leading) {
                jailLabel
                Picker(selection: $jailed.onChange(update)) {
                    Text("Normal").tag(NoticeHandling.Strategy.normal)
                    Text("Defer").tag(NoticeHandling.Strategy.defer)
                    Text("Skip").tag(NoticeHandling.Strategy.skip)
                } label: {
                    jailLabel
                }
                .pickerStyle(.segmented)
            }
        } label: {
            Label("Notification Handling", systemImage: "hand.raised")
        }
        .foregroundColor(color)
    }
    func update() {
        dataController.save()
    }
}

struct NotificationHandlingPreferenceView_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        Form {
            NotificationHandlingPreferenceView(
                color: .green,
                handling: NoticeHandling.exampleAllDefer,
                previewing: true)
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
                .environmentObject(Player.example)
        }
    }
}
