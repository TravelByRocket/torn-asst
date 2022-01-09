//
//  EnergySection.swift
//  TornAsst
//
//  Created by Bryan Costanza on 11/28/20.
//

import SwiftUI

struct NotifyOptionRowStepper: View {
    let message: String
    @ObservedObject var notice: Notice
    let max: Int
    let step: Int

    @State private var value: Int

    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    var min: Int {
        step
    }

    init(message: String, notice: Notice, max: Int, step: Int) {
        _notice = ObservedObject(wrappedValue: notice)
        _value = State(wrappedValue: notice.noticeOffset)
        self.message = message
        self.max = max
        self.step = step
    }

    var body: some View {
        HStack {
            NoticeToggleRow(message: message, notice: notice)
            Stepper(
                "Custom Multiple",
                value: $value.onChange(update),
                in: min...max,
                step: step)
                .labelsHidden()
        }
        .foregroundColor(notice.isActive ? .accentColor : .secondary)
    }

    func update() {
        notice.travel?.objectWillChange.send()
        notice.noticeOffset = value
        dataController.save()
    }
}

struct NotifyOptionRowStepper_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        List {
            NotifyOptionRowStepper(
                message: "\(Notice.exampleActive.offset) seconds before",
                notice: Notice.exampleActive,
                max: 20,
                step: 1)
            NotifyOptionRowStepper(
                message: "\(Notice.exampleInactive.offset) seconds before",
                notice: Notice.exampleInactive,
                max: 20,
                step: 1)
        }
        .environment(\.managedObjectContext, dataController.container.viewContext)
        .environmentObject(dataController)
    }
}
