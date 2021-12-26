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

    var currently: some View {
        if travel.isOnGround {
            return Label(
                "You are in \(travel.flightDestination)",
                systemImage: travel.flightDestination == "Torn" ? "mappin.and.ellipse" : "camera.viewfinder"
            )
        } else {
            let msg = "Flying to \(travel.flightDestination)"
            if travel.destination == "Torn" {
                return Label(msg, image: "airplane.left")
            } else {
                return Label(msg, systemImage: "airplane")
            }
        }
    }

    var body: some View {
        List {
            Section {
                BigSectionBarView(
                    systemImage: "airplane.circle",
                    message: "Travel Details",
                    color: .orange,
                    date: travel.isOnGround ? nil : travel.arrival)
                HStack {
                    currently
                    Spacer()
                    Button {
                        Task.init {
                            try? await fetchTravel()
                        }
                    } label: {
                        HStack {
                            if isLoading { ProgressView() }
                            Text("Refresh")
                        }
                    }
                }

            }
            TravelNotificationsView(isOutbound: true, travel: travel)
            TravelNotificationsView(isOutbound: false, travel: travel)
        }
        .refreshable {
            Task.init {
                try? await fetchTravel()
            }
        }
        .onChange(of: isLoading) { changeIsToTrue in
            // This was previously done within the fetch but produced a warning "Publishing changes from background
            // threads is not allowed" so moved to main by attaching to view.
            if !changeIsToTrue { // has just finished fetching when it turns to false
                dataController.save()
            }
        }
    }

    enum TravelFetchError: Error {
        case invalidURL
        case missingData
    }

    func fetchTravel() async throws {
        isLoading = true

        let travelResult = try await player.playerAPI.getNew(TravelJSON.self).travel
        let departure = Date(timeIntervalSince1970: TimeInterval(travelResult.departed))
        let arrival = Date(timeIntervalSince1970: TimeInterval(travelResult.timestamp))

        withAnimation {
            travel.arrival = arrival
            travel.departed = departure
            travel.destination = travelResult.destination
            isLoading = false
        }
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
