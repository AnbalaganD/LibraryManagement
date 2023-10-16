//
//  ShadowView.swift
//  LibraryManagement
//
//  Created by Anbu on 16/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import UIKit

@IBDesignable
final class ShadowView: UIView {
    @IBInspectable public var borderColor: UIColor = .clear {
        didSet {
            updateView()
        }
    }

    @IBInspectable public var borderWidth: Float = 0.0 {
        didSet {
            updateView()
        }
    }

    @IBInspectable public var cornerRadius: Float = 0.0 {
        didSet {
            updateView()
        }
    }

    @IBInspectable public var shadowColor: UIColor = .clear {
        didSet {
            updateView()
        }
    }

    @IBInspectable public var shadowOpacity: Float = 0.0 {
        didSet {
            updateView()
        }
    }

    @IBInspectable public var shadowRadius: Float = 0.0 {
        didSet {
            updateView()
        }
    }

    @IBInspectable public var dx: Float = 0.0 {
        didSet {
            updateView()
        }
    }

    @IBInspectable public var dy: Float = 0.0 {
        didSet {
            updateView()
        }
    }

    func updateView() {
        layer.cornerRadius = CGFloat(cornerRadius)
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = CGFloat(borderWidth)

        layer.shadowColor = shadowColor.cgColor
        layer.shadowRadius = CGFloat(shadowRadius)
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize(width: CGFloat(dx), height: CGFloat(dy))
    }
}
