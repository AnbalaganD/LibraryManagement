//
//  CoreDataStack.swift
//  LibraryManagement
//
//  Created by Anbalagan on 23/03/24.
//  Copyright © 2024 Anbalagan D. All rights reserved.
//

import CoreData

final class CoreDataStack {
    
    private var persistentContainer: NSPersistentContainer!
    
    nonisolated(unsafe) static let shared = CoreDataStack()
    
    private init() {
        loadPresistentStore()
    }
    
    private func loadPresistentStore() {
        persistentContainer = NSPersistentContainer(name: "LibraryManagement")
        persistentContainer?.loadPersistentStores { storeDescription, error in
            print(error ?? "")
            print(storeDescription.url ?? "")
        }
    }
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func newBackgroundContext() -> NSManagedObjectContext {
        persistentContainer.newBackgroundContext()
    }
    
    func performBackgroundTask<T>(
        _ block: @escaping (NSManagedObjectContext) throws -> T
    ) async rethrows -> T {
        try await persistentContainer.performBackgroundTask(block)
    }
}
