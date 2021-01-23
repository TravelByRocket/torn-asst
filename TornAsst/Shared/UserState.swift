//
//  UserState.swift
//  TornAsst
//
//  Created by Bryan Costanza on 1/10/21.
//

import Foundation

class UserState: ObservableObject {
    @Published var activity: Activity
    var stats: Stats!
    
    init() {
        activity = .apiPrompt(problem: nil)
    }
    
    func refresh() {
        if let data = UserDefaults.standard.object(forKey: "responsedata") as? Data {
            if let decodedResponse = try? JSONDecoder().decode(Stats.self, from: data) {
                stats = decodedResponse
                return
            } else if let decodedResponse = try? JSONDecoder().decode(Activity.ErrorResponse.self, from: data) {
                activity = .apiPrompt(problem: decodedResponse)
            } else {
                fatalError("User refresh failed. Exiting.")
            }
        }
    }
    
}
