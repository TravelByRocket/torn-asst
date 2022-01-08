//
//  BarsView.swift
//  TornAsst
//
//  Created by Bryan Costanza on 23 Dec 2021.
//

import SwiftUI

struct BarsView: View {
    static let tag: String = "Bars"
    @State private var isLoading = false

    @EnvironmentObject var player: Player
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some View {
        List {
            Section {
                Text("Static Example")
                IndicatorRow(name: "Mana", color: .purple, server_time: Int(Date().timeIntervalSince1970))
            }
            Button {
                fetchBars()
            } label: {
                Text("Refresh")
            }

            Section {
                Text("Energy \(player.playerEnergy.barCurrent)/\(player.playerEnergy.barMaximum)")
                Text("Ticks to fill \(player.playerEnergy.ticksToFill)")
                Text("Increment \(player.playerEnergy.barIncrement)")
                Text("When full")
                Text("At multiples of 25")
                ForEach(player.playerEnergy.validMultiples(of: 25), id: \.self) { value in
                    Text("\(value)")
                }
                Text("Seconds for 9 ticks \(player.playerEnergy.timeNeededFor(9))")
//                Text("Full at \(player.playerEnergy.full)")
                Text("At value of")
            }
        }
    }

    func fetchBars() {
        isLoading = true
        Task.init {
            let result = try await player.playerAPI.getNew(Player.BarsJSON.self)
            withAnimation {
                player.setBarsFromJSON(result)
            }
        }
        isLoading = false
        dataController.save()
    }
}

struct BarsView_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        BarsView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
            .environmentObject(Player.example)
    }
}
