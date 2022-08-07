//
//  Constants.swift
//  LibraryManagement
//
//  Created by Anbu on 15/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import Foundation

struct Constants {
    static let appName = Bundle.main.infoDictionary!["CFBundleName"] as! String

    enum Message {
        static let commonErrorMgs = "Something went wrong please try again"
        static let dismiss = "Dismiss"
        static let done = "Done"
        static let cancel = "Cancel"

        static let emptyBookName = "Enter book name"
        static let emptyAuthorName = "Enter author name"
        static let emptyDescription = "Enter description"
        static let emptyCoverImage = "Upload cover image"
    }

    enum UserDefaults {
        static let isNotificationEnable = "isNotificationEnable"
    }
}
