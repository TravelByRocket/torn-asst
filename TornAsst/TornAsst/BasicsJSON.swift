//
//  BasicsJSON.swift
//  TornAsst
//
//  Created by Bryan Costanza on 25 Dec 2021.
//

import Foundation

struct BasicsJSON: DirectlyMatchedAPI {
    static var apiFields = ["basic"]

    let level: Int
    let gender: String
    let player_id: Int // swiftlint:disable:this identifier_name
    let name: String

    struct status {  // swiftlint:disable:this type_name
        let description: String
        let details: String
        let state: String
        let color: String
        let until: Int
    }
}
