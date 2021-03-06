//
//  ContentView.swift
//  TornAsst
//
//  Created by Bryan Costanza on 14 Dec 2021.
//

import SwiftUI

struct ContentView: View {
    @SceneStorage("selectedView") var selectedView: String = TravelView.tag

    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    let playersOnlyOne: FetchRequest<Player>

    var player: Player {
        if let justOne = playersOnlyOne.wrappedValue.first {
            return justOne
        } else {
            let justOne = Player(context: managedObjectContext)
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
                    Text("Reminders")
                }
            CooldownsView()
                .tag(CooldownsView.tag)
                .tabItem {
                    Image(systemName: "thermometer")
                    Text("Cooldowns")
                }
            BarsView()
                .tag(BarsView.tag)
                .tabItem {
                    Image(systemName: "flame")
                    Text("Bars")
                }
            SettingsView()
                .tag(SettingsView.tag)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .environmentObject(player)
        .onAppear {
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("Notifications authorized")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
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
