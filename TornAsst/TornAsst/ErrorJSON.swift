//
//  ErrorJSON.swift
//  TornAsst
//
//  Created by Bryan Costanza on 25 Dec 2021.
//

import Foundation

struct ErrorJSON: DirectlyMatchedAPI {
    static var apiFields: [String] = [] // unused; keep protocol consistency

    let error: TornError

    struct TornError: Codable { // swiftlint:disable:this type_name
        let code: Int
        let error: String
    }
}
