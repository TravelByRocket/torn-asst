//
//  BankView.swift
//  TornAsst (iOS)
//
//  Created by Bryan Costanza on 19 Dec 2021.
//

import SwiftUI

struct BankView: View {
    var body: some View {
        List {
            Text("Bank Investment")
            Text("1 week")
            Text("2w")
            Text("1m")
            Text("2m")
            Text("3m")
        }
    }
}

struct BankView_Previews: PreviewProvider {
    static var previews: some View {
        BankView()
    }
}
