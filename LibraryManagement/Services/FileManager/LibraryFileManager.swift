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
    
    func save(file url: URL) throws -> String {
        if !url.isFileURL {
            throw FileOperationError.invalidFilePath
        }
        
        try ensureDirectoryAvailability(at: bookCoverImagePath.path)
        let fileName = url.lastPathComponent
        let destinationURL = bookCoverImagePath.appendingPathComponent(fileName)
        
        try fileManager.copyItem(at: url, to: destinationURL)
        return destinationURL.lastPathComponent
    }
    
    func save(data: Data, fileName: String) throws {
        try ensureDirectoryAvailability(at: bookCoverImagePath.path)
        let destinationURL = bookCoverImagePath.appendingPathComponent(fileName)
        fileManager.createFile(atPath: destinationURL.path, contents: data)
    }
    
    private func ensureDirectoryAvailability(at path: String) throws {
        if !fileManager.fileExists(atPath: path) {
            try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true)
        }
    }
}


extension LibraryFileManager {
    enum FileOperationError: Error {
        case invalidFilePath
    }
}
