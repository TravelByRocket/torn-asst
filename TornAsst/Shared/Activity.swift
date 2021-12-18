//
//  UserStatus.swift
//  TornAsst
//
//  Created by Bryan Costanza on 1/10/21.
//

import Foundation

enum Activity: Equatable {
    case flying(on: Flight)
    case onGround(at: Location)
    case hospital(at: Location, until: Date)
    case jail(at: Location, until: Date)
    case apiPrompt(problem: ErrorResponse?) // nil with fresh app install
    
    func expected(at date: Date) -> Activity {
        switch self {
        case .flying(on: let flight):
            if flight.isStillFlying(at: date) {
                return self // nothing will have changed
            } else {
                return .onGround(at: flight.destination)
            }
        case .onGround(at: _):
            return self // nothing will have changed
        case .hospital(at: let location, until: let discharge):
            if discharge < date {
                return .onGround(at: location)
            } else {
                return self // nothing will have changed
            }
        case .jail(at: let location, until: let release):
            if release < date {
                return .onGround(at: location)
            } else {
                return self
            }
        case .apiPrompt(problem: _):
            return self
        }
    }
    
    struct ErrorResponse: Codable, Equatable {
        let error: ErrorDetails
        
        struct ErrorDetails: Codable, Equatable {
            var code: Int
            var error: String
        }
        
//        static var `default` = ErrorResponse(code: 13, error: "A Placeholder error message")
    }
}
