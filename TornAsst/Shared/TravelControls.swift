//
//  TravelControls.swift
//  TornAsst
//
//  Created by Bryan Costanza on 11/28/20.
//

import SwiftUI

struct TravelControls: View {
    let travel: TravelResult
    @State private var selection = "inbound"
    
    @State private var outboundPrefs = TravelNotifyPrefs(notifyTMinus0: true, notifyTMinus1: true)
    @State private var inboundPrefs = TravelNotifyPrefs(notifyTMinus0: true)
    
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
            if (selection == "inbound") {
                TravelOptionControls(prefs: $inboundPrefs)
            } else {
                TravelOptionControls(prefs: $outboundPrefs)
            }
        }
    }
    
}

struct TravelOptionControls: View {
    @Binding var prefs: TravelNotifyPrefs
    var body: some View {
        NotifyOptionRow(message: "When I Land", shouldNotify: $prefs.notifyTMinus0)
        NotifyOptionRow(message: "1 Minute Before Landing", shouldNotify: $prefs.notifyTMinus1)
        NotifyOptionRow(message: "5 Minutes Before Landing", shouldNotify: $prefs.notifyTMinus5)
    }
}

struct TravelNotifyPrefs {
    var notifyTMinus0 = false
    var notifyTMinus1 = false
    var notifyTMinus5 = false
}

struct TravelControls_Previews: PreviewProvider {
    static var previews: some View {
        TravelControls(travel: TravelResult.default)
    }
}
