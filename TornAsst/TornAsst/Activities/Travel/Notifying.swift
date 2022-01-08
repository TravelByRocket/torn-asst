//
//  Notifying.swift
//  TornAsst
//
//  Created by Bryan Costanza on 4 Jan 2022.
//

import Foundation

protocol Notifying {
    var notices: NSSet? {get set}
//    func addToNotices
    func addToNotices(_ value: Notice)
}
