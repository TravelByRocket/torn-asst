//
//  Stats.swift
//  TornAsst
//
//  Created by Bryan Costanza on 1/22/21.
//

// swiftlint:disable all
import Foundation

@available(*, deprecated)
struct StatsREMOVE: Codable {
    var serverDate: Date {
        Date(timeIntervalSince1970: TimeInterval(server_time))
    }
    
    var level: Int
    var gender: String
    var player_id: Int
    var name: String
    /// Server time should go private once everything is updated
    @available(*, deprecated)
    var server_time: Int
    var happy: BarResultREMOVE
    var life: BarResultREMOVE
    var energy: BarResultREMOVE
    var nerve: BarResultREMOVE
    var travel: TravelDetailsJSON
}
