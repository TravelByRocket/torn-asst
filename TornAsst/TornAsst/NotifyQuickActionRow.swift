//
//  NotifyQuickActionRow.swift
//  TornAsst (iOS)
//
//  Created by Bryan Costanza on 20 Dec 2021.
//

import SwiftUI

struct NotifyQuickActionRow: View {
    let message: String
    @ObservedObject var notice: Notice

    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some View {
        HStack {
            Button {
                notice.isActive.toggle()
                dataController.save()
                if notice.isActive {
                    // create or activate notification; perhaps watch from TravelView to manage through ObservedObject
                } else {
                    // delete or deactiate notifications
                }
            } label: {
                Label(message, systemImage: notice.isActive ? "bell" : "bell.slash")
            }
        }
        .foregroundColor(notice.isActive ? .accentColor : .secondary)
    }
}

struct NotifyQuickActionRow_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        List {
            NotifyQuickActionRow(
                message: "\(Notice.exampleActive.offset) seconds before whatever",
                notice: Notice.exampleActive)
            NotifyQuickActionRow(
                message: "\(Notice.exampleInactive.offset) seconds before whatever",
                notice: Notice.exampleInactive)
        }
        .environment(\.managedObjectContext, dataController.container.viewContext)
        .environmentObject(dataController)
    }
}
