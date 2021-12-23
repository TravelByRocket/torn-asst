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

    let playersOnlyOne: FetchRequest<Player>

    var player: Player {
        if let justOne = playersOnlyOne.wrappedValue.first {
            return justOne
        } else {
            let justOne = Player(context: managedObjectContext)
            dataController.save()
            return justOne
        }
    }

    init() {
        playersOnlyOne = FetchRequest<Player>(
            entity: Player.entity(),
            sortDescriptors: []
        )
    }

    var body: some View {
        TabView(selection: $selectedView) {
            TravelView()
                .tag(TravelView.tag)
                .tabItem {
                    Image(systemName: "airplane")
                    Text("Travel")
                }
            RemindersView()
                .tag(RemindersView.tag)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Dated")
                }
            TimedView()
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
        .environmentObject(player)
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
