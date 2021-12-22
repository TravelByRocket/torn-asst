//
//  ContentView.swift
//  Shared
//
//  Created by Bryan Costanza on 11/26/20.
//

import SwiftUI
import UserNotifications

struct DashboardView: View {
    @AppStorage("responsedata") var responsedata: Data?
    @EnvironmentObject var us: UserState

    static let tag: String = "Dashboard"

    var body: some View {
        VStack {
            BasicsSection()
            ScrollView {
                EnergySection(response: us.stats)
                NerveSection(nerve: us.stats.nerve, serverTime: us.stats.server_time)
                HappySection(happy: us.stats.happy, serverTime: us.stats.server_time)
                LifeSection(life: us.stats.life, serverTime: us.stats.server_time)
                TravelSection(travel: us.stats.travel, server_time: us.stats.server_time)
                Spacer()
            }
            SyncFooter()
        }
        .onChange(of: responsedata, perform: { _ in
            us.refresh()
        })
        .onAppear {
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .badge, .sound]) { success, error in
                if success {
                    print("All set!")
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

//struct DashBoardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(apikey: .constant("7Im0qHgainf4Xy1A"), response: .constant(TornResponse.default))
//    }
//}

struct HappySection: View {
    let happy: BarResultREMOVE
    let serverTime: Int

    var body: some View {
        IndicatorRow(
            name: "Happy ",
            color: .yellow,
            barInfo: happy,
            server_time: serverTime)
    }
}

struct LifeSection: View {
    let life: BarResultREMOVE
    let serverTime: Int

    var body: some View {
        IndicatorRow(
            name: "Life  ",
            color: .blue,
            barInfo: life,
            server_time: serverTime)
    }
}
