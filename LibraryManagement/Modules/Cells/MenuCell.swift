//
//  MenuCell.swift
//  LibraryManagement
//
//  Created by Anbu on 17/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    static let cellId = "MenuCell"

    private var menuImageView: UIImageView!
    private var menuTitleLabel: UILabel!
    private var badgeCountLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupData(data: SideMenu) {
        menuImageView.image = UIImage(named: data.image)
        menuTitleLabel.text = data.title
        backgroundColor = data.isSelected ? UIColor(white: 0, alpha: 0.05) : .white
        badgeCountLabel.isHidden = data.badge <= 0
        badgeCountLabel.text = "    \(data.badge)    "
    }
}

extension MenuCell {
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .white

        menuImageView = UIImageView(frame: .zero)
        menuImageView.translatesAutoresizingMaskIntoConstraints = false
        menuImageView.contentMode = .scaleToFill
        addSubview(menuImageView)

        menuImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        menuImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        menuImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        menuImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        menuTitleLabel = UILabel(frame: .zero)
        menuTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        menuTitleLabel.textColor = .black
        menuTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        addSubview(menuTitleLabel)

        menuTitleLabel.leadingAnchor.constraint(equalTo: menuImageView.trailingAnchor, constant: 16).isActive = true
        menuTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        menuTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        badgeCountLabel = UILabel(frame: .zero)
        badgeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        badgeCountLabel.textColor = .white
        badgeCountLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        badgeCountLabel.backgroundColor = .orange
        badgeCountLabel.layer.cornerRadius = 10
        badgeCountLabel.clipsToBounds = true
        addSubview(badgeCountLabel)

        badgeCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        badgeCountLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        badgeCountLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
