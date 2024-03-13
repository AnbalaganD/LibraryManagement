//
//  DateExtension.swift
//  LibraryManagement
//
//  Created by Anbalagan on 13/03/24.
//  Copyright © 2024 Anbalagan D. All rights reserved.
//

import Foundation

extension Date {
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

#if DEBUG
    static func randomDate(in range: ClosedRange<Date>) -> Date {
        let randomInterval = Double.random(
            in: range.lowerBound.timeIntervalSince1970 ... range.upperBound.timeIntervalSince1970
        )
        return Date(timeIntervalSince1970: randomInterval)
    }
#endif
}
