//
//  AddAdjustItemRow.swift
//  TornAsst
//
//  Created by Bryan Costanza on 23 Dec 2021.
//

import SwiftUI

struct AddAdjustItemRow: View {
    let isOutbound: Bool
    let travel: Travel

    @State private var isAddingItem = false
    @State private var minutes = 0.0
    @State private var seconds = 0.0

    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some View {
        DisclosureGroup(isExpanded: $isAddingItem) {
            VStack(alignment: .leading) {
                HStack {
                    Text("\(Int(seconds), specifier: "% 2d") sec")
                        .font(.body.monospaced())
                    Slider(value: $seconds, in: 0 ... 59, step: 1.0)
                }
                HStack {
                    Text("\(Int(minutes), specifier: "% 2d") min")
                        .font(.body.monospaced())
                    Slider(value: $minutes, in: 0 ... 59, step: 1.0)
                }
                Button {
                    withAnimation {
                        let notice = Notice(context: managedObjectContext)
                        notice.noticeOffset = Int(minutes * 60 + seconds)
                        notice.id = UUID()
                        notice.isActive = true
                        notice.note = isOutbound ? "outbound" : "inbound"
                        notice.travel = travel
                        dataController.save()
                        isAddingItem = false
                    }
                } label: {
                    Label("Create reminder for\n\(Int(minutes), specifier: "%02d"):\(Int(seconds), specifier: "%02d") before landing", systemImage: "rectangle.stack.badge.plus") // swiftlint:disable:this line_length
                        .monospacedDigit()
                        .multilineTextAlignment(.trailing)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .disabled(seconds == 0.0 && minutes == 0.0)
                .buttonStyle(.bordered)
            }

        } label: {
            Button {
                withAnimation {
                    if isAddingItem {
                        isAddingItem = false
                    } else {
                        isAddingItem = true
                    }
                }
            } label: {
                Label("New reminder", systemImage: "plus")
            }
        }
    }
}

struct AddAdjustItemRow_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        Form {
            AddAdjustItemRow(isOutbound: true, travel: Travel.example)
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
        }
    }
}
