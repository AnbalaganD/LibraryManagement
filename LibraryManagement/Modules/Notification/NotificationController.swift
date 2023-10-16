//
//  NotificationController.swift
//  LibraryManagement
//
//  Created by Anbu on 27/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import UIKit

final class NotificationController: UIViewController {
    private var notificationTableView: UITableView!
    private var emptyView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        registerCell()
        notificationTableView.reloadData()
    }

    private func registerCell() {
        notificationTableView.register(
            NotificationCell.self,
            forCellReuseIdentifier: NotificationCell.cellId
        )
    }
}

extension NotificationController {
    private func setupView() {
        view.backgroundColor = .init(hex: 0xF9FEFF)
        title = "Notification"

        notificationTableView = UITableView(frame: .zero)
        notificationTableView.translatesAutoresizingMaskIntoConstraints = false
        notificationTableView.backgroundColor = .clear
        notificationTableView.separatorStyle = .none
        notificationTableView.dataSource = self
        notificationTableView.rowHeight = 80
        view.addSubview(notificationTableView)

        emptyView = UIView(frame: .zero)

        let emptyImageView = UIImageView(frame: .zero)
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        emptyImageView.image = .notificationEmpty
        emptyView.addSubview(emptyImageView)

        let emptyInfoLabel = UILabel(frame: .zero)
        emptyInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyInfoLabel.textColor = .darkGray
        emptyInfoLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        emptyInfoLabel.text = "No notification right now"
        emptyInfoLabel.textAlignment = .center
        emptyInfoLabel.numberOfLines = 0
        emptyView.addSubview(emptyInfoLabel)

        NSLayoutConstraint.activate([
            notificationTableView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor),
            notificationTableView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor),
            notificationTableView.topAnchor.constraint(equalTo: view.safeTopAnchor),
            notificationTableView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor),
            
            emptyImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -20),
            emptyImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            emptyImageView.heightAnchor.constraint(equalToConstant: 120),
            emptyImageView.widthAnchor.constraint(equalToConstant: 120),

            emptyInfoLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 40),
            emptyInfoLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -40),
            emptyInfoLabel.topAnchor.constraint(equalTo: emptyImageView.bottomAnchor, constant: 15)
        ])
    }
}

extension NotificationController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection _: Int
    ) -> Int {
        let notificationCount = NotificationManager.shared.getNotification().count
        tableView.backgroundView = notificationCount == 0 ? emptyView : nil
        return NotificationManager.shared.getNotification().count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: NotificationCell.cellId
        ) as! NotificationCell
        cell.setupData(data: NotificationManager.shared.getNotification()[indexPath.row])
        return cell
    }
}
