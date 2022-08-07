//
//  AppDelegate.swift
//  LibraryManagement
//
//  Created by Anbu on 15/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    var launchedShortcutItem: UIApplicationShortcutItem?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            if !granted {
                print("User has declined notification")
            }
        }
        UNUserNotificationCenter.current().delegate = self
        application.applicationIconBadgeNumber = 0
        let navController = UINavigationController(rootViewController: BookListController())
        window?.rootViewController = navController

        window?.makeKeyAndVisible()
        window?.tintColor = .orange
        window?.backgroundColor = .white
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
    }

    func application(_: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler _: @escaping (Bool) -> Void) {
        if let shortcutItemType = ShortcutIdentifier(rawValue: shortcutItem.type) {
            switch shortcutItemType {
            case .addBook:
                if let navController = window?.rootViewController as? UINavigationController {
                    if let bookListController = navController.viewControllers.first(where: { $0 is BookListController }) as? BookListController {
                        if bookListController.presentedViewController != nil {
                            bookListController.presentedViewController?.dismiss(animated: false, completion: nil)
                        }
                        bookListController.addBookTapped(String.empty)
                    }
                }
            case .searchBook:
                if let navController = window?.rootViewController as? UINavigationController {
                    if let bookListController = navController.viewControllers.first(where: { $0 is BookListController }) as? BookListController {
                        bookListController.focusSearchBar()
                    }
                }
            }
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        print(response.notification.request.content.title)
        completionHandler()
    }

    func userNotificationCenter(_: UNUserNotificationCenter, willPresent _: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        completionHandler([.alert, .badge, .sound])
    }
}
