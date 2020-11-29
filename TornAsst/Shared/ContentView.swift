//
//  ContentView.swift
//  Shared
//
//  Created by Bryan Costanza on 11/26/20.
//

import SwiftUI

struct ContentView: View {
    @Binding var apikey: String
    @Binding var response: TornResponse
    
    var body: some View {
        VStack {
            BasicsSection(response: response)
            ScrollView {
                EnergySection(response: response)
                NerveSection(nerve: response.nerve, serverTime: response.server_time)
                HappySection(happy: response.happy, serverTime: response.server_time)
                LifeSection(life: response.life, serverTime: response.server_time)
                TravelSection(travel: response.travel, server_time: response.server_time)
                Spacer()
                TempDevNotes().background(Color.secondary)
            }
            SyncSection(response: $response, apikey: $apikey)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(apikey: .constant("7Im0qHgainf4Xy1A"), response: .constant(TornResponse.default))
    }
}

struct TempDevNotes: View {
    var body: some View {
        Text("List of scheduled notifications")
        Text("Next increment in _:__")
        Text("Cooldown")
        Text("spin the wheel of the day")
        Text("items for day")
        Text("refills")
    }
}

struct HappySection: View {
    let happy: BarResult
    let serverTime: Int
    
    var body: some View {
        IndicatorRow(name: "Happy ",
                     color: .yellow,
                     barInfo: happy,
                     server_time: serverTime)
    }
}

struct LifeSection: View {
    let life: BarResult
    let serverTime: Int
    
    var body: some View {
        IndicatorRow(name: "Life  ",
                     color: .blue,
                     barInfo: life,
                     server_time: serverTime)
    }
}
