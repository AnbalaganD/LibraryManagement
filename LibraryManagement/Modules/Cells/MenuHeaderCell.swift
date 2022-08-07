//
//  MenuHeaderCell.swift
//  LibraryManagement
//
//  Created by Anbu on 17/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import UIKit

class MenuHeaderCell: UITableViewHeaderFooterView {
    static let cellId = "MenuHeaderCell"

    private var userImageView: UIImageView!
    private var userNameLabel: UILabel!
    private var emailLabel: UILabel!

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
        setupData(data: "")
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupData(data _: Any) {
        userImageView.image = UIImage(named: "user_place_holder")
        userNameLabel.text = "Anbalagan D"
    }
}

extension MenuHeaderCell {
    private func setupView() {
        let contentView = UIView(frame: .zero)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        addSubview(contentView)

        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[contentView]|", options: [], metrics: nil, views: ["contentView": contentView]))
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[contentView]|", options: [], metrics: nil, views: ["contentView": contentView]))

        userImageView = UIImageView(frame: .zero)
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.contentMode = .scaleToFill
        contentView.addSubview(userImageView)

        userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        userImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        userImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        userImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true

        userNameLabel = UILabel(frame: .zero)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.textColor = .black
        userNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        userNameLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(userNameLabel)

        userNameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 20).isActive = true
        userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        userNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}
