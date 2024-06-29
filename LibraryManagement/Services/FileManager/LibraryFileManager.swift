//
//  LibraryFileManager.swift
//  LibraryManagement
//
//  Created by Anbalagan on 30/03/24.
//  Copyright © 2024 Anbalagan D. All rights reserved.
//

import Foundation

final class LibraryFileManager {
    
    // For simplicity as of now focus on only one, things will change this in future.
    // Remove all hardcode value and make this as generics
    private let fileManager: FileManager = .default
    
    private let bookCoverImagePath: URL
    
    init() {
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        if let firstUrl = urls.first {
            bookCoverImagePath = firstUrl.appending(path: "BookCoverImages")
        } else {
            fatalError()
        }
    }
    
//    init(fileManager: FileManager = .default) {
//        self.fileManager = fileManager
//    }
    
    func save(file url: URL) throws {
        if url.isFileURL {
            throw FileOperationError.invalidFilePath
        }
        
        print("File Saved")
    }
}


extension LibraryFileManager {
    enum FileOperationError: Error {
        case invalidFilePath
    }
}
