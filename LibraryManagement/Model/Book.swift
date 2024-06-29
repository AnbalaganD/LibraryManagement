//
//  Book.swift
//  LibraryManagement
//
//  Created by Anbu on 15/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

struct Book {
    let id: String
    let name: String
    let author: String
    let description: String
    let coverImage: String
    var stock: Int
}

//extension Book {
//    init(from entity: BookEntity) {
//        self.id = entity.id
//        self.name = entity.name
//        self.author = entity.author
//        self.description = entity.bookDescription
//        self.coverImage = ""
//        self.stock = Int(entity.stock)
//    }
//}
