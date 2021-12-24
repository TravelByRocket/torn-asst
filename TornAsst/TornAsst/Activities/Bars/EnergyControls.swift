//
//  EnergyControls.swift
//  TornAsst
//
//  Created by Bryan Costanza on 11/28/20.
//

// swiftlint:disable all
import SwiftUI

struct EnergyControls: View {
    let response: StatsREMOVE
    @State private var selection = "Home"
    
    @State private var homePrefs = EnergyNotifyPrefs(notifyFull: true)
    @State private var flyingPrefs = EnergyNotifyPrefs()
    @State private var abroadPrefs = EnergyNotifyPrefs(notify25: true)
    
    var body: some View {
        VStack {
            GroupBox {
                Picker(selection: $selection, label: Text("Notification Context")) {
                    Text("Torn City").tag("Home")
                    Text("Flying").tag("Flying")
                    Text("City Abroad").tag("Abroad")
                }
                .pickerStyle(SegmentedPickerStyle())
                HStack {
                    Text("When I am ")+Text(selection).bold()+Text(", notify me when my energy is...")
                    Spacer()
                }
            }
//            if (selection == "Home") {
//                EnergyOptionControls(prefs: $homePrefs, response: response)
//            } else if (selection == "Flying") {
//                EnergyOptionControls(prefs: $flyingPrefs, response: response)
//            } else {
//                EnergyOptionControls(prefs: $abroadPrefs, response: response)
//            }
        }
    }
    
}

struct EnergyNotifyPrefs {
    var notifyFull = false
    var notify25 = false
    var notifyCustomMultiple = false
    var notifyCustomLevel = false
    var customMultiple = 10
    var customLevel = 50
}

//struct EnergyControls_Previews: PreviewProvider {
//    static var previews: some View {
//        EnergyControls(response: TornResponse())
//    }
//}
