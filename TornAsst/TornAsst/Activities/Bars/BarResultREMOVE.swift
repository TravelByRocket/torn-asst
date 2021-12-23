//
//  BarResult.swift
//  TornAsst
//
//  Created by Bryan Costanza on 1/31/21.
//

import Foundation

struct BarResultREMOVE: Codable {
    var current: Int
    var maximum: Int
    var increment: Int
    var interval: TimeInterval
    var ticktime: TimeInterval
    var fulltime: TimeInterval

    static var `default` = BarResultREMOVE(current: 75, maximum: 100, increment: 5, interval: 900, ticktime: 452, fulltime: 4952)
}
