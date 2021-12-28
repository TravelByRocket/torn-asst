//
//  DeleteNoticeButton.swift
//  TornAsst
//
//  Created by Bryan Costanza on 27 Dec 2021.
//

import SwiftUI

struct DeleteNoticeButton: View {
    let notice: Notice

    @State private var showAlert = false

    @EnvironmentObject var player: Player
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    @ViewBuilder var alertBody: some View {
        Button(role: .cancel) {
            showAlert = false
        } label: {
            Text("Cancel")
        }
        Button(role: .destructive) {
            notice.removeAssociatedNotification()
            player.objectWillChange.send()
            withAnimation {
                dataController.delete(notice)
            }
            dataController.save()
        } label: {
            Text("Delete")
        }
    }

    var body: some View {
        Button(role: .destructive) {
            showAlert = true
        } label: {
            Label("Delete", systemImage: "trash")
                .labelStyle(.iconOnly)
        }
        .buttonStyle(.borderless)
        .alert("Delete this reminder?", isPresented: $showAlert) {
            alertBody
        }
    }
}

struct DeleteNoticeButton_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        DeleteNoticeButton(notice: Notice.exampleActive)
            .previewLayout(.sizeThatFits)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
            .environmentObject(Player.example)
    }
}
