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
    
    override public func awakeFromInsert() {
        super.awakeFromInsert()
//        print(#function)
//        setPrimitiveValue("0001", forKey: "id")
//        setPrimitiveValue("Life Story of Anbu", forKey: "name")
//        setPrimitiveValue("Anbu", forKey: "author")
//        setPrimitiveValue("Nothing is special. Stay calm and foucs on your goal. And be happy yourself", forKey: "bookDescription")
//        setPrimitiveValue(10, forKey: "stock")
    }
}

extension BookEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookEntity> {
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

//extension BookEntity {
//    convenience init(book: Book, description: NSEntityDescription) {
//        fatalError()
//    }
//}


extension BookEntity: DomainConvertible {
    func toDomain() -> Book {
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
