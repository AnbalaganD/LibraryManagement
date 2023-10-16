//
//  ReadOnlyTextField.swift
//  LibraryManagement
//
//  Created by Anbu on 29/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import UIKit

final class ReadOnlyTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)

        spellCheckingType = .no
        autocorrectionType = .no
        autocapitalizationType = .none
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func caretRect(
        for _: UITextPosition
    ) -> CGRect {
        return .zero
    }

    override func canPerformAction(
        _: Selector,
        withSender _: Any?
    ) -> Bool {
        return false
    }
}
