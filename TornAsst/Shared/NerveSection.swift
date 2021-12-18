//
//  NerveSection.swift
//  TornAsst
//
//  Created by Bryan Costanza on 11/29/20.
//

import SwiftUI

struct NerveSection: View {
    let nerve: BarResult
    let serverTime: Int
    
    var body: some View {
        IndicatorRow(name: "Nerve ",
                     color: .red,
                     barInfo: nerve,
                     server_time: serverTime)
        DisclosureGroup("Notification Preferences") {
            NerveControls(nerve: nerve)
        }.padding(.horizontal)
    }
}

//struct NerveSection_Previews: PreviewProvider {
//    static var previews: some View {
//        NerveSection(nerve: BarResult.default, serverTime: TornResponse.default.server_time)
//    }
//}
