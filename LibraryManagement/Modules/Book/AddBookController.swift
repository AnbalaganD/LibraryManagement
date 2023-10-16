//
//  AddBookController.swift
//  LibraryManagement
//
//  Created by Anbu on 16/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import UIKit

protocol AddBookControllerDelegate: AnyObject {
    func onUpdate(book: Book?)
}

final class AddBookController: UIViewController {
    private var coverImageView: UIImageView!
    private var bookNameTextField: UITextField!
    private var authorTextFeild: UITextField!
    private var stockTextFeild: UITextField!
    private var descriptionTextView: UITextView!

    private var bookTitleErrorLabel: UILabel!
    private var authorErrorLabel: UILabel!
    private var stockErrorLabel: UILabel!
    private var descriptionErrorLabel: UILabel!

    // Keyboard handling
    private var scrollViewBottomConstraint: NSLayoutConstraint!
    private var scrollView: UIScrollView!

    weak var delegate: AddBookControllerDelegate?

    private var book: Book?
    private var coverImageUrl: String?
    private let imagePickerControllert = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupToolbar()
        imagePickerControllert.delegate = self
        hideKeyboardWhenTapArround()
        setupData(book)
        setupTitle()
        enableKeyboadHandling()
    }

    func initializeData(_ book: Book?) {
        self.book = book
    }

    private func setupData(_ book: Book?) {
        if let b = book {
            bookNameTextField.text = b.name
            authorTextFeild.text = b.author
            stockTextFeild.text = "\(b.stock)"
            descriptionTextView.text = b.description

            guard let url = URL(string: b.coverImage), let imageData = try? Data(contentsOf: url) else {
                coverImageView.image = UIImage(named: b.coverImage)
                return
            }
            coverImageView.image = UIImage(data: imageData)
        }
    }

    private func setupTitle() {
        title = book == nil ? "Add Book" : "Edit Book"
    }

    @objc private func onEditCoverImageTapped() {
        let alertController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        alertController.addAction(
            UIAlertAction(
                title: "Gallery",
                style: .default,
                handler: {[weak self] _ in
                    guard let self = self else { return }
                    self.imagePickerControllert.sourceType = .photoLibrary
                    self.present(self.imagePickerControllert, animated: true)
                })
        )
        alertController.addAction(
            UIAlertAction(
                title: "Camera",
                style: .default,
                handler: { [weak self] _ in
                    guard let self else { return }

                    if !UIImagePickerController.isSourceTypeAvailable(.camera) {
                        return self.showAlert("Camera Not Available")
                    }

                    self.imagePickerControllert.sourceType = .camera
                    self.present(self.imagePickerControllert, animated: true)
                }
            )
        )
        alertController.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .cancel
            )
        )
        present(alertController, animated: true)
    }

    @objc private func cancelTapped(_: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @objc private func doneTapped(_: UIBarButtonItem) {
        if !isValidData() { return }

        let id = book == nil ? UUID().uuidString : book!.id
        let coverImage = coverImageUrl == nil ? book?.coverImage : coverImageUrl

        let book = Book(
            id: id,
            name: bookNameTextField.text!,
            author: authorTextFeild.text!,
            description: descriptionTextView.text!,
            coverImage: coverImage!,
            stock: Int(stockTextFeild.text ?? "0") ?? 0
        )

        delegate?.onUpdate(book: book)
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }

    private func isValidData() -> Bool {
        var isValid = true
        if bookNameTextField.text == nil || bookNameTextField.text!.isEmpty {
            bookTitleErrorLabel.isHidden = false
            isValid = false
        }
        if authorTextFeild.text == nil || authorTextFeild.text!.isEmpty {
            authorErrorLabel.isHidden = false
            isValid = false
        }
        if stockTextFeild.text == nil || stockTextFeild.text!.isEmpty || Int(stockTextFeild.text!) == nil {
            stockErrorLabel.isHidden = false
            isValid = false
        }
        if descriptionTextView.text == nil || descriptionTextView.text!.isEmpty {
            descriptionErrorLabel.isHidden = false
            isValid = false
        }
        guard coverImageUrl != nil || book?.coverImage != nil else {
            showAlert(Constants.Message.emptyCoverImage)
            return false
        }
        return isValid
    }
}

