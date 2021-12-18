//
//  TravelView.swift
//  TornAsst
//
//  Created by Bryan Costanza on 14 Dec 2021.
//

import SwiftUI

struct TravelView: View {
    static let tag: String = "Travel"

    static var imageName: String {
        ["airplane.arrival", "airplane.arrival", "airplane"].randomElement() ?? "airplane"
    }

    var body: some View {
        List {
            Section(header: Text("Returning to Torn")) {
                NotificationRow(enabled: .constant(true), message: "yeah")
            }
            Section(header: Text("Arriving Abroad")) {

            }
            Section(header: Text("Tab")) {
                Label("Travel", systemImage: TravelView.imageName)
                Label("Travel", systemImage: TravelView.imageName)
                Label("Travel", systemImage: TravelView.imageName)
                Label("Travel", systemImage: TravelView.imageName)
                Label("Travel", systemImage: TravelView.imageName)
            }
        }
    }
}

struct TravelView_Previews: PreviewProvider {
    static var previews: some View {
        TabView(selection: .constant("travel")) {
            TravelView()
                .tag("travel")
                .tabItem {
                    Label("Travel", systemImage: TravelView.imageName)
                }
        }
    }
}
