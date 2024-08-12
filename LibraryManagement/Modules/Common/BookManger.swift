//
//  BookManger.swift
//  LibraryManagement
//
//  Created by Anbu on 27/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import Foundation
import CoreData

enum BookMangerError: String, Error {
    case bookNotFound = "Book Not Found"
    case bookOutOfStock = "Book is out of stock"
    case bookStockInvalid = "Given book stock value invalid"
    case invalidRequsetId = "Book request id is invalid"
    case invalidStatusChange = "Don't have permission to change the status"
}

final class BookManager {
    nonisolated(unsafe) static let shared = BookManager()

    private var bookRequestList = [BookRequest]()
    private var bookList = [Book]()

    private init() {
        #if DEBUG
        addMockData()
        addDummyDataToDatabase()
        #endif
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
        bookRequestList
    }

    func addBookRequest(request: BookRequest) {
        bookRequestList.append(request)
    }

    func updateRequestyStatus(
        id: String,
        status: BookRequestStatus
    ) throws {
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
            bookList[updateIndex].stock -= 1
        }
    }

    #if DEBUG
    private func addMockData() {
        guard let bookJSONFileURL = Bundle.main.url(forResource: "books", withExtension: "json"),
        let booksData = try? Data(contentsOf: bookJSONFileURL) else {
            return
        }
        
        guard let books = try? JSONDecoder().decode([Book].self, from: booksData) else {
            return
        }
        
        bookList.append(contentsOf: books)

        let startDate = Date().addingTimeInterval(-(60 * 60 * 24 * 30)) // From last one month
        
        let bookRequest1 = bookList.randomElement()!
        let bookRequest2 = bookList.randomElement()!
        let bookRequest3 = bookList.randomElement()!
        
        bookRequestList.append(contentsOf: [
            BookRequest(
                id: UUID().uuidString.substring(fromIndex: 0, count: 8),
                userName: "Anbalagan D",
                date: .randomDate(in: startDate ... .now),
                bookName: bookRequest1.name,
                status: .pending,
                bookId: bookRequest1.id
            ),
            BookRequest(
                id: UUID().uuidString.substring(fromIndex: 0, count: 8),
                userName: "Anbalagan D",
                date: .randomDate(in: startDate ... .now),
                bookName: bookRequest2.name,
                status: .pending,
                bookId: bookRequest2.id
            ),
            BookRequest(
                id: UUID().uuidString.substring(fromIndex: 0, count: 8),
                userName: "Anbalagan D",
                date: .randomDate(in: startDate ... .now),
                bookName: bookRequest3.name,
                status: .pending,
                bookId: bookRequest3.id
            ),
        ])
    }
    
    private func addDummyDataToDatabase() {
        Task {
            await CoreDataStack.shared.performBackgroundTask { managedObjectContext in
                guard let bookEntityDescription = NSEntityDescription.entity(
                    forEntityName: "Book",
                    in: managedObjectContext
                ) else {
                    return
                }
                
//                let bookEntity = BookEntity(
//                    entity: bookEntityDescription,
//                    insertInto: managedObjectContext
//                )
                
                let bookEntity = BookEntity(context: managedObjectContext)
                
                print(bookEntity.author)
                try? managedObjectContext.save()
            }
        }
    }
    #endif
}
