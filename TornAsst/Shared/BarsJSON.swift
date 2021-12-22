//
//  BarsJSON.swift
//  TornAsst
//
//  Created by Bryan Costanza on 21 Dec 2021.
//

import Foundation

struct BarsJSON: DirectlyMatchedAPI {
    static let apiFields = ["bars"]

    let server_time: Int // swiftlint:disable:this identifier_name
    let happy: BarJSON
    let life: BarJSON
    let energy: BarJSON
    let nerve: BarJSON
    let chain: ChainJSON
}

struct BarJSON: InternallyMatchedAPI {
    let current: Int
    let maximum: Int
    let increment: Int
    let interval: Int
    let ticktime: Int
    let fulltime: Int
}

struct ChainJSON: InternallyMatchedAPI {
    let current: Int
    let maximum: Int
    let timeout: Int
    let modifier: Double
    let cooldown: Int
}
