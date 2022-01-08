//
//  Cooldown-DoreDataHelpers.swift
//  TornAsst
//
//  Created by Bryan Costanza on 4 Jan 2022.
//

import Foundation

extension Cooldown: Notifying {
    var cooldownNotices: [Notice] {
        (notices?.allObjects as? [Notice] ?? []).sorted(by: \Notice.noticeOffset)
    }

    var cooldownNoticeHandling: NoticeHandling {
        if let handling = noticeHandling {
            return handling
        } else if let context = managedObjectContext {
            let handling = NoticeHandling(context: context)
            handling.cooldown = self
            return handling
        } else {
            let handling = NoticeHandling()
            handling.cooldown = self
            return handling
        }
    }

    static var example: Cooldown {
        let dataController = DataController.preview
        let viewContext = dataController.container.viewContext

        let cooldown = Cooldown(context: viewContext)
        cooldown.noticeHandling = NoticeHandling.exampleAllNormal
        cooldown.completion = Date().addingTimeInterval(TimeInterval(20))

        return cooldown
    }
}
