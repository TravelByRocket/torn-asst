//
//  TornResult.swift
//  TornAsst
//
//  Created by Bryan Costanza on 11/26/20.
//

import Foundation

struct TornResponse: Codable {
    var level: Int!
    var gender: String!
    var player_id: Int!
    var name: String!
    var server_time: Int!
    var happy: BarResult!
    var life: BarResult!
    var energy: BarResult!
    var nerve: BarResult!
    var travel: TravelResult!
    var error: ErrorResult!
    
    var interval_since_update: TimeInterval {
        -Date().timeIntervalSince1970 + TimeInterval(server_time)
    }
    
    static var `default` = TornResponse(
        level: 30,
        gender: "Male",
        player_id: 2544362,
        name: "TravelByRocket",
        server_time: 1606434011,
        happy: BarResult.default,
        life: BarResult.default,
        energy: BarResult.default,
        nerve: BarResult.default,
        travel: TravelResult.default,
        error: ErrorResult.default
    )
}

struct TravelResult: Codable {
    var destination: String
    /// arrival timestamp
    var timestamp: Int
    /// departure timestamp
    var departed: Int
    /// seconds remaining since server refresh
    var time_left: Int
    
    static var `default` = TravelResult(destination: "UAE", timestamp: 1606434011, departed: 1606422491, time_left: 10063)
}

struct BarResult: Codable {
    var current: Int
    var maximum: Int
    var increment: Int
    var interval: Int
    var ticktime: Int
    var fulltime: Int
    
    static var `default` = BarResult(current: 75, maximum: 100, increment: 5, interval: 900, ticktime: 452, fulltime: 4952)
}

struct ErrorResult: Codable {
    var code: Int
    var error: String
    
    var codeMeaning: String {
        switch code {
        case 0:
            return "'Unknown error' : Unhandled error, should not occur."
        case 1:
            return "'Key is empty' : Private key is empty in current request."
        case 2:
            return "'Incorrect Key' : Private key is wrong/incorrect format."
        case 3:
            return "'Wrong type' : Requesting an incorrect basic type."
        case 4:
            return "'Wrong fields' : Requesting incorrect selection fields."
        case 5:
            return "'Too many requests' : Current private key is banned for a small period of time because of too many requests (max 100 per minute)."
        case 6:
            return "'Incorrect ID' : Wrong ID value."
        case 7:
            return "'Incorrect ID-entity relation' : A requested selection is private (For example, personal data of another user / faction)."
        case 8:
            return "'IP block' : Current IP is banned for a small period of time because of abuse."
        case 9:
            return "'API disabled' : Api system is currently disabled."
        case 10:
            return "'Key owner is in federal jail' : Current key can't be used because owner is in federal jail."
        case 11:
            return "'Key change error: You can only change your API key once every 60 seconds'."
        case 12:
            return "'Key read error: Error reading key from Database'."
        default:
            return "Unknown error in app"
        }
    }
    
    static var `default` = ErrorResult(code: 0, error: "A Placeholder error message")
    
}
