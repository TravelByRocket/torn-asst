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

    var playerCooldowns: Cooldowns {
        if let cooldowns = cooldowns {
            return cooldowns
        } else if let moc = managedObjectContext {
            let cooldowns = Cooldowns(context: moc)
            cooldowns.player = self
            return cooldowns
        } else {
            return Cooldowns.example
        }
    }

    var playerBars: [Bar] {
        bars?.allObjects as? [Bar] ?? []
    }

    var playerEnergy: Bar {
        if let bar = playerBars.first(where: { $0.barName == "energy" }) {
            return bar
        } else if let moc = managedObjectContext {
            let bar = Bar(context: moc)
            bar.name = "energy"
            bar.player = self
            return bar
        } else {
            return Bar.exampleEnergy
        }
    }

    var playerNerve: Bar {
        if let bar = playerBars.first(where: { $0.barName == "nerve" }) {
            return bar
        } else if let moc = managedObjectContext {
            let bar = Bar(context: moc)
            bar.name = "nerve"
            bar.player = self
            return bar
        } else {
            return Bar.exampleNerve
        }
    }

    var playerHappy: Bar {
        if let bar = playerBars.first(where: { $0.barName == "happy" }) {
            return bar
        } else if let moc = managedObjectContext {
            let bar = Bar(context: moc)
            bar.name = "happy"
            bar.player = self
            return bar
        } else {
            return Bar.exampleHappy
        }
    }

    var playerLife: Bar {
        if let bar = playerBars.first(where: { $0.barName == "life" }) {
            return bar
        } else if let moc = managedObjectContext {
            let bar = Bar(context: moc)
            bar.name = "life"
            bar.player = self
            return bar
        } else {
            return Bar.exampleLife
        }
    }

//    var playerReminders: [Reminder] {
//        if let reminders = reminders {
//            return reminders.allObjects as? [Reminder] ?? []
//        } else if let moc = managedObjectContext {
//            let bar = Bar(context: moc)
//            bar.name = "life"
//            bar.player = self
//            return bar
//        } else {
//            return Bar.exampleLife
//        }
//    }

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
