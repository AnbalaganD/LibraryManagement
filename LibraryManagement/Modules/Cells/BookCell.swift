//
//  BookCell.swift
//  LibraryManagement
//
//  Created by Anbu on 15/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {
    static let cellId = "BookCell"

    private var coverImageView: UIImageView!
    private var titleLabel: UILabel!
    private var authorLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var stockLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupData(data: Book) {
        titleLabel.text = data.name
        authorLabel.text = "Written by \(data.author)"
        descriptionLabel.text = data.description
        stockLabel.text = data.stock > 0 ? "Stock \(data.stock)" : "Out of Stock"
        stockLabel.textColor = data.stock > 0 ? .orange : .red

        guard let url = URL(string: data.coverImage) else {
            coverImageView.image = UIImage(named: data.coverImage)
            return
        }

        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self else { return }

            guard let imageData = try? Data(contentsOf: url) else {
                DispatchQueue.main.async {
                    self.coverImageView.image = UIImage(named: data.coverImage)
                }
                return
            }

            DispatchQueue.main.async {
                self.coverImageView.image = UIImage(data: imageData)
            }
        }
    }
}

extension BookCell {
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

        coverImageView = UIImageView(frame: .zero)
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.contentMode = .scaleToFill
        coverImageView.image = .imagesPlaceholder
        baseView.addSubview(coverImageView)

        coverImageView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 8).isActive = true
        coverImageView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 8).isActive = true
        coverImageView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -8).isActive = true
        coverImageView.widthAnchor.constraint(equalTo: coverImageView.heightAnchor).isActive = true

        titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        baseView.addSubview(titleLabel)

        titleLabel.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority(749), for: .horizontal)
        titleLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 8).isActive = true

        stockLabel = UILabel(frame: .zero)
        stockLabel.translatesAutoresizingMaskIntoConstraints = false
        stockLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        baseView.addSubview(stockLabel)

        stockLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -8).isActive = true
        stockLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: stockLabel.leadingAnchor, constant: -8).isActive = true

        authorLabel = UILabel(frame: .zero)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.lineBreakMode = .byTruncatingTail
        authorLabel.textColor = .lightGray
        authorLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        baseView.addSubview(authorLabel)

        authorLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 8).isActive = true
        authorLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -8).isActive = true
        authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1).isActive = true

        descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = UIColor(hex: "#444444")
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        baseView.addSubview(descriptionLabel)

        descriptionLabel.setContentCompressionResistancePriority(UILayoutPriority(749), for: .vertical)
        descriptionLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 8).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -8).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: baseView.bottomAnchor, constant: -8).isActive = true
    }
}
