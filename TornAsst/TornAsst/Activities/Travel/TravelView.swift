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

    @FetchRequest(
        entity: Travel.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Travel.departed, ascending: true)
        ]
    ) private var travelJustOne: FetchedResults<Travel>

    var travel: Travel {
        travelJustOne.first ?? Travel.example
    }

    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    var currently: some View {
        if travel.isOnGround {
            return Label(
                "You are in \(travel.destination ?? "Unknown")",
                systemImage: travel.destination == "Torn" ? "mappin.and.ellipse" : "camera.viewfinder"
            )
        } else {
            let msg = "Flying to \(travel.destination ?? "Unknown")"
            if travel.destination == "Torn" {
                return Label(msg, image: "airplane.left")
            } else {
                return Label(msg, systemImage: "airplane")
            }
        }
    }

    var body: some View {
        List {
            Button {
                dataController.deleteAll()
            } label: {
                Text("Delete All")
            }

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
            TravelNotificationsView(isOutbound: true)
            TravelNotificationsView(isOutbound: false)
        }
        .refreshable {
            Task.init {
                try? await fetchTravel()
            }
        }
        .onAppear {
            if travelJustOne.isEmpty {
                _ = Travel(context: managedObjectContext)
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
        guard let url = URL(string: "https://api.torn.com/user/?selections=travel&key=7Im0qHgainf4Xy1A") else {
            throw TravelFetchError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let travelResult = try JSONDecoder().decode(TravelJSON.self, from: data).travel
        let departure = Date(timeIntervalSince1970: TimeInterval(travelResult.departed))
        let arrival = Date(timeIntervalSince1970: TimeInterval(travelResult.timestamp))

        withAnimation {
            travel.arrival = arrival
            travel.departed = departure
            travel.destination = travelResult.destination
            dataController.save()
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
    }
}
