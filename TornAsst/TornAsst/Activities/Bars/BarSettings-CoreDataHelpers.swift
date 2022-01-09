//
//  BarSettings-CoreDataHelpers.swift
//  TornAsst
//
//  Created by Bryan Costanza on 8 Jan 2022.
//

import Foundation

extension BarSettings {
    var barMultiplesOf: Int {
        get {
            if let bar = bar {
                if multiplesOf > bar.barIncrement {
                    return Int(multiplesOf)
                } else {
                    return Int(bar.barIncrement)
                }
            } else {
                return 1
            }
        } set {
            multiplesOf = Int16(newValue)
        }
    }

    /// The single-value trigger for the bar with a minimum equal to the bar increment and max equal to one increment less than the max
    var barValueOf: Int {
        get {
            if let bar = bar {
                if valueOf > bar.barIncrement {
                    return Int(valueOf)
                } else {
                    return Int(bar.barIncrement)
                }
            } else {
                return 1
            }
        } set {
            valueOf = Int16(newValue)
        }
    }
}