extension AddBookController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == bookNameTextField {
            authorTextFeild.becomeFirstResponder()
        } else if textField == authorTextFeild {
            stockTextFeild.becomeFirstResponder()
        } else if textField == stockTextFeild {
            descriptionTextView.becomeFirstResponder()
        }
        return true
    }

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let currentText = textField.text ?? String.empty
        guard let currentRange = Range(range, in: currentText) else { return true }
        let updatedString = currentText.replacingCharacters(in: currentRange, with: string)

        if textField == bookNameTextField {
            bookTitleErrorLabel.isHidden = !updatedString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        } else if textField == authorTextFeild {
            authorErrorLabel.isHidden = !updatedString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        } else if textField == stockTextFeild {
            stockErrorLabel.isHidden = !updatedString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && (Int(updatedString) != nil)
        }
        return true
    }

    func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String
    ) -> Bool {
        let currentText = textView.text ?? String.empty
        guard let currentRange = Range(range, in: currentText) else { return true }
        let updatedString = currentText.replacingCharacters(in: currentRange, with: text)
        if textView == descriptionTextView {
            descriptionErrorLabel.isHidden = !updatedString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
        return true
    }
}

extension AddBookController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        picker.dismiss(animated: true, completion: nil)
        coverImageView.image = info[.originalImage] as? UIImage
        coverImageUrl = (info[.imageURL] as? URL)?.absoluteString
    }
}

extension AddBookController {
    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false

        scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        scrollView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        scrollViewBottomConstraint = scrollView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor)
        scrollViewBottomConstraint.isActive = true

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
        coverImageView.image = .imagesPlaceholder
        contentView.addSubview(coverImageView)

        coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        coverImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        coverImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        coverImageView.heightAnchor.constraint(equalTo: coverImageView.widthAnchor).isActive = true

        let editCoverImageView = UIImageView(frame: .zero)
        editCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        editCoverImageView.contentMode = .scaleToFill
        editCoverImageView.image = .edit
        editCoverImageView.isUserInteractionEnabled = true
        editCoverImageView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        editCoverImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onEditCoverImageTapped)))
        contentView.addSubview(editCoverImageView)

        editCoverImageView.topAnchor.constraint(equalTo: coverImageView.topAnchor).isActive = true
        editCoverImageView.trailingAnchor.constraint(equalTo: coverImageView.trailingAnchor).isActive = true
        editCoverImageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        editCoverImageView.widthAnchor.constraint(equalToConstant: 35).isActive = true

        let bookNameTitleLabel = UILabel(frame: .zero)
        bookNameTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        bookNameTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        bookNameTitleLabel.text = "TITLE"
        bookNameTitleLabel.textColor = .lightGray
        contentView.addSubview(bookNameTitleLabel)

        bookNameTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        bookNameTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        bookNameTitleLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 40).isActive = true

        bookNameTextField = UITextField(frame: .zero)
        bookNameTextField.translatesAutoresizingMaskIntoConstraints = false
        bookNameTextField.font = UIFont.systemFont(ofSize: 16)
        bookNameTextField.textColor = .black
        bookNameTextField.borderStyle = .roundedRect
        bookNameTextField.returnKeyType = .next
        bookNameTextField.delegate = self
        contentView.addSubview(bookNameTextField)

        bookNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        bookNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        bookNameTextField.topAnchor.constraint(equalTo: bookNameTitleLabel.bottomAnchor, constant: 5).isActive = true
        bookNameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true

        bookTitleErrorLabel = UILabel(frame: .zero)
        bookTitleErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        bookTitleErrorLabel.font = UIFont.italicSystemFont(ofSize: 12)
        bookTitleErrorLabel.textColor = .red
        bookTitleErrorLabel.textAlignment = .right
        bookTitleErrorLabel.text = "Title should not be empty"
        bookTitleErrorLabel.isHidden = true
        contentView.addSubview(bookTitleErrorLabel)

        bookTitleErrorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        bookTitleErrorLabel.topAnchor.constraint(equalTo: bookNameTextField.bottomAnchor, constant: 5).isActive = true

        let authorTitleLabel = UILabel(frame: .zero)
        authorTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        authorTitleLabel.text = "AUTHOR"
        authorTitleLabel.textColor = .lightGray
        contentView.addSubview(authorTitleLabel)

        authorTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        authorTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        authorTitleLabel.topAnchor.constraint(equalTo: bookNameTextField.bottomAnchor, constant: 20).isActive = true

        authorTextFeild = UITextField(frame: .zero)
        authorTextFeild.translatesAutoresizingMaskIntoConstraints = false
        authorTextFeild.font = UIFont.systemFont(ofSize: 16)
        authorTextFeild.textColor = .black
        authorTextFeild.borderStyle = .roundedRect
        authorTextFeild.returnKeyType = .next
        authorTextFeild.delegate = self
        contentView.addSubview(authorTextFeild)

        authorTextFeild.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        authorTextFeild.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        authorTextFeild.topAnchor.constraint(equalTo: authorTitleLabel.bottomAnchor, constant: 5).isActive = true
        authorTextFeild.heightAnchor.constraint(equalToConstant: 40).isActive = true

        authorErrorLabel = UILabel(frame: .zero)
        authorErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorErrorLabel.font = UIFont.italicSystemFont(ofSize: 12)
        authorErrorLabel.textColor = .red
        authorErrorLabel.textAlignment = .right
        authorErrorLabel.text = "Author should not be empty"
        authorErrorLabel.isHidden = true
        contentView.addSubview(authorErrorLabel)

        authorErrorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        authorErrorLabel.topAnchor.constraint(equalTo: authorTextFeild.bottomAnchor, constant: 5).isActive = true

        let stockTitleLabel = UILabel(frame: .zero)
        stockTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        stockTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        stockTitleLabel.text = "STOCK"
        stockTitleLabel.textColor = .lightGray
        contentView.addSubview(stockTitleLabel)

        stockTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        stockTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        stockTitleLabel.topAnchor.constraint(equalTo: authorTextFeild.bottomAnchor, constant: 20).isActive = true

        stockTextFeild = UITextField(frame: .zero)
        stockTextFeild.translatesAutoresizingMaskIntoConstraints = false
        stockTextFeild.font = UIFont.systemFont(ofSize: 16)
        stockTextFeild.textColor = .black
        stockTextFeild.borderStyle = .roundedRect
        stockTextFeild.returnKeyType = .next
        stockTextFeild.keyboardType = .numberPad
        stockTextFeild.delegate = self
        contentView.addSubview(stockTextFeild)

        stockTextFeild.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        stockTextFeild.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        stockTextFeild.topAnchor.constraint(equalTo: stockTitleLabel.bottomAnchor, constant: 5).isActive = true
        stockTextFeild.heightAnchor.constraint(equalToConstant: 40).isActive = true

        stockErrorLabel = UILabel(frame: .zero)
        stockErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        stockErrorLabel.font = UIFont.italicSystemFont(ofSize: 12)
        stockErrorLabel.textColor = .red
        stockErrorLabel.textAlignment = .right
        stockErrorLabel.text = "Stock should be positive numeric values"
        stockErrorLabel.isHidden = true
        contentView.addSubview(stockErrorLabel)

        stockErrorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        stockErrorLabel.topAnchor.constraint(equalTo: stockTextFeild.bottomAnchor, constant: 5).isActive = true

        let descriptionTitleLabel = UILabel(frame: .zero)
        descriptionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        descriptionTitleLabel.text = "DESCRIPTION"
        descriptionTitleLabel.textColor = .lightGray
        contentView.addSubview(descriptionTitleLabel)

        descriptionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        descriptionTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        descriptionTitleLabel.topAnchor.constraint(equalTo: stockTextFeild.bottomAnchor, constant: 20).isActive = true

        descriptionTextView = UITextView(frame: .zero)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.font = UIFont.systemFont(ofSize: 16)
        descriptionTextView.textColor = .black
        descriptionTextView.delegate = self
        contentView.addSubview(descriptionTextView)

        descriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        descriptionTextView.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 5).isActive = true
        descriptionTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        descriptionErrorLabel = UILabel(frame: .zero)
        descriptionErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionErrorLabel.font = UIFont.italicSystemFont(ofSize: 12)
        descriptionErrorLabel.textColor = .red
        descriptionErrorLabel.textAlignment = .right
        descriptionErrorLabel.text = "Description should not be empty"
        descriptionErrorLabel.isHidden = true
        contentView.addSubview(descriptionErrorLabel)

        descriptionErrorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        descriptionErrorLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 5).isActive = true

        contentView.bottomAnchor.constraint(equalTo: descriptionErrorLabel.bottomAnchor).isActive = true
    }

    private func setupToolbar() {
        let doneToolbarItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneTapped)
        )
        navigationItem.rightBarButtonItem = doneToolbarItem

        let cancelToolbarItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelTapped)
        )
        navigationItem.leftBarButtonItem = cancelToolbarItem
    }
}

// Keyboard Handling
extension AddBookController {
    private func enableKeyboadHandling() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onKeyboardShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onKeyboardHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onInputViewBeginEdit(notification:)),
            name: UITextField.textDidBeginEditingNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onInputViewBeginEdit(notification:)),
            name: UITextView.textDidBeginEditingNotification,
            object: nil
        )
    }

    @objc private func onKeyboardShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo!["UIKeyboardFrameEndUserInfoKey"] as? CGRect else {
            return
        }

        scrollViewBottomConstraint.constant = -keyboardFrame.height
        view.layoutIfNeeded()
    }

    @objc private func onKeyboardHide(notification _: Notification) {
        scrollViewBottomConstraint.constant = 0
        view.layoutIfNeeded()
    }

    @objc private func onInputViewBeginEdit(notification: Notification) {
        if let inputView = notification.object as? UIView {
            scrollView.scrollRectToVisible(
                inputView.frame,
                animated: true
            )
        }
    }
}
