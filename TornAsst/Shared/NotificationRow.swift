//
//  NotificationRow.swift
//  TornAsst
//
//  Created by Bryan Costanza on 14 Dec 2021.
//

import SwiftUI

struct NotificationRow: View {
    @Binding var enabled: Bool
    let message: String

    var body: some View {
        Button {
            enabled.toggle()
        } label: {
            Label(message, systemImage: enabled ? "bell" : "bell.slash")
        }
        .foregroundColor(enabled ? .accentColor : .secondary)
    }
}

struct NotificationRow_Previews: PreviewProvider {
    @State static private var bool1 = true
    @State static private var bool2 = false

    static var previews: some View {
        List {
            NotificationRow(enabled: $bool1, message: "When I land")
            NotificationRow(enabled: $bool2, message: "When I land")
        }
    }
}
