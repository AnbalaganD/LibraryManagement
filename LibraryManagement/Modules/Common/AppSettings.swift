//
//  AppSettings.swift
//  LibraryManagement
//
//  Created by Anbu on 28/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import Foundation

typealias UserDefaultsKey = Constants.UserDefaults

enum AppSettings {
    private static var userDefault = UserDefaults.standard

    static var isNotificationEnable: Bool {
        get { userDefault.bool(forKey: UserDefaultsKey.isNotificationEnable) }
        set { userDefault.set(newValue, forKey: UserDefaultsKey.isNotificationEnable) }
    }
}
