//
//  ContentView.swift
//  TornAsst
//
//  Created by Bryan Costanza on 14 Dec 2021.
//

import SwiftUI

struct ContentView: View {
    @SceneStorage("selectedView") var selectedView: String?

    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    @FetchRequest(
        entity: Player.entity(),
        sortDescriptors: []
    ) private var players: FetchedResults<Player>

    var user: Player {
        if let oneUser = players.first {
            return oneUser
        } else {
            let oneUser = Player(context: managedObjectContext)
            dataController.save()
            return oneUser
        }
    }

    var body: some View {
        TabView(selection: $selectedView) {
            TravelView()
                .tag(TravelView.tag)
                .tabItem {
                    Image(systemName: "airplane")
                    Text("Travel")
                }
            DatedView()
                .tag(DatedView.tag)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Dated")
                }
//            TimedView()
            DrugView()
                .tag("cooldowns")
                .tabItem {
                    Image(systemName: "timer")
                    Text("TImed")
                }
            Text("Nerve")
                .tag("nerve")
                .tabItem {
                    Image(systemName: "flame")
                    Text("Nerve")
                }
            Text("Energy")
                .tag("energy")
                .tabItem {
                    Image(systemName: "bolt")
                    Text("Energy")
                }
            SettingsView()
                .tag(SettingsView.tag)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
