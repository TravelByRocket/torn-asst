//
//  NoticeHandling-CoreDataHelpers.swift
//  TornAsst
//
//  Created by Bryan Costanza on 4 Jan 2022.
//

import Foundation

extension NoticeHandling {
    var noticeWhileHospitalized: Strategy {
        get {
            return Strategy(rawValue: whileHospitalized ?? "normal") ?? .normal
        } set {
            whileHospitalized = newValue.rawValue
        }
    }

    var noticeWhileJailed: Strategy {
        get {
            return Strategy(rawValue: whileJailed ?? "normal") ?? .normal
        } set {
            whileJailed = newValue.rawValue
        }
    }

    var noticeWhileTraveling: Strategy {
        get {
            return Strategy(rawValue: whileTraveling ?? "normal") ?? .normal
        } set {
            whileTraveling = newValue.rawValue
        }
    }

    enum Strategy: String {
        case normal
        case `defer`
        case skip
    }

    static var exampleAllNormal: NoticeHandling {
        let dataController = DataController.preview
        let viewContext = dataController.container.viewContext

        let strategy = NoticeHandling(context: viewContext)
        strategy.noticeWhileHospitalized = .normal
        strategy.noticeWhileJailed = .normal
        strategy.noticeWhileTraveling = .normal

        return strategy
    }

    static var exampleAllDefer: NoticeHandling {
        let dataController = DataController.preview
        let viewContext = dataController.container.viewContext

        let strategy = NoticeHandling(context: viewContext)
        strategy.noticeWhileHospitalized = .defer
        strategy.noticeWhileJailed = .defer
        strategy.noticeWhileTraveling = .defer

        return strategy
    }

    static var exampleAllSkip: NoticeHandling {
        let dataController = DataController.preview
        let viewContext = dataController.container.viewContext

        let strategy = NoticeHandling(context: viewContext)
        strategy.noticeWhileHospitalized = .skip
        strategy.noticeWhileJailed = .skip
        strategy.noticeWhileTraveling = .skip

        return strategy
    }
}
