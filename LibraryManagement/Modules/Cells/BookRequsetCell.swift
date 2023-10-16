//
//  BookRequsetCell.swift
//  LibraryManagement
//
//  Created by Anbu on 20/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import UIKit

protocol BookRequestCellDelegate: AnyObject {
    func rejectRequest(request: BookRequest)
    func issueBook(request: BookRequest)
}

final class BookRequsetCell: UITableViewCell {
    static let cellId = "BookRequsetCell"

    private var userNameLabel: UILabel!
    private var requestIdLabel: UILabel!
    private var dateLabel: UILabel!
    private var bookNameLabel: UILabel!
    private var statusLabel: UILabel!
    private var issueButton: UIButton!
    private var rejectButton: UIButton!

    private var data: BookRequest!
    weak var delegate: BookRequestCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupData(data: BookRequest) {
        self.data = data

        userNameLabel.text = data.userName
        requestIdLabel.text = "#\(data.id)"
        dateLabel.text = data.date
        bookNameLabel.text = data.bookName

        updateStatus(data.status)
    }

    private func updateStatus(_ status: BookRequestStatus) {
        switch status {
        case .accept:
            statusLabel.textColor = UIColor(hex: 0x006400)
            statusLabel.text = "Book Issued"
            issueButton.isHidden = true
            rejectButton.isHidden = true
            statusLabel.isHidden = false
        case .reject:
            statusLabel.textColor = .red
            statusLabel.text = "Reject"
            issueButton.isHidden = true
            rejectButton.isHidden = true
            statusLabel.isHidden = false
        case .pending:
            issueButton.isHidden = false
            rejectButton.isHidden = false
            statusLabel.isHidden = true
        }
    }

    @objc private func rejectTapped(_: UIButton) {
        delegate?.rejectRequest(request: data)
    }

    @objc private func issueTapped(_: UIButton) {
        delegate?.issueBook(request: data)
    }
}

extension BookRequsetCell {
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

        userNameLabel = UILabel(frame: .zero)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.textColor = .black
        userNameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        userNameLabel.lineBreakMode = .byTruncatingTail
        baseView.addSubview(userNameLabel)

        userNameLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        userNameLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        userNameLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 10).isActive = true
        userNameLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 10).isActive = true

        requestIdLabel = UILabel(frame: .zero)
        requestIdLabel.translatesAutoresizingMaskIntoConstraints = false
        requestIdLabel.textColor = .black
        requestIdLabel.font = .systemFont(ofSize: 14)
        baseView.addSubview(requestIdLabel)

        requestIdLabel.leadingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: 10).isActive = true
        requestIdLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -10).isActive = true
        requestIdLabel.centerYAnchor.constraint(equalTo: userNameLabel.centerYAnchor).isActive = true

        dateLabel = UILabel(frame: .zero)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textColor = .lightGray
        dateLabel.font = .systemFont(ofSize: 12, weight: .light)
        dateLabel.lineBreakMode = .byTruncatingTail
        baseView.addSubview(dateLabel)

        dateLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 10).isActive = true
        dateLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5).isActive = true

        issueButton = UIButton(frame: .zero)
        issueButton.translatesAutoresizingMaskIntoConstraints = false
        issueButton.backgroundColor = .orange
        issueButton.setTitleColor(.white, for: .normal)
        issueButton.setTitle("   Issue   ", for: .normal)
        issueButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        issueButton.layer.cornerRadius = 3
        issueButton.addTarget(self, action: #selector(issueTapped(_:)), for: .touchUpInside)
        baseView.addSubview(issueButton)

        issueButton.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -10).isActive = true
        issueButton.topAnchor.constraint(equalTo: requestIdLabel.bottomAnchor, constant: 5).isActive = true

        rejectButton = UIButton(frame: .zero)
        rejectButton.translatesAutoresizingMaskIntoConstraints = false
        rejectButton.backgroundColor = UIColor(white: 0, alpha: 0.1)
        rejectButton.setTitleColor(.gray, for: .normal)
        rejectButton.setTitle("   Reject   ", for: .normal)
        rejectButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        rejectButton.layer.cornerRadius = 3
        rejectButton.addTarget(self, action: #selector(rejectTapped(_:)), for: .touchUpInside)
        baseView.addSubview(rejectButton)

        rejectButton.trailingAnchor.constraint(equalTo: issueButton.leadingAnchor, constant: -5).isActive = true
        rejectButton.centerYAnchor.constraint(equalTo: issueButton.centerYAnchor).isActive = true

        bookNameLabel = UILabel(frame: .zero)
        bookNameLabel.translatesAutoresizingMaskIntoConstraints = false
        bookNameLabel.textColor = UIColor(hex: 0x444444)
        bookNameLabel.font = .systemFont(ofSize: 14, weight: .regular)
        bookNameLabel.lineBreakMode = .byTruncatingTail
        baseView.addSubview(bookNameLabel)

        bookNameLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 10).isActive = true
        bookNameLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5).isActive = true
        bookNameLabel.trailingAnchor.constraint(equalTo: rejectButton.leadingAnchor, constant: -5).isActive = true
        let bookNameLabelTrailingAnchor = bookNameLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -5)
        bookNameLabelTrailingAnchor.priority = UILayoutPriority(250)
        bookNameLabelTrailingAnchor.isActive = true

        statusLabel = UILabel(frame: .zero)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.font = .systemFont(ofSize: 13)
        statusLabel.text = "Aceept"
        statusLabel.textColor = .green
        baseView.addSubview(statusLabel)

        statusLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -10).isActive = true
        statusLabel.topAnchor.constraint(equalTo: requestIdLabel.bottomAnchor, constant: 5).isActive = true
    }
}
