//
//  DrugView.swift
//  TornAsst (iOS)
//
//  Created by Bryan Costanza on 19 Dec 2021.
//

import SwiftUI

struct DrugView: View {
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    @FetchRequest(
        entity: Player.entity(),
        sortDescriptors: []
    ) private var players: FetchedResults<Player>

    var player: Player {
        print(players.count)
        if let user = players.first {
            print("existing user")
            return user
        } else {
            print("making user")
            let user = Player(context: managedObjectContext)
            dataController.save()
            return user
        }
    }

    var rando: Int = Int.random(in: 10...99)

    var body: some View {
        List {
            Text("Drug Cooldown")
            Button {
                dataController.delete(player)
                dataController.save()
            } label: {
                Text("Delete user")
            }
            Button {
                _ = Player(context: managedObjectContext)
                dataController.save()
            } label: {
                Text("Make User")
            }
            Button {
                print(player)
            } label: {
                Text("Print User")
            }
            Button {
                player.api?.key = String(rando)
                dataController.save()
            } label: {
                Text("Set API Key to \(rando)")
            }
            Text(player.api?.key ?? "No Key")
            Section(header: Text("each user")) {
                ForEach(players) {player in
                    Text(player.debugDescription)
                }
            }
            Section(header: Text("Manually")) {
                Text(player.debugDescription)
            }
        }
//        .onAppear {
//            if users.isEmpty {
//                _ = User(context: managedObjectContext)
//                dataController.save()
//            }
//        }
    }
}

struct DrugView_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        DrugView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
