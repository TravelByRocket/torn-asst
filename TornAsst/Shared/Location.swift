//
//  City.swift
//  TornAsst
//
//  Created by Bryan Costanza on 1/10/21.
//

import Foundation

enum Location: String {
    case Torn = "Torn" // this raw value is confirmed
    case Mexico = "Mexico" // TODO confirm this API name
    case CaymanIslands = "Cayman Islands" // TODO confirm this API name
    case Canada = "Canada" // TODO confirm this API name
    case Hawaii = "Hawaii" // TODO confirm this API name
    case UnitedKingdom = "United Kingdom" // TODO confirm this API name
    case Argentina = "Argentina" // TODO confirm this API name
    case Switzerland = "Switzerland" // TODO confirm this API name
    case Japan = "Japan" // TODO confirm this API name
    case China = "China" // TODO confirm this API name
    case UAE = "UAE" // this raw value is confirmed
    case SouthAfrica = "South Africa" // this raw value is confirmed
    // TODO raw values should match API reponse and then can later be set with Location(rawValue: String)
    
    var names: (country: String, city: String) {
        switch self {
        case .Torn:
            return ("USA", "Torn")
        case .Mexico:
            return ("Mexico", "Ciudad Juárez")
        case .CaymanIslands:
            return ("Cayman Islands", "George Town")
        case .Canada:
            return ("Canada", "Toronto")
        case .Hawaii:
            return ("Hawaii", "Honolulu")
        case .UnitedKingdom:
            return ("United Kingdom", "London")
        case .Argentina:
            return ("Argentina", "Buenos Aires")
        case .Switzerland:
            return ("Switzerland", "Zurich")
        case .Japan:
            return ("Japan", "Tokyo")
        case .China:
            return ("China", "Beijing")
        case .UAE:
            return ("United Arab Emirates", "Dubai")
        case .SouthAfrica:
            return ("South Africa", "Johannesburg")
        }
    }    
}
