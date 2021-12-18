//
//  BasicsSection.swift
//  TornAsst
//
//  Created by Bryan Costanza on 11/28/20.
//

import SwiftUI

struct BasicsSection: View {
    let response: Stats
    var body: some View {
        HStack {
            Text(response.name)
                .padding()
                .frame(maxWidth: .infinity)
            ProgressView("Level \(response.level) / 100", value: Float(response.level), total: 100)
                .accentColor(.purple)
                .frame(maxWidth: .infinity)
                .padding(.trailing,5)
        }
    }
}

//struct BasicsSection_Previews: PreviewProvider {
//    static var previews: some View {
//        BasicsSection(response: TornResponse.default)
//    }
//}
