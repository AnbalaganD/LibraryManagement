//
//  Utils.swift
//  LibraryManagementTests
//
//  Created by Anbalagan on 30/06/24.
//  Copyright © 2024 Anbalagan D. All rights reserved.
//

import Foundation

@inlinable func apply<T: AnyObject>(_ object: T, action: (T) -> Void) -> T {
    action(object)
    return object
}
