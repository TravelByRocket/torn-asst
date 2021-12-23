//
//  SettingsView.swift
//  TornAsst
//
//  Created by Bryan Costanza on 19 Dec 2021.
//

import SwiftUI

struct SettingsView: View {
    static let tag: String = "Settings"

    var body: some View {
        Form {
            Section {
                BasicsSection()
            }
            Section(footer: ApiPromptPage.footer) {
                ApiPromptPage()
            }
            Section(footer: ClockOffsetView.offsetNote) {
                ClockOffsetView()
            }
            .disabled(true)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
