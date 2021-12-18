//
//  ContentView.swift
//  TornAsst
//
//  Created by Bryan Costanza on 14 Dec 2021.
//

import SwiftUI

struct ContentView: View {
    @SceneStorage("selectedView") var selectedView: String?

    var body: some View {
        TabView(selection: $selectedView) {
//            DashboardView()
//                .tag(DashboardView.tag)
//                .tabItem {
//                    Image(systemName: "house")
//                    Text("Dashboard")
//                }
            TravelView()
                .tag(TravelView.tag)
                .tabItem {
                    Image(systemName: TravelView.imageName) // Look up other airplane symbols to make it more dynamic
                    Text("Travel")
                }
            DailiesView()
                .tag(DailiesView.tag)
                .tabItem {
                    Image(systemName: "calendar.badge.exclamationmark")
                    Text("Dated")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
