//
//  EnergySection.swift
//  TornAsst
//
//  Created by Bryan Costanza on 11/28/20.
//

import SwiftUI

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

struct NotifyOptionRowStepper_Previews: PreviewProvider {
    static var previews: some View {
        List {
            NotifyOptionRowStepper(message: "notify", shouldNotify: .constant(true), value: .constant(5), max: 20, step: 1)
            NotifyOptionRowStepper(message: "notify", shouldNotify: .constant(false), value: .constant(5), max: 20, step: 1)
        }
    }
}
