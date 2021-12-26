//
//  User-CoreDataHelpers.swift
//  TornAsst (iOS)
//
//  Created by Bryan Costanza on 19 Dec 2021.
//

import Foundation
import CoreData

extension Player {
    var playerAPI: API {
        if let api = api {
            return api
        } else if let context = managedObjectContext {
            let api = API(context: context)
            api.player = self
            api.key = "wruaSWbBvFqNYXTV"
            return api
        } else {
            let api = API()
            api.player = self
            return api
        }
    }

    var playerBasics: Basics {
        if let basics = basics {
            return basics
        } else if let context = managedObjectContext {
            let basics = Basics(context: context)
            basics.player = self
            return basics
        } else {
            let basics = Basics()
            basics.player = self
            return basics
        }
    }

    var playerTravel: Travel {
        if let travel = travel {
            return travel
        } else if let moc = managedObjectContext {
            let travel = Travel(context: moc)
            travel.player = self
            return travel
        } else {
            return Travel.example
        }
    }

    var playerBars: [Bar] {
        bars?.allObjects as? [Bar] ?? []
    }

    var playerEnergy: Bar {
        playerBars.first { $0.barName == "energy" } ?? Bar.exampleEnergy
    }

    var playerNerve: Bar {
        playerBars.first { $0.barName == "nerve" } ?? Bar.exampleNerve
    }

    var playerHappy: Bar {
        playerBars.first { $0.barName == "happy" } ?? Bar.exampleHappy
    }

    var playerLife: Bar {
        playerBars.first { $0.barName == "life" } ?? Bar.exampleLife
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
