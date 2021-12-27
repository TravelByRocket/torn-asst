//
//  Bar-JSON.swift
//  TornAsst
//
//  Created by Bryan Costanza on 27 Dec 2021.
//

import Foundation

extension Bar {
    func setFromJSON(_ json: Player.BarInternalJSON, serverTime: Int) {
        current = Int32(json.current)
        date = Date(timeIntervalSince1970: TimeInterval(serverTime))
        fulltime =  Int32(json.fulltime)
        increment = Int32(json.increment)
        interval =  Int32(json.interval)
        maximum = Int32(json.maximum)
        ticktime =  Int32(json.ticktime)
        // name is already set
    }
}
