//
//  NotifyQuickActionRow.swift
//  TornAsst (iOS)
//
//  Created by Bryan Costanza on 20 Dec 2021.
//

import SwiftUI

struct NoticeToggleRow: View {
    let message: String
    @ObservedObject var notice: Notice

    @EnvironmentObject var player: Player
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some View {
        HStack {
            Button {
                notice.isActive.toggle()
                dataController.save()
                notice.processFlightNoticeChange()
            } label: {
                Label(message, systemImage: notice.isActive ? "bell" : "bell.slash")
            }
        }
        .foregroundColor(notice.isActive ? .accentColor : .secondary)
        .onReceive(notice.objectWillChange, perform: notice.processFlightNoticeChange)
    }
}

struct NoticeToggleRow_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        List {
            NoticeToggleRow(
                message: "\(Notice.exampleActive.offset) seconds before whatever",
                notice: Notice.exampleActive)
            NoticeToggleRow(
                message: "\(Notice.exampleInactive.offset) seconds before whatever",
                notice: Notice.exampleInactive)
        }
        .environment(\.managedObjectContext, dataController.container.viewContext)
        .environmentObject(dataController)
        .environmentObject(Player.example)
    }
}
