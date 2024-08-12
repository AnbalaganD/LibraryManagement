//
//  Book.swift
//  LibraryManagement
//
//  Created by Anbu on 15/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import Foundation

struct Book: Decodable {
    let id: String
    let name: String
    let author: String
    let description: String
    let coverImage: String
    var stock: Int
}
