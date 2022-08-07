//
//  NotificationCell.swift
//  LibraryManagement
//
//  Created by Anbu on 28/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    static let cellId = "NotificationCell"

    private var notificationTitleLabel: UILabel!
    private var notificationDetailLabel: UILabel!
    private var dateLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupData(data: LibraryNotification) {
        notificationTitleLabel.text = data.title
        dateLabel.text = data.date
        notificationDetailLabel.text = data.detail
    }
}

extension NotificationCell {
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .clear

        let baseView = ShadowView(frame: .zero)
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.backgroundColor = .white
        baseView.shadowColor = UIColor(white: 0, alpha: 0.35)
        baseView.shadowRadius = 2.0
        baseView.dx = 1.0
        baseView.dy = 1.0
        baseView.shadowOpacity = 0.3
        addSubview(baseView)

        baseView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        baseView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        baseView.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        baseView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true

        let notificationImageView = UIImageView(frame: .zero)
        notificationImageView.translatesAutoresizingMaskIntoConstraints = false
        notificationImageView.contentMode = .scaleToFill
        notificationImageView.image = UIImage(named: "notification_round")
        baseView.addSubview(notificationImageView)

        notificationImageView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 8).isActive = true
        notificationImageView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 8).isActive = true
        notificationImageView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -8).isActive = true
        notificationImageView.widthAnchor.constraint(equalTo: notificationImageView.heightAnchor).isActive = true

        notificationTitleLabel = UILabel(frame: .zero)
        notificationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        notificationTitleLabel.lineBreakMode = .byTruncatingTail
        notificationTitleLabel.textColor = .black
        notificationTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        baseView.addSubview(notificationTitleLabel)

        notificationTitleLabel.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        notificationTitleLabel.setContentCompressionResistancePriority(UILayoutPriority(749), for: .horizontal)
        notificationTitleLabel.leadingAnchor.constraint(equalTo: notificationImageView.trailingAnchor, constant: 8).isActive = true
        notificationTitleLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 8).isActive = true

        dateLabel = UILabel(frame: .zero)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        dateLabel.textColor = .blue
        baseView.addSubview(dateLabel)

        dateLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -8).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: notificationTitleLabel.centerYAnchor).isActive = true
        notificationTitleLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -8).isActive = true

        notificationDetailLabel = UILabel(frame: .zero)
        notificationDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        notificationDetailLabel.numberOfLines = 0
        notificationDetailLabel.textColor = UIColor(hex: "#444444")
        notificationDetailLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        baseView.addSubview(notificationDetailLabel)

        notificationDetailLabel.setContentCompressionResistancePriority(UILayoutPriority(749), for: .vertical)
        notificationDetailLabel.leadingAnchor.constraint(equalTo: notificationImageView.trailingAnchor, constant: 8).isActive = true
        notificationDetailLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -8).isActive = true
        notificationDetailLabel.topAnchor.constraint(equalTo: notificationTitleLabel.bottomAnchor).isActive = true
        notificationDetailLabel.bottomAnchor.constraint(lessThanOrEqualTo: baseView.bottomAnchor, constant: -8).isActive = true
    }
}
