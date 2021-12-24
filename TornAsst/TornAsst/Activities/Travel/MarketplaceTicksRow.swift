//
//  MarketplaceTicksRow.swift
//  TornAsst
//
//  Created by Bryan Costanza on 23 Dec 2021.
//

import SwiftUI

struct MarketplaceTicksRow: View {
    var body: some View {
        Toggle(isOn: .constant(false)) {
            VStack(alignment: .leading) {
                Text("Marketplace Tick Notices")
                Text("Every 15 minutes on the hour")
                    .italic()
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
        }
    }
}

struct MarketplaceTicksRow_Previews: PreviewProvider {
    static var previews: some View {
        MarketplaceTicksRow()
    }
}
