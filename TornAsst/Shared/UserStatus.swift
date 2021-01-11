//
//  UserStatus.swift
//  TornAsst
//
//  Created by Bryan Costanza on 1/10/21.
//

import Foundation

enum UserStatus {
    case flying(on: Flight)
    case onGround(at: Location)
    case hospital(at: Location, until: Date)
    case jail(at: Location, until: Date) // TODO what about jail abroad?
    case apiError(problem: ErrorResult) // TODO should this be an optional or create a case for no problem?
    
    func expectedStatus(at date: Date) -> UserStatus {
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
        case .apiError(problem: _):
            return self
        }
    }
}
