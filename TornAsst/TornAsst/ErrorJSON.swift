//
//  ErrorJSON.swift
//  TornAsst
//
//  Created by Bryan Costanza on 25 Dec 2021.
//

import Foundation

struct ErrorJSON: DirectlyMatchedAPI {
    static var apiFields: [String] = [] // not valid for this type but want to keep protocol consistency

    struct error { // swiftlint:disable:this type_name
        let code: Int
        let error: String
    }
}