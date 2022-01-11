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

    var sections: [BarSection] {
        [
            BarSection(bar: player.playerEnergy, color: .green),
            BarSection(bar: player.playerNerve, color: .red),
            BarSection(bar: player.playerHappy, color: .yellow),
            BarSection(bar: player.playerLife, color: .blue)
        ]
    }

    struct BarSection: Identifiable {
        let bar: Bar
        let color: Color

        var id: String { bar.barName }
    }

    var body: some View {
        List {
            ForEach(sections) {section in
                Section {
                    BarView(color: section.color, bar: section.bar)
                }
            }
        }
        .refreshable {
            fetchBars()
        }
    }

    func fetchBars() {
        Task.init {
            isLoading = true
            let result = try await player.playerAPI.getNew(Player.BarsJSON.self)
            if let result = result {
                withAnimation {
                    player.setBarsFromJSON(result)
                }
            }
            player.objectWillChange.send()
            isLoading = false
            dataController.save()
        }
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
