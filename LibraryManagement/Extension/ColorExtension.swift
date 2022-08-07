//
//  ColorExtension.swift
//  LibraryManagement
//
//  Created by Anbu on 15/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String) {
        var hexColorString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        hexColorString.removeFirst()

        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 1.0

        switch hexColorString.count {
        case 3:
            red = CGFloat(Int(hexColorString.substring(fromIndex: 0, count: 1), radix: 16)!)
            green = CGFloat(Int(hexColorString.substring(fromIndex: 1, count: 1), radix: 16)!)
            blue = CGFloat(Int(hexColorString.substring(fromIndex: 2, count: 1), radix: 16)!)
        case 4:
            red = CGFloat(Int(hexColorString.substring(fromIndex: 0, count: 1), radix: 16)!)
            green = CGFloat(Int(hexColorString.substring(fromIndex: 1, count: 1), radix: 16)!)
            blue = CGFloat(Int(hexColorString.substring(fromIndex: 2, count: 1), radix: 16)!)
            alpha = CGFloat(Int(hexColorString.substring(fromIndex: 3, count: 1), radix: 16)!)
        case 6:
            red = CGFloat(Int(hexColorString.substring(fromIndex: 0, count: 2), radix: 16)!)
            green = CGFloat(Int(hexColorString.substring(fromIndex: 2, count: 2), radix: 16)!)
            blue = CGFloat(Int(hexColorString.substring(fromIndex: 4, count: 2), radix: 16)!)
        case 8:
            red = CGFloat(Int(hexColorString.substring(fromIndex: 0, count: 2), radix: 16)!)
            green = CGFloat(Int(hexColorString.substring(fromIndex: 2, count: 2), radix: 16)!)
            blue = CGFloat(Int(hexColorString.substring(fromIndex: 4, count: 2), radix: 16)!)
            alpha = CGFloat(Int(hexColorString.substring(fromIndex: 6, count: 2), radix: 16)!)
        default:
            fatalError("Invalid color value")
        }
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
}
