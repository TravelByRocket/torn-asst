//
//  ApiManager.swift
//  TornAsst
//
//  Created by Bryan Costanza on 1/20/21.
//

import Foundation

struct ApiManager {
    static private let selections = "basic,bars,travel"

    static func loadData(_ source: ApiKeySource) {

        var apikey: String
        switch source {
        case .saved:
            apikey = UserDefaults.standard.object(forKey:"apikey") as? String ?? ""
        case .check(key: let key):
            apikey = key
        }

        guard let url = generateApiUrl(with: apikey) else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                UserDefaults.standard.set(data, forKey: "responsedata")
                UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "apicheckedat")
                print("data saved to UserDefaults")
                return
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
        print("loaded from api")
    }

    static private func generateApiUrl(with key: String) -> URL? {
        URL(string: "https://api.torn.com/user/?selections=\(selections)&key=\(key)")
    }

    enum ApiKeySource: Equatable {
        case saved
        case check(key: String)
    }
}
