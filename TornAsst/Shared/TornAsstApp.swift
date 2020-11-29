//
//  TornAsstApp.swift
//  Shared
//
//  Created by Bryan Costanza on 11/26/20.
//

import SwiftUI

@main
struct TornAsstApp: App {
    @AppStorage("apikey") var apikey: String = ""
    @State private var response = TornResponse.default
    var body: some Scene {
        WindowGroup {
            if (apikey == "") {
                APIPrompt(apikey: $apikey, response: $response)
            } else {
                ContentView(apikey: $apikey, response: $response)
            }
        }
    }
}
