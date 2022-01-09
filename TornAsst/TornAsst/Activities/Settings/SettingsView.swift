//
//  SettingsView.swift
//  TornAsst
//
//  Created by Bryan Costanza on 19 Dec 2021.
//

import SwiftUI

struct SettingsView: View {
    static let tag: String = "Settings"

    @EnvironmentObject var player: Player
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some View {
        Form {
            Section {
                BasicsSection()
            }
            Section(footer: ApiPromptPage.footer) {
                ApiPromptPage()
            }
            Section(footer: ClockOffsetView.offsetNote) {
                ClockOffsetView(player: player)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        SettingsView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
            .environmentObject(Player.example)
    }
}
