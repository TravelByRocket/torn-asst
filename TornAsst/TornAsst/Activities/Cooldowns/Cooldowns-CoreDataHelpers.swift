//
//  Cooldowns-CoreDataHelpers.swift
//  TornAsst
//
//  Created by Bryan Costanza on 2 Jan 2022.
//

import Foundation

extension Cooldowns {
    var cooldownDrug: Cooldown {
        if let cdDrug = cdDrug {
            return cdDrug
        } else if let context = managedObjectContext {
            let cdDrug = Cooldown(context: context)
            cdDrug.drugFor = self
            return cdDrug
        } else {
            let cdDrug = Cooldown()
            cdDrug.drugFor = self
            return cdDrug
        }
    }

    var cooldownMedical: Cooldown {
        if let cdMedical = cdMedical {
            return cdMedical
        } else if let context = managedObjectContext {
            let cdMedical = Cooldown(context: context)
            cdMedical.medicalFor = self
            return cdMedical
        } else {
            let cdMedical = Cooldown()
            cdMedical.medicalFor = self
            return cdMedical
        }
    }

    var cooldownBooster: Cooldown {
        if let cdBooster = cdBooster {
            return cdBooster
        } else if let context = managedObjectContext {
            let cdBooster = Cooldown(context: context)
            cdBooster.boosterFor = self
            return cdBooster
        } else {
            let cdBooster = Cooldown()
            cdBooster.boosterFor = self
            return cdBooster
        }
    }

    func setFromJSON(_ json: JSON) {
        cooldownDrug.completion = json.cooldowns.drug > 0
        ? Date(timeIntervalSince1970: TimeInterval(json.timestamp + json.cooldowns.drug)) : nil

        cooldownMedical.completion = json.cooldowns.medical > 0
        ? Date(timeIntervalSince1970: TimeInterval(json.timestamp + json.cooldowns.medical)) : nil

        cooldownBooster.completion = json.cooldowns.booster > 0
        ? Date(timeIntervalSince1970: TimeInterval(json.timestamp + json.cooldowns.booster)) : nil
    }

    struct JSON: DirectlyMatchedAPI {
        static var apiFields = ["cooldowns", "timestamp"]
        let timestamp: Int
        let cooldowns: InternalJSON
    }

    struct InternalJSON: InternallyMatchedAPI {
        let drug: Int
        let medical: Int
        let booster: Int
    }

    static var example: Cooldowns {
        let dataController = DataController.preview
        let viewContext = dataController.container.viewContext

        let cooldowns = Cooldowns(context: viewContext)
        cooldowns.cooldownDrug.completion = Date().addingTimeInterval(30)
        cooldowns.cooldownMedical.completion = Date().addingTimeInterval(40)
        cooldowns.cooldownBooster.completion = Date().addingTimeInterval(20)

        return cooldowns
    }

}
