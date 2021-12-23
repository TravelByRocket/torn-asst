//
//  NerveControls.swift
//  TornAsst
//
//  Created by Bryan Costanza on 11/29/20.
//

// swiftlint:disable all
import SwiftUI

struct NerveControls: View {
    let nerve: BarResultREMOVE
    @State private var selection = "Home"
    
    @State private var homePrefs = NerveNotifyPrefs(notifyFull: true, notifyCustomMultiple: true, customMultiple: 7)
    @State private var flyingPrefs = NerveNotifyPrefs()
    @State private var abroadPrefs = NerveNotifyPrefs()
    
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
                    Text("When I am ")+Text(selection).bold()+Text(", notify me when my nerve is...")
                    Spacer()
                }
            }
            if (selection == "Home") {
                NerveOptionControls(prefs: $homePrefs, nerve: nerve)
            } else if (selection == "Flying") {
                NerveOptionControls(prefs: $flyingPrefs, nerve: nerve)
            } else {
                NerveOptionControls(prefs: $abroadPrefs, nerve: nerve)
            }
        }
    }
    
}

struct NerveOptionControls: View {
    @Binding var prefs: NerveNotifyPrefs
    let nerve: BarResultREMOVE
    var body: some View {
        NotifyQuickActionRow(message: "Full", isActive: $prefs.notifyFull)
        NotifyOptionRowStepper(message: "Custom: At Level \(prefs.customLevel)", shouldNotify: $prefs.notifyCustomLevel, value: $prefs.customLevel, max: nerve.maximum, step: nerve.increment)
        NotifyOptionRowStepper(message: "Custom: Multiple of \(prefs.customMultiple)", shouldNotify: $prefs.notifyCustomMultiple, value: $prefs.customMultiple, max: nerve.maximum, step: nerve.increment)
    }
}

struct NerveNotifyPrefs {
    var notifyFull = false
    var notifyCustomMultiple = false
    var notifyCustomLevel = false
    var customMultiple = 10
    var customLevel = 10
}

struct NerveControls_Previews: PreviewProvider {
    static var previews: some View {
        NerveControls(nerve: BarResultREMOVE.default)
    }
}
