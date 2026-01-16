//
//  AppSettings.swift
//  LibraryManagement
//
//  Created by Anbu on 28/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import Foundation

private typealias UserDefaultsKey = Constants.UserDefaults

enum AppSettings {
    nonisolated(unsafe) private static var userDefault = UserDefaults.standard

    static var isNotificationEnable: Bool {
        get { unsafe userDefault.bool(forKey: UserDefaultsKey.isNotificationEnable) }
        set { unsafe userDefault.set(newValue, forKey: UserDefaultsKey.isNotificationEnable) }
    }
}
