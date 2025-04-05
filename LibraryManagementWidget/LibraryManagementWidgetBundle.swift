//
//  LibraryManagementWidgetBundle.swift
//  LibraryManagementWidget
//
//  Created by Anbalagan on 23/09/24.
//  Copyright © 2024 Anbalagan D. All rights reserved.
//

import WidgetKit
import SwiftUI

@main
struct LibraryManagementWidgetBundle: WidgetBundle {
    var body: some Widget {
        LibraryManagementWidget()
        LibraryManagementWidgetControl()
        LibraryManagementWidgetLiveActivity()
    }
}
