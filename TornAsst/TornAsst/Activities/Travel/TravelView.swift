//
//  TravelView.swift
//  TornAsst
//
//  Created by Bryan Costanza on 14 Dec 2021.
//

import SwiftUI
import CoreData

struct TravelView: View {
    static let tag: String = "Travel"
    @State private var isLoading = false

    var travel: Travel {
        player.playerTravel
    }

    @EnvironmentObject var player: Player
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    var refreshButton: some View {
        Button {
            fetchTravel()
        } label: {
            HStack {
                Text("Refresh")
                if isLoading {
                    ProgressView()
                }
            }
            .foregroundColor(.indigo)
        }
    }

    var body: some View {
        List {
            Section {
                BigSectionBarView(
                    systemImage: "airplane.circle",
                    message: "Travel Details",
                    color: .orange,
                    date: travel.isOnGround ? nil : travel.flightArrival)
                TravelSummaryLabel(travel: travel)
                #if DEBUG
                refreshButton
                #endif
            }
            TravelNoticesSection(isOutbound: true)
            TravelNoticesSection(isOutbound: false)
        }
        .refreshable {
            fetchTravel()
        }
    }

    func fetchTravel() {
        isLoading = true
        Task.init {
            let result = try await player.playerAPI.getNew(Travel.JSON.self)
            withAnimation {
                travel.setFromJSON(result)
            }
        }
        isLoading = false
        dataController.save()
    }
}

struct TravelView_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        TravelView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
            .environmentObject(Player.example)
    }
}
