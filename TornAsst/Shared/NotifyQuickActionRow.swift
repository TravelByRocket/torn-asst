//
//  NotifyQuickActionRow.swift
//  TornAsst (iOS)
//
//  Created by Bryan Costanza on 20 Dec 2021.
//

import SwiftUI

struct NotifyQuickActionRow: View {
    let message: String
    @Binding var isActive: Bool

    var body: some View {
        HStack {
            Button {
                isActive.toggle()
            } label: {
                Label(message, systemImage: isActive ? "bell" : "bell.slash")
            }
        }
        .foregroundColor(isActive ? .accentColor : .secondary)
    }
}

struct NotifyQuickActionRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            NotifyQuickActionRow(message: "Summary text", isActive: .constant(true))
            NotifyQuickActionRow(message: "Summary text", isActive: .constant(false))
        }
    }
}
