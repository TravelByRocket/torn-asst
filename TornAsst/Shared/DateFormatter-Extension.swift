//
//  DateFormatter-Extension.swift
//  TornAsst
//
//  Created by Bryan Costanza on 15 Dec 2021.
//

import Foundation

extension DateFormatter {
    static var shortTimeOnly: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = .none
        dateFormatter.timeStyle = .short
        return dateFormatter
    }
}
