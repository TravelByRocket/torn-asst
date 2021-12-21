//
//  TornAsstApp.swift
//  Shared
//
//  Created by Bryan Costanza on 11/26/20.
//

import SwiftUI

@main
struct TornAsstApp: App {
    @StateObject var dataController: DataController

    @AppStorage("responsedata") var responsedata: Data?
    @StateObject var us: UserState = UserState()

    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
                .onReceive(
                    // Automatically save when no longer in the foreground. Use this over scene phase API for port to
                    // macOS (as of macOS 11.1)
                    NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification),
                    perform: save
                )
        }
    }

    func save(note: Notification) {
        dataController.save()
    }
}

let api = ApiManager()

/// Epoch Time to use with `Date(timeIntervalSince1970: TimeInterval)`
typealias UnixTime = Double
typealias Seconds = Double
