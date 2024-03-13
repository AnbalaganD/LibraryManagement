//
//  NotificationManager.swift
//  LibraryManagement
//
//  Created by Anbu on 30/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import Foundation
import UserNotifications

final class NotificationManager: NSObject {
    static let shared = NotificationManager()

    private var notificationList = [LibraryNotification]()

    private override init() {
        super.init()
        initalSetup()
    }

    private func initalSetup() {
        UNUserNotificationCenter.current().delegate = self
    }

    func requestNotificationAuthorization(_ completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { granted, _ in
            completion(granted)
        }
    }

    func checkHasNotificationPermission(_ completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { notificationSettings in
            completion(notificationSettings.authorizationStatus == .authorized)
        }
    }

    func setNotificationBadgeCount(_ count: Int) {
        UNUserNotificationCenter.current().setBadgeCount(count)
    }

    func getNotification() -> [LibraryNotification] {
        return notificationList
    }

    func addNotification(notification: LibraryNotification) {
        notificationList.append(notification)
        triggerNotification(notification)
    }

    private func triggerNotification(_ notification: LibraryNotification) {
        let content = UNMutableNotificationContent()
        content.title = "New Book Request"
        content.body = "\(notification.userName) is request \(notification.bookName)"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 0.1,
            repeats: false
        )
        let notificationRequest = UNNotificationRequest(
            identifier: "newBookRequest",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(notificationRequest) { error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        setNotificationBadgeCount(0)
        print(response.notification.request.content.title)
        completionHandler()
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        setNotificationBadgeCount(0)
        completionHandler([.list, .banner, .badge, .sound])
    }
}
