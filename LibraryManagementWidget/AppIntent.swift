//
//  AppIntent.swift
//  LibraryManagementWidget
//
//  Created by Anbalagan on 23/09/24.
//  Copyright © 2024 Anbalagan D. All rights reserved.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Configuration" }
    static var description: IntentDescription { "This is an example widget." }

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
}
