//
//  ContentView.swift
//  TornAsst
//
//  Created by Bryan Costanza on 14 Dec 2021.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @SceneStorage("selectedView") var selectedView: String?

    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    let playersOnlyOne: FetchRequest<Player>

    var player: Player {
        if let justOne = playersOnlyOne.wrappedValue.first {
            return justOne
        } else {
            let justOne = Player(context: managedObjectContext) // saves with onAppear to not update view while loading
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
        .onAppear {
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
        }
        .onAppear {
            dataController.save() // do not save within computed property or it will produce a warning about updating view
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
