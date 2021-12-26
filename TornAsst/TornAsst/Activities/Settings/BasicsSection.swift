//
//  BasicsSection.swift
//  TornAsst
//
//  Created by Bryan Costanza on 11/28/20.
//

import SwiftUI

struct BasicsSection: View {
    @EnvironmentObject var player: Player
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    var name: String {
        player.playerBasics.name ?? "Name unknown"
    }

    var api: API {
        player.playerAPI
    }

    var levelString: String {
        let level = player.playerBasics.level
        if level > 0 {
            return "Level " + String(level)
        } else {
            return "Level unknown"
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            BigSectionBarView(
                systemImage: "server.rack",
                message: "API Status",
                color: .accentColor
            )
            Text(api.lastChecked != nil
                 ? "Success \(api.lastChecked!, style: .relative) ago"
                 : "Never checked")
                .foregroundColor(api.lastChecked != nil ? .green : .orange)
                .fixedSize(horizontal: false, vertical: true)
                .font(.title3)
                .padding(1)
                .monospacedDigit()
            Group {
                Text(name)
                Text(levelString)
            }
            .font(.body.monospaced())
        }
    }
}

struct BasicsSection_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        Form {
            BasicsSection()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
                .environmentObject(Player.example)
        }
    }
}
