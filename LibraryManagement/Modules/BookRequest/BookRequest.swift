//
//  BookRequest.swift
//  LibraryManagement
//
//  Created by Anbu on 22/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import Foundation

struct BookRequest {
    let id: String
    let userName: String
    let date: Date
    let bookName: String
    var status: BookRequestStatus
    var bookId: String
}
