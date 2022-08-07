//
//  BookManger.swift
//  LibraryManagement
//
//  Created by Anbu on 27/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import Foundation

enum BookMangerError: String, Error {
    case bookNotFound = "Book Not Found"
    case bookOutOfStock = "Book is out of stock"
    case bookStockInvalid = "Given book stock value invalid"
    case invalidRequsetId = "Book request id is invalid"
    case invalidStatusChange = "Don't have permission to change the status"
}

class BookManager {
    static let shared = BookManager()

    private var bookRequestList = [BookRequest]()
    private var bookList = [Book]()

    private init() {
        addMockData()
    }

    func getBooks() -> [Book] {
        return bookList
    }

    func addBook(book: Book) {
        bookList.append(book)
    }

    func updateBook(book: Book) throws {
        let index: Int? = bookList.firstIndex { $0.id == book.id }

        guard let updateIndex = index else {
            throw BookMangerError.bookNotFound
        }

        if book.stock < 0 {
            throw BookMangerError.bookStockInvalid
        }

        bookList[updateIndex] = book
    }

    func deleteBook(id: String) throws {
        let index: Int? = bookList.firstIndex { $0.id == id }

        guard let deleteIndex = index else {
            throw BookMangerError.bookNotFound
        }
        bookList.remove(at: deleteIndex)
    }

    func getBookRequest() -> [BookRequest] {
        return bookRequestList
    }

    func addBookRequest(request: BookRequest) {
        bookRequestList.append(request)
    }

    func updateRequestyStatus(id: String, status: BookRequestStatus) throws {
        let requestIndex: Int? = bookRequestList.firstIndex { $0.id == id }

        guard let rIndex = requestIndex else {
            throw BookMangerError.invalidRequsetId
        }
        let bookId = bookRequestList[rIndex].bookId
        let index: Int? = bookList.firstIndex { $0.id == bookId }

        guard let updateIndex = index else {
            throw BookMangerError.bookNotFound
        }

        if status == .accept, bookList[updateIndex].stock == 0 {
            throw BookMangerError.bookOutOfStock
        }

        if bookRequestList[rIndex].status != .pending {
            throw BookMangerError.invalidStatusChange
        }

        bookRequestList[rIndex].status = status
        if status == .accept {
            bookList[updateIndex].stock = bookList[updateIndex].stock - 1
        }
    }

    private func addMockData() {
        bookList.append(Book(id: UUID().uuidString, name: "Java Programming 8", author:
            "James gosling", description: "Java is a general purpose programming language that is class based, object oriented, and designed to have as few implementation dependencies as possible.", coverImage: "java_logo", stock: 10))
        bookList.append(Book(id: UUID().uuidString, name: "Swift 5", author:
            "Paul Hudson", description: "Swift 5 is finally available in Xcode 10.2! This release brings ABI stability and improves the language with some long-awaited features.", coverImage: "swift", stock: 5))
        bookList.append(Book(id: UUID().uuidString, name: "Kotlin for Android", author:
            "Andrey Breslav", description: "Kotlin is a great fit for developing Android applications, bringing all of the advantages of a modern language to the Android platform without introducing any new restrictions", coverImage: "kotlin", stock: 0))
        bookList.append(Book(id: UUID().uuidString, name: "Advanced C# Programming", author:
            "Anders Hejlsberg", description: "C# is a simple, modern, general-purpose, object-oriented programming language developed by Microsoft within its .NET initiative led by Anders Hejlsberg", coverImage: "c_sharp", stock: 1))

        // Book Request List
        bookRequestList.append(BookRequest(id: UUID().uuidString.substring(fromIndex: 0, count: 8), userName: "Anbalagan D", date: "13/05/2019 at 12:05 PM", bookName: "Java Programming 8", status: .pending, bookId: bookList[0].id))
        bookRequestList.append(BookRequest(id: UUID().uuidString.substring(fromIndex: 0, count: 8), userName: "Anbalagan D", date: "15/05/2019 at 06:43 AM", bookName: "Advanced C# Programming", status: .pending, bookId: bookList[3].id))
        bookRequestList.append(BookRequest(id: UUID().uuidString.substring(fromIndex: 0, count: 8), userName: "Anbalagan D", date: "20/05/2019 at 01:27 PM", bookName: "Kotlin for Android", status: .pending, bookId: bookList[2].id))
    }
}
