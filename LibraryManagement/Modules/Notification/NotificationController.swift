//
//  NotificationController.swift
//  LibraryManagement
//
//  Created by Anbu on 27/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import UIKit

class NotificationController: UIViewController {
    private var notificationTableView: UITableView!
    private var emptyView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        registerCell()
        notificationTableView.reloadData()
    }

    private func registerCell() {
        notificationTableView.register(NotificationCell.self, forCellReuseIdentifier: NotificationCell.cellId)
    }
}

extension NotificationController {
    private func setupView() {
        view.backgroundColor = UIColor(hex: "#f9feff")
        title = "Notification"

        notificationTableView = UITableView(frame: .zero)
        notificationTableView.translatesAutoresizingMaskIntoConstraints = false
        notificationTableView.backgroundColor = .clear
        notificationTableView.separatorStyle = .none
        notificationTableView.dataSource = self
        notificationTableView.rowHeight = 80
        view.addSubview(notificationTableView)

        notificationTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        notificationTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        notificationTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        notificationTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        emptyView = UIView(frame: .zero)

        let emptyImageView = UIImageView(frame: .zero)
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        emptyImageView.image = UIImage(named: "notification_empty")
        emptyView.addSubview(emptyImageView)

        let emptyInfoLabel = UILabel(frame: .zero)
        emptyInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyInfoLabel.textColor = .darkGray
        emptyInfoLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        emptyInfoLabel.text = "No notification right now"
        emptyInfoLabel.textAlignment = .center
        emptyInfoLabel.numberOfLines = 0
        emptyView.addSubview(emptyInfoLabel)

        emptyImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -20).isActive = true
        emptyImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        emptyImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        emptyImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true

        emptyInfoLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 40).isActive = true
        emptyInfoLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -40).isActive = true
        emptyInfoLabel.topAnchor.constraint(equalTo: emptyImageView.bottomAnchor, constant: 15).isActive = true
    }
}

extension NotificationController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection _: Int) -> Int {
        if NotificationManager.shared.getNotification().count == 0 {
            tableView.backgroundView = emptyView
        } else {
            tableView.backgroundView = nil
        }
        return NotificationManager.shared.getNotification().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.cellId) as! NotificationCell
        cell.setupData(data: NotificationManager.shared.getNotification()[indexPath.row])
        return cell
    }
}
