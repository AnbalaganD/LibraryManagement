//
//  UIViewExtension.swift
//  LibraryManagement
//
//  Created by anbalagan-8641 on 16/10/23.
//  Copyright © 2023 Anbalagan D. All rights reserved.
//

import UIKit

extension UIView {
    var safeLeadingAnchor: NSLayoutXAxisAnchor {
        safeAreaLayoutGuide.leadingAnchor
    }

    var safeTrailingAnchor: NSLayoutXAxisAnchor {
        safeAreaLayoutGuide.trailingAnchor
    }

    var safeTopAnchor: NSLayoutYAxisAnchor {
        safeAreaLayoutGuide.topAnchor
    }

    var safeBottomAnchor: NSLayoutYAxisAnchor {
        safeAreaLayoutGuide.bottomAnchor
    }
}
