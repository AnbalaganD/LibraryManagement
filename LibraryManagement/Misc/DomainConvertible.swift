//
//  DomainConvertible.swift
//  LibraryManagement
//
//  Created by Anbalagan on 20/06/24.
//  Copyright © 2024 Anbalagan D. All rights reserved.
//

import Foundation

protocol DomainConvertible {
    associatedtype Model
    func toDomain() -> Model
}
