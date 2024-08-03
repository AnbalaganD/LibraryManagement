//
//  LibraryDataManager.swift
//  LibraryManagement
//
//  Created by Anbalagan on 30/03/24.
//  Copyright © 2024 Anbalagan D. All rights reserved.
//

import Foundation

final class LibraryDataManager {
    private let coredataStack: CoreDataStack
    private let fileManager: LibraryFileManager
    
    init(
        coredataStack: CoreDataStack,
        fileManager: LibraryFileManager
    ) {
        self.coredataStack = coredataStack
        self.fileManager = fileManager
    }
    
    func books() async throws -> [Book] {
        try await coredataStack.performBackgroundTask { context in
            let fetchRequest = BookEntity.fetchRequest()
            let bookEntities = try context.fetch(fetchRequest)
            return bookEntities.map { $0.toDomain() }
        }
    }
    
    func addOrUpdate(book: Book) async throws {
        try await coredataStack.performBackgroundTask { context in
            let fetchRequest = BookEntity.fetchRequest()
            
            let bookPredicate = #Predicate<BookEntity> {[author = book.author, name = book.name] entity in
                entity.author == author && entity.name == name
            }
            fetchRequest.predicate = NSPredicate(bookPredicate)
            fetchRequest.fetchLimit = 1
            let bookEntities = try context.fetch(fetchRequest)
            
            if bookEntities.count == 0 {
                // Add new book
                let bookEntity = BookEntity(context: context)
                bookEntity.author = book.author
                bookEntity.name = book.name
                bookEntity.bookDescription = book.description
                bookEntity.stock = 1
                bookEntity.coverImage = nil
                bookEntity.id = UUID().uuidString
            } else {
                // Update stock count of existing book
                let bookEntity = bookEntities[0]
                bookEntity.stock += 1
            }
            try context.save()
        }
    }
}
