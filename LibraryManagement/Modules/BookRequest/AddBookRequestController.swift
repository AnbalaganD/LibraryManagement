//
//  AddBookRequestController.swift
//  LibraryManagement
//
//  Created by Anbu on 29/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import UIKit
import UserNotifications

protocol AddBookRequestDelegate: AnyObject {
    func onNewBookRequestAdded(request: BookRequest)
}

final class AddBookRequestController: UIViewController {
    private var bookPickerView: UIPickerView!
    private var bookNameTextView: ReadOnlyTextField!
    private var bookNotSelectedErrorLabel: UILabel!

    private var selectedBook: Book?

    weak var delegate: AddBookRequestDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @objc private func requestBookTapped() {
        if let book = selectedBook {
            bookNotSelectedErrorLabel.isHidden = true

            let bookRequest = BookRequest(
                id: UUID().uuidString.substring(fromIndex: 0, count: 8),
                userName: "Anbalagan D",
                date: .now,
                bookName: book.name,
                status: .pending,
                bookId: book.id
            )

            BookManager.shared.addBookRequest(request: bookRequest)
            delegate?.onNewBookRequestAdded(request: bookRequest)
            navigationController?.popViewController(animated: true)

            if AppSettings.isNotificationEnable {
                NotificationManager.shared.addNotification(notification: bookRequest)
            }
        } else {
            bookNotSelectedErrorLabel.isHidden = false
        }
    }
}

extension AddBookRequestController {
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Add Book Request"

        bookPickerView = UIPickerView(frame: .zero)
        bookPickerView.dataSource = self
        bookPickerView.delegate = self

        bookNameTextView = ReadOnlyTextField(frame: .zero)
        bookNameTextView.translatesAutoresizingMaskIntoConstraints = false
        bookNameTextView.borderStyle = .roundedRect
        bookNameTextView.textColor = .black
        bookNameTextView.font = UIFont.systemFont(ofSize: 16)
        bookNameTextView.placeholder = "Select book"
        view.addSubview(bookNameTextView)

        bookNameTextView.rightViewMode = .always
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        rightView.isUserInteractionEnabled = false
        let dropDownImageView = UIImageView(frame: CGRect(x: 8, y: 8, width: 24, height: 24))
        dropDownImageView.image = UIImage(systemName: "chevron.down")
        dropDownImageView.contentMode = .scaleAspectFit
        rightView.addSubview(dropDownImageView)

        bookNameTextView.rightView = rightView

        bookNameTextView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 20).isActive = true
        bookNameTextView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -20).isActive = true
        bookNameTextView.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 20).isActive = true
        bookNameTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        bookNameTextView.inputView = bookPickerView

        bookNotSelectedErrorLabel = UILabel(frame: .zero)
        bookNotSelectedErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        bookNotSelectedErrorLabel.textColor = .red
        bookNotSelectedErrorLabel.text = "Please select book"
        bookNotSelectedErrorLabel.font = UIFont.italicSystemFont(ofSize: 12)
        bookNotSelectedErrorLabel.isHidden = true
        view.addSubview(bookNotSelectedErrorLabel)

        bookNotSelectedErrorLabel.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -20).isActive = true
        bookNotSelectedErrorLabel.topAnchor.constraint(equalTo: bookNameTextView.bottomAnchor, constant: 5).isActive = true

        let toolbar = UIToolbar()
        toolbar.tintColor = .orange
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(pickerDoneTapped))
        let canceButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(pickerCancelTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolbar.items = [canceButton, spaceButton, doneButton]
        bookNameTextView.inputAccessoryView = toolbar

        let addBookRequestButton = UIButton(frame: .zero)
        addBookRequestButton.translatesAutoresizingMaskIntoConstraints = false
        addBookRequestButton.backgroundColor = .orange
        addBookRequestButton.setTitleColor(.white, for: .normal)
        addBookRequestButton.setTitle("Request Book", for: .normal)
        addBookRequestButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        addBookRequestButton.layer.cornerRadius = 3
        addBookRequestButton.addTarget(self, action: #selector(requestBookTapped), for: .touchUpInside)
        view.addSubview(addBookRequestButton)

        addBookRequestButton.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 20).isActive = true
        addBookRequestButton.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -20).isActive = true
        addBookRequestButton.topAnchor.constraint(equalTo: bookNameTextView.bottomAnchor, constant: 35).isActive = true
        addBookRequestButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

extension AddBookRequestController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in _: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        BookManager.shared.getBooks().count
    }

    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent _: Int) -> String? {
        BookManager.shared.getBooks()[row].name
    }

    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
        let books = BookManager.shared.getBooks()
        if books.isEmpty { return }
        selectedBook = books[row]
        bookNameTextView.text = selectedBook?.name
        bookNotSelectedErrorLabel.isHidden = true
    }

    @objc private func pickerDoneTapped() {
        bookNameTextView.resignFirstResponder()
        let row = bookPickerView.selectedRow(inComponent: 0)
        let books = BookManager.shared.getBooks()
        if books.isEmpty { return }
        selectedBook = books[row]
        bookNameTextView.text = selectedBook?.name
        bookNotSelectedErrorLabel.isHidden = row != -1
    }

    @objc private func pickerCancelTapped() {
        bookNameTextView.resignFirstResponder()
    }
}
