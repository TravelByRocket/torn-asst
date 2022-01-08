//
//  TimedView.swift
//  TornAsst (iOS)
//
//  Created by Bryan Costanza on 19 Dec 2021.
//

import SwiftUI

struct TimedView: View {
    var body: some View {
        Form {
            Section(header: Text("Cooldowns")) {
                MedicalView()
                DrugView()
                BoosterView()
            }
            Section(header: Text("Other")) {
                EducationView()
                BankView()
            }
        }
    }
}

struct TimedView_Previews: PreviewProvider {
    static var previews: some View {
        TimedView()
    }
}
