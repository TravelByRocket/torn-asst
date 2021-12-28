//
//  AddAdjustItemRow.swift
//  TornAsst
//
//  Created by Bryan Costanza on 23 Dec 2021.
//

import SwiftUI
import UserNotifications

struct AddAdjustItemRow: View {
    let isOutbound: Bool
    let travel: Travel?
    let notice: Notice?

    @State private var isExpanded = false
    // Workaround for not being able to have an optional ObservedObject for notice
    // Can mostly be avoided with notice.travel?.objectWillChange.send() but had issues
    @State private var isNoticeActive = false
    @State private var hours: Double
    @State private var minutes: Double
    @State private var seconds: Double

    @EnvironmentObject var player: Player
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
        hours = 0.0
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
        _hours = State(wrappedValue: TimeInterval(notice.noticeOffsetHoursOnly))
        self.notice = notice
        _isNoticeActive = State(wrappedValue: notice.isActive)
    }

    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            VStack(alignment: .leading) {
                OffsetChangingView(seconds: $seconds, minutes: $minutes, hours: $hours)
                HStack {
                    Button {
                        withAnimation {
                            setNoticeOffset()
                        }
                    } label: {
                        LandingNoticeLabel(
                            hours: hours, minutes: minutes, seconds: seconds,
                            variant: notice == nil ? .creating : .updating)
                    }
                    .buttonStyle(.bordered)
                    if let notice = notice {
                        Spacer()
                        DeleteNoticeButton(notice: notice)
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

    func setNoticeOffset() {
        let notice = notice ?? makeNewNotice()
        player.objectWillChange.send()
        notice.noticeOffset = Int(minutes * 60 + seconds)
        notice.processFlightNoticeChange()

        isExpanded = false
        dataController.save()
    }

    func makeNewNotice() -> Notice {
        let notice = Notice(context: managedObjectContext)
        notice.id = UUID()
        notice.isActive = true
        notice.note = isOutbound ? "outbound" : "inbound"
        notice.travel = travel

        return notice
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
        .environmentObject(Player.example)
    }
}
