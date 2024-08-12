//
//  BookTest.swift
//  LibraryManagementTests
//
//  Created by Anbalagan on 30/06/24.
//  Copyright © 2024 Anbalagan D. All rights reserved.
//

import Testing
@testable import LibraryManagement

struct BookTest {
    @Test
    func validateStock() {
        let book = BookBuilder.make()
            .setStock(12)
            .build()
        
        #expect(book.stock == 12)
    }
}
