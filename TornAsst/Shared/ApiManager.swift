//
//  ApiManager.swift
//  TornAsst
//
//  Created by Bryan Costanza on 1/20/21.
//

import Foundation

class ApiManager {
    @available(*, deprecated)
    let apikeytry: String
    private let selections = "basic,bars,travel"
    
    var url: URL? {
        URL(string: "https://api.torn.com/user/?selections=basic,bars,travel&key=\(apikeytry)")
    }
    
    init() {
        self.apikeytry = "7Im0qHgainf4Xy1A"
    }
    
    @available(*, deprecated)
    func loadData() {
        guard let url = url else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                UserDefaults.standard.set(data, forKey: "responsedata")
                return
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
    func loadData(_ source: ApiKeySource) {
        var apikey: String
        switch source {
        case .saved:
            apikey = UserDefaults.standard.object(forKey:"apikey") as? String ?? ""
        case .check(key: let key):
            apikey = key
        }
        
        guard let url = getApiUrl(with: apikey) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                UserDefaults.standard.set(data, forKey: "responsedata")
                return
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
    private func getApiUrl(with key: String) -> URL? {
        URL(string: "https://api.torn.com/user/?selections=\(selections)&key=\(key)")
    }
    
    enum ApiKeySource: Equatable {
        case saved
        case check(key: String)
    }
}
