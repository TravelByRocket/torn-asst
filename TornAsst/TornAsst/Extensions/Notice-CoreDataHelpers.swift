//
//  Notice-CoreDataHelpers.swift
//  TornAsst
//
//  Created by Bryan Costanza on 23 Dec 2021.
//

import Foundation

extension Notice {
    var noticeOffset: Int {
        get {
            Int(offset)
        }
        set (newValue) {
            offset = Int32(newValue)
        }
    }

    static var exampleActive: Notice {
        let dataController = DataController.preview
        let viewContext = dataController.container.viewContext

        let notice = Notice(context: viewContext)
        notice.isActive = true
        notice.offset = 5
        notice.note = "outbound"
        notice.id = UUID()

        return notice
    }
    static var exampleInactive: Notice {
        let dataController = DataController.preview
        let viewContext = dataController.container.viewContext

        let notice = Notice(context: viewContext)
        notice.isActive = false
        notice.offset = 7
        notice.note = "outbound"
        notice.id = UUID()

        return notice
    }
}
