//
//  BarResult.swift
//  TornAsst
//
//  Created by Bryan Costanza on 1/31/21.
//

import Foundation

struct BarResult: Codable, TickDefinite {
    var current: Int
    var maximum: Int
    var increment: Int
    var interval: Seconds
    var ticktime: Seconds
    var fulltime: Seconds

    static var `default` = BarResult(current: 75, maximum: 100, increment: 5, interval: 900, ticktime: 452, fulltime: 4952)
}
