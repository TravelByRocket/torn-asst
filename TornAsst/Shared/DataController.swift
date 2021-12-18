//
//  DataController.swift
//  TornAsst
//
//  Created by Bryan Costanza on 15 Dec 2021.
//

import CoreData

/// An environment singleton responsinble for managing out Core Data stack, including handling saving, counting fetch
/// requests, and dealing with sample data.
class DataController: ObservableObject {
    static let dataModelName = "Model"
    /// The lone CloudKit container used to stare all our data
    let container: NSPersistentCloudKitContainer

    /// Initializes a data controler, either in memory (for temporary use such as testing and previewing), or on
    /// permanent storage (for us in regular app runs).
    ///
    /// Defaults to permanent storage.
    /// - Parameter inMemory: Whether to store this data in temporary storage or not
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: DataController.dataModelName, managedObjectModel: Self.model)

        // For testing and previewing purposes, we create a temporary, in-memory databse by writing to /dev/null/ so
        // our data is destroyed after the app finishes running.
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
        }
    }

    static var preview: DataController = {
        let dataController = DataController(inMemory: true)

        do {
            try dataController.createSampleData()
        } catch {
            fatalError("Fatal error creating preview data: \(error.localizedDescription)")
        }

        return dataController
    }()

    static let model: NSManagedObjectModel = {
        guard let url = Bundle.main.url(forResource: dataModelName, withExtension: "momd") else {
            fatalError("Failed to locate model file.")
        }

        guard let managedObjectModel = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Failed to load model file.")
        }

        return managedObjectModel
    }()

    /// This creates example projects and items to make manual testing earlier
    /// - Throws: An `NSError` sent from calling `save()` on the `NSMAnagedObjectContext`.
    func createSampleData() throws {
        let viewContext = container.viewContext

        // add the needed loops here


        try viewContext.save()
    }

    /// Saves our Core Data context iff there are changes. This silently ignores any errors caused by saving, but this
    /// should be fine because our attributes are optional.
    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }

    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
    }

    func deleteAll() {
        let types = [Daily.self]

        for type in types {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = type.fetchRequest()
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            _ = try? container.viewContext.execute(batchDeleteRequest)
        }
    }

    func count<T>(for fetchRequest: NSFetchRequest<T>) -> Int {
        (try? container.viewContext.count(for: fetchRequest)) ?? 0
    }
}
