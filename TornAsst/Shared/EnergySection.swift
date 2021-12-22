//
//  EnergySection.swift
//  TornAsst
//
//  Created by Bryan Costanza on 11/28/20.
//

import SwiftUI

struct EnergySection: View {
    let response: StatsREMOVE

    var body: some View {
        VStack {
            IndicatorRow(name: "Energy",
                         color: .green,
                         barInfo: response.energy,
                         server_time: response.server_time)
            DisclosureGroup("Notification Preferences") {
                EnergyControls(response: response)
            }.padding(.horizontal)
        }
    }
}

//struct EnergySection_Previews: PreviewProvider {
//    static var previews: some View {
//        EnergySection(response: TornResponse.default)
//    }
//}



struct NotifyOptionRowStepper: View {
    let message: String
    @Binding var shouldNotify: Bool
    @Binding var value: Int
    let max: Int
    let step: Int

    var min: Int {
        step
    }

    var body: some View {
        HStack {
            NotifyQuickActionRow(message: message, isActive: $shouldNotify)
            Stepper("Custom Multiple", value: $value, in: min...max, step: step)
                .labelsHidden()
        }
        .foregroundColor(shouldNotify ? .accentColor : .secondary)
    }
}
