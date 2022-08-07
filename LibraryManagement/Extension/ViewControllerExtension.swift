//
//  ViewControllerExtension.swift
//  LibraryManagement
//
//  Created by Anbu on 15/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTapArround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissimsKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dissimsKeyboard() {
        view.endEditing(true)
    }

    func showAlert(_ mgs: String) {
        let alertController = UIAlertController(title: Constants.appName, message:
            mgs, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: Constants.Message.dismiss, style: UIAlertAction.Style.cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    func setStatusBarColor(color: UIColor) {
        (UIApplication.shared.value(forKey: "statusBar") as? UIView)?.backgroundColor = color
    }
}
