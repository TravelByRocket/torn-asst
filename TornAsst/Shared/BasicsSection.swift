//
//  BasicsSection.swift
//  TornAsst
//
//  Created by Bryan Costanza on 11/28/20.
//

import SwiftUI

struct BasicsSection: View {
    //    let response: Stats

    var body: some View {
        VStack(alignment: .leading) {
            BigSectionBarView(
                systemImage: "server.rack",
                message: "API Status",
                color: .accentColor
            )
            Text("Success \(Date().addingTimeInterval(-50), style: .relative) ago")
                .foregroundColor(.green)
                .fixedSize(horizontal: false, vertical: true)
                .font(.title3)
                .padding(1)
                .monospacedDigit()
            Group {
                Text("TravelByRocket")
                Text("Level 50")
            }
                .font(.body.monospaced())
        }
    }
}

struct BasicsSection_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            BasicsSection()
        }
    }
}
