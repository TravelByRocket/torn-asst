//
//  TravelControls.swift
//  TornAsst
//
//  Created by Bryan Costanza on 11/28/20.
//

import SwiftUI
import UserNotifications

struct TravelControls: View {
    let travel: TravelDetailsJSON
    @State private var selection = "inbound"

    @State private var outboundPrefs = TravelNotifyPrefs(notifyTMinus0: true, notifyTMinus1: true)
    @State private var inboundPrefs = TravelNotifyPrefs(notifyTMinus0: true)

    var timeIntervalToLand: TimeInterval {
        let rightNowDate = Date()
        let landingDate = Date(timeIntervalSince1970: TimeInterval(travel.timestamp))
        let timeIntervalToLand = rightNowDate.distance(to: landingDate)
        return timeIntervalToLand
    }

    var body: some View {
        VStack {
            GroupBox {
                Picker(selection: $selection, label: Text("Notification Context")) {
                    Text("Returning to Torn").tag("inbound")
                    Text("Arriving Abroad").tag("outbound")
                }
                .pickerStyle(SegmentedPickerStyle())
                HStack {
                    Text("When I am ")+Text(selection).bold()+Text(", notify me...")
                    Spacer()
                }
            }
            if selection == "inbound" {
                TravelOptionControls(prefs: $inboundPrefs)
            } else {
                TravelOptionControls(prefs: $outboundPrefs)
            }
        }
        .onAppear(perform: setNotifications)
    }

    func setNotifications() {
        if travel.time_left > 60 {
            let content = UNMutableNotificationContent()
            content.title = "Landed at destination"
            content.subtitle = "You are now at \(travel.destination)"
            content.sound = UNNotificationSound.default
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeIntervalToLand, repeats: false)
            let identifer = "tminus0"
            let request = UNNotificationRequest(identifier: identifer, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
            print("tminus0 notification is set")

            let content2 = UNMutableNotificationContent()
            content2.title = "Landed at destination"
            content2.subtitle = "Landing at \(travel.destination) in 1 minute"
            content2.sound = UNNotificationSound.default
            let trigger2 = UNTimeIntervalNotificationTrigger(timeInterval: timeIntervalToLand - 60, repeats: false)
            let identifer2 = "tminus1"
            let request2 = UNNotificationRequest(identifier: identifer2, content: content2, trigger: trigger2)
            UNUserNotificationCenter.current().add(request2)
            print("tminus1 notification is set")
        }
    }
}

struct TravelOptionControls: View {
    @Binding var prefs: TravelNotifyPrefs
    var body: some View {
        NotifyQuickActionRow(message: "When I Land", isActive: $prefs.notifyTMinus0)
        NotifyQuickActionRow(message: "1 Minute Before Landing", isActive: $prefs.notifyTMinus1)
        NotifyQuickActionRow(message: "5 Minutes Before Landing", isActive: $prefs.notifyTMinus5)
    }
}

struct TravelNotifyPrefs {
    var notifyTMinus0 = false
    var notifyTMinus1 = false
    var notifyTMinus5 = false
}

struct TravelControls_Previews: PreviewProvider {
    static var previews: some View {
        TravelControls(travel: TravelDetailsJSON.example)
    }
}
