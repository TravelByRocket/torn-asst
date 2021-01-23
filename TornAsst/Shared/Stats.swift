//
//  Stats.swift
//  TornAsst
//
//  Created by Bryan Costanza on 1/22/21.
//

import Foundation

struct Stats: Codable {
    var serverDate: Date {
        Date(timeIntervalSince1970: Seconds(server_time))
    }
    
    var level: Int
    var gender: String
    var player_id: Int
    var name: String
    private var server_time: Int
    var happy: BarResult
    var life: BarResult
    var energy: BarResult
    var nerve: BarResult
}
