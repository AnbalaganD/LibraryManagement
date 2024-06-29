//
//  BookBuilder.swift
//  LibraryManagementTests
//
//  Created by Anbalagan on 30/06/24.
//  Copyright © 2024 Anbalagan D. All rights reserved.
//

import Foundation
@testable import LibraryManagement

final class BookBuilder {
    var id = ""
    var name = ""
    var author = ""
    var description = ""
    var coverImage = ""
    var stock = 0
    
    static func make() -> Self { .init() }
    
    func setId(_ id: String) -> Self {
        apply(self) { $0.id = id }
    }
    
    func setName(_ name: String) -> Self {
        apply(self) { $0.name = name }
    }
    
    func setauthor(_ author: String) -> Self {
        apply(self) { $0.author = author }
    }
    
    func setdescription(_ description: String) -> Self {
        apply(self) { $0.description = description }
    }
    
    func setcoverImage(_ coverImage: String) -> Self {
        apply(self) { $0.coverImage = coverImage }
    }
    
    func setStock(_ stock: Int) -> Self {
        apply(self) { $0.stock = stock }
    }
    
    func build() -> Book {
        .init(
            id: id,
            name: name,
            author: author,
            description: description,
            coverImage: coverImage,
            stock: stock
        )
    }
}
