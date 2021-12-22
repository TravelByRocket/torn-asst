//
//  User-CoreDataHelpers.swift
//  TornAsst (iOS)
//
//  Created by Bryan Costanza on 19 Dec 2021.
//

import Foundation
import CoreData

extension Player {

    var playerAPIKey: String {
        apiKey ?? ""
    }

    var playerAPIError: String {
        apiError ?? ""
    }

    var playerBars: [Bar] {
        bars?.allObjects as? [Bar] ?? []
    }

    var playerEnergy: Bar {
        playerBars.first { $0.barLabel == "energy" } ?? Bar.exampleEnergy
    }

    var playerNerve: Bar {
        playerBars.first { $0.barLabel == "nerve" } ?? Bar.exampleNerve
    }

    var playerHappy: Bar {
        playerBars.first { $0.barLabel == "happy" } ?? Bar.exampleHappy
    }

    var playerLife: Bar {
        playerBars.first { $0.barLabel == "life" } ?? Bar.exampleLife
    }

    var playerTravel: TravelTrip {
        if let travel = travel {
            return travel
        } else if let moc = managedObjectContext {
            let travel = TravelTrip(context: moc)
            try? moc.save()
            return travel
        } else {
            return TravelTrip.example
        }
    }

    static var example: Player {
        let dataController = DataController.preview
        let viewContext = dataController.container.viewContext

        let player = Player(context: viewContext)
        return player
    }

//    static func getFirstAndOnlyUser(context: NSManagedObjectContext) -> User {
//        let user = (try? context.fetch(User.fetchRequest()).first) ?? User(context: context)
//        let user = (try? User.fetchRequest().execute().first) ?? User(context: context)
//        try? context.save()
//        return user
//    }
}
