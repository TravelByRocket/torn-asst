//
//  AddAdjustItemRow.swift
//  TornAsst
//
//  Created by Bryan Costanza on 23 Dec 2021.
//

import SwiftUI
import UserNotifications

struct NoticeAdjustRow: View {
    let tag: String?
    let parent: Notifying?
    let notice: Notice?

    @State private var isExpanded = false
    @State private var hours: Double
    @State private var minutes: Double
    @State private var seconds: Double

    @EnvironmentObject var player: Player
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    /// This initializer is used when the view should create a new Notice if saved
    /// - Parameters:
    ///   - parent: The object that will contain this notice
    ///   - tag: Will be saved in the `note` property
    init(parent: Notifying, tag: String? = nil) {
        self.parent = parent
        self.tag = tag
        self.notice = nil
        _seconds = State(initialValue: 0.0)
        _minutes = State(initialValue: 0.0)
        _hours = State(initialValue: 0.0)
    }

    /// This initializer uses an existing Notice for initial conditions and then updates that Notice if saved
    /// - Parameters:
    ///   - notice: The existing object that will be updated if saved
    init(notice: Notice) {
        self.parent = nil
        self.tag = nil
        self.notice = notice
        _seconds = State(initialValue: Double(notice.noticeOffsetSecondsOnly))
        _minutes = State(initialValue: Double(notice.noticeOffsetMinutesOnly))
        _hours = State(initialValue: Double(notice.noticeOffsetHoursOnly))
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
                        NoticeAdjustLabel(
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
                NoticeToggleRow(message: "\(notice.noticeOffset) seconds before", notice: notice)
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
        notice.noticeOffset = Int((hours * 3600) + (minutes * 60) + seconds)
        notice.processFlightNoticeChange()

        isExpanded = false
        dataController.save()
    }

    func makeNewNotice() -> Notice {
        let notice = Notice(context: managedObjectContext)
        notice.id = UUID()
        notice.isActive = true
        notice.note = tag
        parent?.addToNotices(notice)

        return notice
    }
}

struct AddAdjustItemRow_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        Form {
            NoticeAdjustRow(notice: Notice.exampleActive)
            NoticeAdjustRow(notice: Notice.exampleInactive)
            NoticeAdjustRow(parent: Travel.example, tag: "outbound")
        }
        .environment(\.managedObjectContext, dataController.container.viewContext)
        .environmentObject(dataController)
        .environmentObject(Player.example)
    }
}
