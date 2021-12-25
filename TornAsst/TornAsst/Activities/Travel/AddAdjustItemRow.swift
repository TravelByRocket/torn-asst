//
//  AddAdjustItemRow.swift
//  TornAsst
//
//  Created by Bryan Costanza on 23 Dec 2021.
//

import SwiftUI

struct AddAdjustItemRow: View {
    let isOutbound: Bool
    let travel: Travel?
    let notice: Notice?

    @State private var isExpanded = false
    // Workaround for not being able to have an optional ObservedObject for notice
    // Can mostly be avoided with notice.travel?.objectWillChange.send() but had issues
    @State private var isNoticeActive = false
    @State private var showAlert = false
    @State private var minutes: Double
    @State private var seconds: Double

    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    /// This initializer is used when the view should create a new Notice if saved
    /// - Parameters:
    ///   - isOutbound: For inbound or outbound flights?
    ///   - travel: The parent object that will gain the Notice
    init(isOutbound: Bool, travel: Travel) {
        self.isOutbound = isOutbound
        self.travel = travel
        seconds = 0.0
        minutes = 0.0
        notice = nil // created when saved
    }

    /// This initializer uses an existing Notice for initial conditions and then updates that Notice if saved
    /// - Parameters:
    ///   - isOutbound: For inbound or outbound flights?
    ///   - notice: The existing object that will be updated if saved
    init(isOutbound: Bool, notice: Notice) {
        self.isOutbound = isOutbound
        self.travel = notice.travel
        _seconds = State(wrappedValue: TimeInterval(notice.noticeOffsetSecondsOnly))
        _minutes = State(wrappedValue: TimeInterval(notice.noticeOffsetMinutesOnly))
        self.notice = notice
        _isNoticeActive = State(wrappedValue: notice.isActive)
    }

    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            VStack(alignment: .leading) {
                Group {
                    HStack {
                        Text("\(Int(seconds), specifier: "% 2d") sec")
                        Slider(value: $seconds, in: 0 ... 59, step: 1.0)
                    }
                    HStack {
                        Text("\(Int(minutes), specifier: "% 2d") min")
                        Slider(value: $minutes, in: 0 ... 59, step: 1.0)
                    }
                }
                .font(.body.monospaced())
                HStack {
                    Button {
                        withAnimation {
                            if let notice = notice {
                                notice.travel?.objectWillChange.send()
                                notice.noticeOffset = Int(minutes * 60 + seconds)
                            } else {
                                let notice = Notice(context: managedObjectContext)
                                notice.noticeOffset = Int(minutes * 60 + seconds)
                                notice.id = UUID()
                                notice.isActive = true
                                notice.note = isOutbound ? "outbound" : "inbound"
                                notice.travel = travel
                            }
                            dataController.save()
                            isExpanded = false
                        }
                    } label: {
                        Label("\(notice == nil ? "Remind" : "Change to") \(Int(minutes), specifier: "%02d"):\(Int(seconds), specifier: "%02d") before", systemImage: "rectangle.stack.badge.plus") // swiftlint:disable:this line_length
                            .monospacedDigit()
                            .multilineTextAlignment(.trailing)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .disabled(seconds == 0.0 && minutes == 0.0)
                    .buttonStyle(.bordered)
                    if let notice = notice {
                        Spacer()
                        Button(role: .destructive) {
                            showAlert = true
                        } label: {
                            Label("Delete", systemImage: "trash")
                                .labelStyle(.iconOnly)
                        }
                        .buttonStyle(.borderless)
                        .alert("Delete this reminder?", isPresented: $showAlert) {
                            Button(role: .cancel) {
                                showAlert = false
                            } label: {
                                Text("Cancel")
                            }
                            Button(role: .destructive) {
                                withAnimation {
                                    dataController.delete(notice)
                                }
                            } label: {
                                Text("Delete")
                            }

                        }
                    }

                }
            }

        } label: {
            if let notice = notice {
                NotifyQuickActionRow(message: "\(notice.noticeOffset) seconds before landing", notice: notice)
            } else {
                Button {
                    withAnimation {
                        isExpanded.toggle()
                    }
                } label: {
                    Label("New reminder", systemImage: "plus")
                }
            }
        }
    }
}

struct AddAdjustItemRow_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        Form {
            AddAdjustItemRow(isOutbound: true, travel: Travel.example)
            AddAdjustItemRow(isOutbound: true, notice: Notice.exampleActive)
        }
        .environment(\.managedObjectContext, dataController.container.viewContext)
        .environmentObject(dataController)
    }
}
