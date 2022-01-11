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

    var apiErrorCode: Int {
        get {
            Int(code)
        } set {
            code = Int16(newValue)
        }
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

    func getNew<T: DirectlyMatchedAPI>(_ type: T.Type) async throws -> T? {
        guard let url = getRequestURL(for: type.apiFields) else {
            throw FetchError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        lastChecked = Date()
        if isErrorResponse(data: data) {
            let result = try JSONDecoder().decode(ErrorJSON.self, from: data)
            apiErrorCode = result.error.code
            error = result.error.error
            return nil
        } else {
            let result = try JSONDecoder().decode(T.self, from: data)
            apiErrorCode = 0
            error = nil
            return result
        }
    }

    enum FetchError: Error {
        case invalidURL
        case missingData
    }

    func isErrorResponse(data: Data) -> Bool {
        let dataAsString = String(data: data, encoding: .utf8) ?? ""
        let isErrorResponse = dataAsString.contains("error") && dataAsString.contains("code")
        return isErrorResponse
    }
}
