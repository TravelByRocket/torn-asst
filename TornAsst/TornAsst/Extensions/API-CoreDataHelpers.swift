//
//  API-CoreDataHelpers.swift
//  TornAsst
//
//  Created by Bryan Costanza on 25 Dec 2021.
//

import Foundation

extension API {
    var apiKey: String {
        key ?? ""
    }

    func getRequestURL<T: DirectlyMatchedAPI>(for type: T.Type) -> URL? {
        let fields = type.apiFields.joined(separator: ",")
        let string = "https://api.torn.com/user/?selections=\(fields)&key=\(apiKey)"
        return URL(string: string)
    }

    func getRequestURL(for fieldList: [String]) -> URL? {
        let fields = fieldList.joined(separator: ",")
        let string = "https://api.torn.com/user/?selections=\(fields)&key=\(apiKey)"
        return URL(string: string)
    }

    func getNew<T: DirectlyMatchedAPI>(_ type: T.Type) async throws -> T {
        guard let url = getRequestURL(for: type.apiFields) else {
            throw FetchError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(T.self, from: data)
        return result
    }

    enum FetchError: Error {
        case invalidURL
        case missingData
    }
}
