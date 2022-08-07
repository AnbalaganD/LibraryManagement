//
//  NotificationManager.swift
//  LibraryManagement
//
//  Created by Anbu on 30/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import Foundation

class NotificationManager {
    static let shared = NotificationManager()

    private var notificationList = [LibraryNotification]()

    private init() {}

    func getNotification() -> [LibraryNotification] {
        return notificationList
    }

    func addNotification(notification: LibraryNotification) {
        notificationList.append(notification)
    }
}
