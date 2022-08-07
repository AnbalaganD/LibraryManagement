//
//  BookDetailController.swift
//  LibraryManagement
//
//  Created by Anbu on 16/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import UIKit

protocol BookDetailPreviewingDelegate: AnyObject {
    func bookDetailController(didSelect action: UIPreviewAction, item: Book)
}

class BookDetailController: UIViewController {
    private var coverImageView: UIImageView!
    private var bookNameLabel: UILabel!
    private var authorLabel: UILabel!
    private var stockLabel: UILabel!
    private var descriptionLabel: UILabel!

    private var book: Book!

    weak var delegate: BookDetailPreviewingDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        setupView()
        setupData()
    }

    func initializeData(_ book: Book?) {
        self.book = book
    }

    private func setupData() {
        bookNameLabel.text = book.name
        authorLabel.text = book.author
        stockLabel.text = book.stock > 0 ? "Stock \(book.stock)" : "Out of Stock"
        descriptionLabel.text = book.description

        guard let url = URL(string: book.coverImage) else {
            coverImageView.image = UIImage(named: book.coverImage)
            return
        }

        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self else { return }

            guard let imageData = try? Data(contentsOf: url) else {
                DispatchQueue.main.async {
                    self.coverImageView.image = UIImage(named: self.book.coverImage)
                }
                return
            }

            DispatchQueue.main.async {
                self.coverImageView.image = UIImage(data: imageData)
            }
        }
    }

    override var previewActionItems: [UIPreviewActionItem] {
        let deleteAction = UIPreviewAction(title: "Delete", style: .destructive) { [weak self] action, _ in
            if let self = self {
                self.delegate?.bookDetailController(didSelect: action, item: self.book)
            }
        }

        let editAction = UIPreviewAction(title: "Edit", style: .default) { [weak self] action, _ in
            if let self = self {
                self.delegate?.bookDetailController(didSelect: action, item: self.book)
            }
        }

        return [editAction, deleteAction]
    }
}

extension BookDetailController {
    private func setupView() {
        view.backgroundColor = .white
        title = "Book Detail"

        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        let contentView = UIView(frame: .zero)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        let contentViewHeightAnchor = contentView.heightAnchor.constraint(equalTo: view.heightAnchor)
        let contentViewWidthAnchor = contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        contentViewHeightAnchor.priority = UILayoutPriority(249)
        NSLayoutConstraint.activate([contentViewHeightAnchor, contentViewWidthAnchor])

        coverImageView = UIImageView(frame: .zero)
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.contentMode = .scaleToFill
        contentView.addSubview(coverImageView)

        coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        coverImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        coverImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        coverImageView.heightAnchor.constraint(equalTo: coverImageView.widthAnchor).isActive = true

        let bookNameTitleLabel = UILabel(frame: .zero)
        bookNameTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        bookNameTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        bookNameTitleLabel.text = "TITLE"
        bookNameTitleLabel.textColor = .lightGray
        contentView.addSubview(bookNameTitleLabel)

        bookNameTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        bookNameTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        bookNameTitleLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 40).isActive = true

        bookNameLabel = UILabel(frame: .zero)
        bookNameLabel.translatesAutoresizingMaskIntoConstraints = false
        bookNameLabel.textColor = .black
        bookNameLabel.font = UIFont.systemFont(ofSize: 16)
        bookNameLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(bookNameLabel)

        bookNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        bookNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        bookNameLabel.topAnchor.constraint(equalTo: bookNameTitleLabel.bottomAnchor, constant: 5).isActive = true

        let authorTitleLabel = UILabel(frame: .zero)
        authorTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        authorTitleLabel.text = "AUTHOR"
        authorTitleLabel.textColor = .lightGray
        contentView.addSubview(authorTitleLabel)

        authorTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        authorTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        authorTitleLabel.topAnchor.constraint(equalTo: bookNameLabel.bottomAnchor, constant: 20).isActive = true

        authorLabel = UILabel(frame: .zero)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.textColor = .black
        authorLabel.font = UIFont.systemFont(ofSize: 16)
        authorLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(authorLabel)

        authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        authorLabel.topAnchor.constraint(equalTo: authorTitleLabel.bottomAnchor, constant: 5).isActive = true

        let stockTitleLabel = UILabel(frame: .zero)
        stockTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        stockTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        stockTitleLabel.text = "STOCK"
        stockTitleLabel.textColor = .lightGray
        contentView.addSubview(stockTitleLabel)

        stockTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        stockTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        stockTitleLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 20).isActive = true

        stockLabel = UILabel(frame: .zero)
        stockLabel.translatesAutoresizingMaskIntoConstraints = false
        stockLabel.textColor = .black
        stockLabel.font = UIFont.systemFont(ofSize: 16)
        stockLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(stockLabel)

        stockLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        stockLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        stockLabel.topAnchor.constraint(equalTo: stockTitleLabel.bottomAnchor, constant: 5).isActive = true

        let descriptionTitleLabel = UILabel(frame: .zero)
        descriptionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        descriptionTitleLabel.text = "DESCRIPTION"
        descriptionTitleLabel.textColor = .lightGray
        contentView.addSubview(descriptionTitleLabel)

        descriptionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        descriptionTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        descriptionTitleLabel.topAnchor.constraint(equalTo: stockLabel.bottomAnchor, constant: 20).isActive = true

        descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = .black
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        contentView.addSubview(descriptionLabel)

        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 5).isActive = true

        contentView.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor).isActive = true
    }
}
