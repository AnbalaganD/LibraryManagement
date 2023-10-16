//
//  StringExtension.swift
//  LibraryManagement
//
//  Created by Anbu on 15/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import Foundation

extension String {
    static var empty: String {
        return ""
    }

    func substring(
        fromIndex: Int,
        count: Int
    ) -> String {
        let startIndex = index(self.startIndex, offsetBy: fromIndex)
        let endIndex = index(self.startIndex, offsetBy: fromIndex + count)
        let range = startIndex ..< endIndex
        return String(self[range])
    }
}
