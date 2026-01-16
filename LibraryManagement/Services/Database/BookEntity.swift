//
//  BookEntity.swift
//  LibraryManagement
//
//  Created by Anbalagan on 28/03/24.
//  Copyright © 2024 Anbalagan D. All rights reserved.
//

import Foundation
import CoreData

@objc(BookEntity)
public class BookEntity: NSManagedObject {
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var author: String
    @NSManaged public var bookDescription: String
    @NSManaged public var coverImage: URL?
    @NSManaged public var stock: Int64
}

extension BookEntity {
    @nonobjc nonisolated public class func fetchRequest() -> NSFetchRequest<BookEntity> {
        return NSFetchRequest<BookEntity>(entityName: "Book")
    }
    
    @nonobjc public class func entityDescription(
        in context: NSManagedObjectContext
    ) -> NSEntityDescription? {
        NSEntityDescription.entity(
            forEntityName: "Book",
            in: context
        )
    }
}

extension BookEntity: DomainConvertible {
    nonisolated func toDomain() -> Book {
        Book(
            id: id,
            name: name,
            author: author,
            description: bookDescription,
            coverImage: "",
            stock: Int(stock)
        )
    }
}
