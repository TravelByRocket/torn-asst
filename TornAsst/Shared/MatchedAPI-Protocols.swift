//
//  APIMatching.swift
//  TornAsst
//
//  Created by Bryan Costanza on 21 Dec 2021.
//

import Foundation

/// Structs that directly match API calls from the supplies field strings
protocol DirectlyMatchedAPI: Codable {
    /// All fields needed to create the downsteam object, e.g., common to add "timestamp"
    static var apiFields: [String] { get }
}

/// Signifiies objects that match the API but not at the "root" level
protocol InternallyMatchedAPI: Codable {

}
