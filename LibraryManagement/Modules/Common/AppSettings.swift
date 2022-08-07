//
//  AppSettings.swift
//  LibraryManagement
//
//  Created by Anbu on 28/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import Foundation

class AppSettings {
    static var isNotificationEnable: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Constants.UserDefaults.isNotificationEnable)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.UserDefaults.isNotificationEnable)
        }
    }
}
