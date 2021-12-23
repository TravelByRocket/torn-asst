//
//  Bar-Examples.swift
//  TornAsst (iOS)
//
//  Created by Bryan Costanza on 19 Dec 2021.
//

import Foundation

extension Bar {
    static var exampleEnergy: Bar {
        let dataController = DataController.preview
        let viewContext = dataController.container.viewContext

        let bar = Bar(context: viewContext)
        bar.name = "energy"
        bar.date = Date()
        bar.current = 105
        bar.maximum = 150
        bar.increment = 5
        bar.interval = 600
        bar.ticktime = 98
        bar.fulltime = 1000

        return bar
    }

    static var exampleNerve: Bar {
        let dataController = DataController.preview
        let viewContext = dataController.container.viewContext

        let bar = Bar(context: viewContext)
        bar.name = "nerve"
        bar.date = Date()
        bar.current = 22
        bar.maximum = 55
        bar.increment = 1
        bar.interval = 300
        bar.ticktime = 98
        bar.fulltime = 9698

        return bar
    }

    static var exampleHappy: Bar {
        let dataController = DataController.preview
        let viewContext = dataController.container.viewContext

        let bar = Bar(context: viewContext)
        bar.name = "happy"
        bar.date = Date()
        bar.current = 4525
        bar.maximum = 4525
        bar.increment = 5
        bar.interval = 900
        bar.ticktime = 698
        bar.fulltime = 0

        return bar
    }

    static var exampleLife: Bar {
        let dataController = DataController.preview
        let viewContext = dataController.container.viewContext

        let bar = Bar(context: viewContext)
        bar.name = "life"
        bar.date = Date()
        bar.current = 3562
        bar.maximum = 3562
        bar.increment = 249
        bar.interval = 300
        bar.ticktime = 98
        bar.fulltime = 0

        return bar
    }
}
