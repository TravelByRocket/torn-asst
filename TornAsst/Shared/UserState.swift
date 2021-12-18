//
//  UserState.swift
//  TornAsst
//
//  Created by Bryan Costanza on 1/10/21.
//

import Foundation

class UserState: ObservableObject {
    @Published var activity: Activity!
    @Published var stats: Stats!
    
    init() {
        print("UserState.init()")
        if let _ = UserDefaults.standard.object(forKey: "responsedata") as? Data {
            refresh()
        } else {
            activity = .apiPrompt(problem: nil)
        }
    }
    
    func refresh() {
        if let data = UserDefaults.standard.object(forKey: "responsedata") as? Data {
            if let decodedResponse = try? JSONDecoder().decode(Stats.self, from: data) {
                let travel = decodedResponse.travel
                if travel.time_left > 0 {
                    let flight = Flight(
                        destination: travel.destination,
                        timestamp: UnixTime(travel.timestamp),
                        departed: UnixTime(travel.departed),
                        timeLeft: UnixTime(travel.time_left))
                    activity = .flying(on: flight)
                } else if travel.time_left == 0 {
                    activity = .onGround(at: Location(rawValue: travel.destination)!)
                }
                // TODO add jail and hospital checks
                stats = decodedResponse
                print("Decoded as Stats")
            } else if let decodedResponse = try? JSONDecoder().decode(Activity.ErrorResponse.self, from: data) {
                activity = .apiPrompt(problem: decodedResponse)
                UserDefaults.standard.removeObject(forKey: "responsedata")
                print("Decoded as Error")
            } else {
                activity = .apiPrompt(
                    problem: Activity.ErrorResponse(
                        error: Activity.ErrorResponse.ErrorDetails(
                            code: 99,
                            error: "App Decode Failure")
                    )
                )
                print("Decoding failed")
            }
        }
        print("user refresh completed")
    }
}
