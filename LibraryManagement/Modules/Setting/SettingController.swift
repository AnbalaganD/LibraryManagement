//
//  SettingController.swift
//  LibraryManagement
//
//  Created by Anbu on 28/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import UIKit
import UserNotifications

final class SettingController: UIViewController {
    private var notificationSwitch: UISwitch!
    private let notificationManager = NotificationManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        notificationSwitch.setOn(
            AppSettings.isNotificationEnable,
            animated: false
        )
    }

    @objc private func notificationChanged(_ sender: UISwitch) {
        notificationManager.requestNotificationAuthorization { granded in
            DispatchQueue.main.async {
                if granded {
                    AppSettings.isNotificationEnable = sender.isOn
                } else {
                    if !sender.isOn { return }

                    sender.isOn = false
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                }
            }
        }
    }

    @objc private func onLogout() {
        let alertController = UIAlertController(
            title: "CONFIRMATION",
            message: "Are you sure you want to logout?",
            preferredStyle: .alert
        )
        alertController.addAction(
            UIAlertAction(
                title: "Logout",
                style: .default
            ) { _ in
                print("Logout")
            }
        )

        alertController.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .cancel
            )
        )
        present(alertController, animated: true)
    }
}

extension SettingController {
    // swiftlint:disable:next function_body_length
    private func setupView() {
        view.backgroundColor = UIColor(dynamicProvider: { traits in
            traits.userInterfaceStyle == .dark ? .systemBackground: .init(hex: 0xFAFDFD)
        })
        title = "Settings"

        let userImageView = UIImageView(frame: .zero)
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.contentMode = .scaleToFill
        userImageView.layer.cornerRadius = 40
        userImageView.image = .userPlaceHolder
        view.addSubview(userImageView)

        userImageView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 20).isActive = true
        userImageView.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 20).isActive = true
        userImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        userImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true

        let userNameLabel = UILabel(frame: .zero)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.textColor = .black
        userNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        userNameLabel.lineBreakMode = .byTruncatingTail
        userNameLabel.text = "Anbalagan D"
        view.addSubview(userNameLabel)

        userNameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 20).isActive = true
        userNameLabel.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -20).isActive = true
        userNameLabel.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor).isActive = true

        let horizontalDividerView = UIView(frame: .zero)
        horizontalDividerView.translatesAutoresizingMaskIntoConstraints = false
        horizontalDividerView.backgroundColor = .init(hex: 0x555555, alpha: 0.15)
        view.addSubview(horizontalDividerView)

        horizontalDividerView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor).isActive = true
        horizontalDividerView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor).isActive = true
        horizontalDividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        horizontalDividerView.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 10).isActive = true

        let notificationContainerView = ShadowView(frame: .zero)
        notificationContainerView.translatesAutoresizingMaskIntoConstraints = false
        notificationContainerView.backgroundColor = .systemBackground
        notificationContainerView.shadowColor = UIColor(white: 0, alpha: 0.35)
        notificationContainerView.shadowRadius = 3.0
        notificationContainerView.dx = 1.0
        notificationContainerView.dy = 1.0
        notificationContainerView.shadowOpacity = 0.3
        view.addSubview(notificationContainerView)

        notificationContainerView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 20).isActive = true
        notificationContainerView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -20).isActive = true
        notificationContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        notificationContainerView.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 20).isActive = true

        let notificationImageView = UIImageView(frame: .zero)
        notificationImageView.translatesAutoresizingMaskIntoConstraints = false
        notificationImageView.contentMode = .scaleToFill
        notificationImageView.image = .notification
        notificationContainerView.addSubview(notificationImageView)

        notificationImageView.leadingAnchor.constraint(equalTo: notificationContainerView.leadingAnchor, constant: 15).isActive = true
        notificationImageView.centerYAnchor.constraint(equalTo: notificationContainerView.centerYAnchor).isActive = true
        notificationImageView.heightAnchor.constraint(equalToConstant: 18).isActive = true
        notificationImageView.widthAnchor.constraint(equalToConstant: 18).isActive = true

        let notificationLabel = UILabel(frame: .zero)
        notificationLabel.translatesAutoresizingMaskIntoConstraints = false
        notificationLabel.textColor = .black
        notificationLabel.font = UIFont.systemFont(ofSize: 15)
        notificationLabel.text = "Notification"
        notificationContainerView.addSubview(notificationLabel)

        notificationLabel.leadingAnchor.constraint(equalTo: notificationImageView.trailingAnchor, constant: 10).isActive = true
        notificationLabel.centerYAnchor.constraint(equalTo: notificationContainerView.centerYAnchor).isActive = true

        notificationSwitch = UISwitch(frame: .zero)
        notificationSwitch.translatesAutoresizingMaskIntoConstraints = false
        notificationSwitch.onTintColor = .orange
        notificationSwitch.addTarget(self, action: #selector(notificationChanged), for: .valueChanged)
        notificationContainerView.addSubview(notificationSwitch)

        notificationSwitch.trailingAnchor.constraint(equalTo: notificationContainerView.trailingAnchor, constant: -20).isActive = true
        notificationSwitch.centerYAnchor.constraint(equalTo: notificationContainerView.centerYAnchor).isActive = true

        let logoutContainerView = ShadowView(frame: .zero)
        logoutContainerView.translatesAutoresizingMaskIntoConstraints = false
        logoutContainerView.backgroundColor = .systemBackground
        logoutContainerView.shadowColor = UIColor(white: 0, alpha: 0.35)
        logoutContainerView.shadowRadius = 3.0
        logoutContainerView.dx = 1.0
        logoutContainerView.dy = 1.0
        logoutContainerView.shadowOpacity = 0.3
        view.addSubview(logoutContainerView)

        logoutContainerView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 20).isActive = true
        logoutContainerView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -20).isActive = true
        logoutContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        logoutContainerView.topAnchor.constraint(equalTo: notificationContainerView.bottomAnchor, constant: 5).isActive = true

        let logoutImageView = UIImageView(frame: .zero)
        logoutImageView.translatesAutoresizingMaskIntoConstraints = false
        logoutImageView.contentMode = .scaleToFill
        logoutImageView.image = .power
        logoutContainerView.addSubview(logoutImageView)

        logoutImageView.leadingAnchor.constraint(equalTo: logoutContainerView.leadingAnchor, constant: 15).isActive = true
        logoutImageView.centerYAnchor.constraint(equalTo: logoutContainerView.centerYAnchor).isActive = true
        logoutImageView.heightAnchor.constraint(equalToConstant: 18).isActive = true
        logoutImageView.widthAnchor.constraint(equalToConstant: 18).isActive = true

        let logoutLabel = UILabel(frame: .zero)
        logoutLabel.translatesAutoresizingMaskIntoConstraints = false
        logoutLabel.textColor = .black
        logoutLabel.font = UIFont.systemFont(ofSize: 15)
        logoutLabel.text = "Logout"
        logoutContainerView.addSubview(logoutLabel)

        logoutLabel.leadingAnchor.constraint(equalTo: logoutImageView.trailingAnchor, constant: 10).isActive = true
        logoutLabel.centerYAnchor.constraint(equalTo: logoutContainerView.centerYAnchor).isActive = true

        logoutContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onLogout)))

        let copyRightLabel = UILabel(frame: .zero)
        copyRightLabel.translatesAutoresizingMaskIntoConstraints = false
        copyRightLabel.textColor = UIColor(hex: 0xCCCCCC)
        copyRightLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        copyRightLabel.text = "Library Management © 2019"
        view.addSubview(copyRightLabel)

        copyRightLabel.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -15).isActive = true
        copyRightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
