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
            return "Level: " + String(level)
        } else {
            return "Level: unknown"
        }
    }

    var isInErrorState: Bool {
        api.lastChecked == nil || api.error != nil
    }

    var stateMessage: String {
        if api.lastChecked == nil {
            return "Never checked"
        } else if let msg = api.error {
            return msg
        } else {
            return "Success"
        }
    }

    var lastCheckText: Text {
        if let date = api.lastChecked {
            return Text("\(date, style: .relative) ago")
        } else {
            return Text("Never").foregroundColor(.orange)
        }
    }

    var statusText: Text {
        if let msg = api.error {
            return Text(msg).foregroundColor(.red)
        } else if api.lastChecked != nil {
            return Text("Success").foregroundColor(.green)
        } else {
            return Text("N/A").foregroundColor(.orange)
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            BigSectionBarView(
                systemImage: "server.rack",
                message: "API Status",
                color: .accentColor
            )
            .padding(.bottom)
            HStack {
                VStack(alignment: .leading) {
                    Text(name)
                    Text(levelString)
                    Text("Last checked: ") + lastCheckText
                    (Text("Status: ") + statusText)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .font(.body.monospaced())
            }
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
