//
//  BigSectionBarView.swift
//  TornAsst
//
//  Created by Bryan Costanza on 15 Dec 2021.
//

import SwiftUI

struct BigSectionBarView: View {
    let systemImage: String
    let message: String
    let color: Color
    var date: Date?

    @State private var notificationEnabled = true

    var body: some View {
        HStack {
            VStack {
                Label(message, systemImage: systemImage)
                    .font(.title)
                    .foregroundColor(color)
                if let date = date {
                    CountdownWithLocalTime(date: date)
                }
            }
            .frame(maxWidth: .infinity)
//            Divider()
//            Button {
//                notificationEnabled.toggle()
//            } label: {
//                Image(systemName: notificationEnabled ? "bell" : "bell.slash")
//                    .font(.title2)
//                    .foregroundColor(notificationEnabled ? .accentColor : .secondary)
//            }
        }
    }
}

struct BigSectionBarView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            BigSectionBarView(systemImage: "moon.stars", message: "Section Name", color: .purple, date: Date().addingTimeInterval(20_000))
            BigSectionBarView(systemImage: "clock", message: "Section Name", color: .orange)
        }
    }
}
