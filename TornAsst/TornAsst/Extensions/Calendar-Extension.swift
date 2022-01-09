//
//  Calendar-Extension.swift
//  TornAsst
//
//  Created by Bryan Costanza on 16 Dec 2021.
//

import Foundation

extension Calendar {
    static var torn: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        let gmt = TimeZone(secondsFromGMT: 0)!
        calendar.timeZone = gmt
        return calendar
    }

    static func torn(clockOffsetPreference: Int) -> Calendar{
        var calendar = Calendar(identifier: .gregorian)
        let gmt = TimeZone(secondsFromGMT: clockOffsetPreference)!
        calendar.timeZone = gmt
        return calendar
    }
}
