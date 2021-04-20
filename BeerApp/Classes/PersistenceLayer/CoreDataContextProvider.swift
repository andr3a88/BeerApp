//
//  CoreDataContextProvider.swift
//  BeerApp
//
//  Created by Andrea Stevanato on 14/04/21.
//

import CoreData
import Foundation

class CoreDataContextProvider {

    static let shared = CoreDataContextProvider()

    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    private var persistentContainer: NSPersistentContainer

    init(inMemory: Bool = false, completionClosure: ((Error?) -> Void)? = nil) {
        persistentContainer = NSPersistentContainer(name: "CoreDataModel")
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            completionClosure?(error)
        }
    }

    func newBackgroundContext() -> NSManagedObjectContext {
        persistentContainer.newBackgroundContext()
    }
}
