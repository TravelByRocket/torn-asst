//
//  BarsJSON.swift
//  TornAsst
//
//  Created by Bryan Costanza on 21 Dec 2021.
//

import Foundation

extension Player {
    func setBarsFromJSON(_ json: BarsJSON) {
        playerEnergy.setFromJSON(json.energy, serverTime: json.server_time)
        playerNerve.setFromJSON(json.nerve, serverTime: json.server_time)
        playerHappy.setFromJSON(json.happy, serverTime: json.server_time)
        playerLife.setFromJSON(json.life, serverTime: json.server_time)
    }

    struct BarsJSON: DirectlyMatchedAPI {
        static let apiFields = ["bars"]

        let server_time: Int // swiftlint:disable:this identifier_name
        let happy: BarInternalJSON
        let life: BarInternalJSON
        let energy: BarInternalJSON
        let nerve: BarInternalJSON
        let chain: ChainInternalJSON
    }

    struct BarInternalJSON: InternallyMatchedAPI {
        let current: Int
        let maximum: Int
        let increment: Int
        let interval: Int
        let ticktime: Int
        let fulltime: Int
    }

    struct ChainInternalJSON: InternallyMatchedAPI {
        let current: Int
        let maximum: Int
        let timeout: Int
        let modifier: Double
        let cooldown: Int
    }
}
