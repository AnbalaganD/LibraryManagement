//
//  AppDelegate.swift
//  LibraryManagement
//
//  Created by Anbu on 15/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let navController = UINavigationController(rootViewController: BookListController())
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        window?.tintColor = .orange
        _ = LibraryFileManager()
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        NotificationManager.shared.setNotificationBadgeCount(0)
    }

    func application(
        _: UIApplication,
        performActionFor shortcutItem: UIApplicationShortcutItem,
        completionHandler _: @escaping (Bool) -> Void
    ) {
        if let shortcutItemType = ShortcutIdentifier(rawValue: shortcutItem.type) {
            switch shortcutItemType {
            case .addBook:
                if let navController = window?.rootViewController as? UINavigationController {
                    if let bookListController = navController.viewControllers.first(where: { $0 is BookListController }) as? BookListController {
                        if bookListController.presentedViewController != nil {
                            bookListController.presentedViewController?.dismiss(animated: false)
                        }
                        bookListController.addBookTapped()
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
