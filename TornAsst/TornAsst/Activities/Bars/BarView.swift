//
//  BarView.swift
//  TornAsst
//
//  Created by Bryan Costanza on 8 Jan 2022.
//

import SwiftUI

struct BarView: View {
    let color: Color
    @ObservedObject var bar: Bar

    @State private var multiplesOf: Int
    @State private var valueOf: Int

    @State private var notifyForMultiples: Bool
    @State private var notifyForValue: Bool
    @State private var notifyWhenFull: Bool

    @EnvironmentObject var player: Player
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    init(color: Color, bar: Bar) {
        self.color = color
        _bar = ObservedObject(initialValue: bar)

        _multiplesOf = State(initialValue: bar.barSettings.barMultiplesOf)
        _valueOf = State(initialValue: bar.barSettings.barValueOf)

        _notifyForMultiples = State(initialValue: bar.barSettings.notifyForMultiples)
        _notifyForValue = State(initialValue: bar.barSettings.notifyForValue)
        _notifyWhenFull = State(initialValue: bar.barSettings.notifyWhenFull)
    }

    var body: some View {
        IndicatorRow(color: color, bar: bar)
        NotificationHandlingPreferenceView(color: color, handling: bar.barNoticeHandling)
        HStack {
            Button {
                notifyForValue.toggle()
                dataController.save()
            } label: {
                Label(
                    "Value of \(valueOf)",
                    systemImage: notifyForValue ? "bell" : "bell.slash")
                    .foregroundColor(notifyForValue ? .accentColor : .secondary)
            }
            Spacer()
            Stepper(
                "Value of \(valueOf)",
                value: $valueOf.onChange(update),
                in: bar.barIncrement...(bar.barMaximum - bar.barIncrement),
                step: bar.barIncrement)
                .labelsHidden()
        }
        HStack {
            Button {
                notifyForMultiples.toggle()
                dataController.save()
            } label: {
                HStack {
                    Image(systemName: notifyForMultiples ? "bell" : "bell.slash")
                        .foregroundColor(notifyForMultiples ? .accentColor : .secondary)
                        .padding(4) // match padding of Label
                    VStack(alignment: .leading) {
                        Text("Multiples of \(multiplesOf)")
                            .foregroundColor(notifyForMultiples ? .accentColor : .secondary)
                        Text(bar.validMultiples(of: multiplesOf).map { String($0) }.joined(separator: ", "))
                            .font(.caption)
                            .italic()
                            .foregroundColor(notifyForMultiples ? .primary : .secondary)
                            .lineLimit(1)
                    }
                }
            }
            Spacer()
            Stepper(
                "Value of \(valueOf)",
                value: $multiplesOf.onChange(update),
                in: bar.barIncrement...(bar.barMaximum - bar.barIncrement),
                step: bar.barIncrement)
                .labelsHidden()
        }
        Button {
            notifyWhenFull.toggle()
            dataController.save()
        } label: {
            Label(
                "When Full",
                systemImage: notifyWhenFull ? "bell" : "bell.slash")
                .foregroundColor(notifyWhenFull ? .accentColor : .secondary)
        }
    }

    func update() {
        bar.barSettings.notifyWhenFull = notifyWhenFull
        bar.barSettings.notifyForMultiples = notifyForMultiples
        bar.barSettings.notifyForValue = notifyForValue
        bar.barSettings.barMultiplesOf = multiplesOf
        bar.barSettings.barValueOf = valueOf
        dataController.save()
    }
}

struct BarView_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        List {
            Section {
                BarView(color: .purple, bar: Bar.exampleEnergy)
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .environmentObject(dataController)
                    .environmentObject(Player.example)
            }
        }
    }
}
