//
//  NSManagedObjectContextExtension.swift
//  LibraryManagement
//
//  Created by Anbalagan on 01/07/24.
//  Copyright © 2024 Anbalagan D. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {
    func saveIfNeeded() throws {
        if !hasChanges { return }
        try save()
    }
}
