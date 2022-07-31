//
//  BasicsJSON.swift
//  TornAsst
//
//  Created by Bryan Costanza on 25 Dec 2021.
//

import Foundation

extension Basics {
    func setFromJSON(_ json: JSON) {
        level = Int16(json.level)
        name = json.name
        gender = json.gender
        userID = Int32(json.player_id)
    }

    struct JSON: DirectlyMatchedAPI {
        static var apiFields = ["basic"]

        let level: Int
        let gender: String
        let player_id: Int // swiftlint:disable:this identifier_name
        let name: String

        let status: InternalJSON

    }

    struct InternalJSON: InternallyMatchedAPI {
        let description: String
        let details: String
        let state: String
        let color: String
        let until: Int
    }
}
