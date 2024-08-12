//
//  BookListController.swift
//  LibraryManagement
//
//  Created by Anbu on 15/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import UIKit

final class BookListController: UIViewController {
    private var bookListTableView: UITableView!
    private var emptyView: UIView!
    private let searchBar = UISearchBar()

    private var bookList = [Book]()
    private let sideTransitioningDelegate = SlideTransitionDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupToolBar()
        configureSearchController()
        registerCells()
        bookListTableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.searchBar(self.searchBar, textDidChange: self.searchBar.text ?? .empty)
        }
    }

    private func registerCells() {
        bookListTableView.register(
            BookCell.self,
            forCellReuseIdentifier: BookCell.cellId
        )
    }

    @objc func addBookTapped() {
        let addBookController = AddBookController()
        addBookController.delegate = self
        let navController = UINavigationController(rootViewController: addBookController)
        present(navController, animated: true)
    }

    @objc private func menuTapped() {
        let sideMenuController = SideMenuController()
        sideMenuController.delegate = self
        sideMenuController.modalPresentationStyle = .custom
        sideMenuController.transitioningDelegate = sideTransitioningDelegate
        present(sideMenuController, animated: true)
    }

    func focusSearchBar() {
        searchBar.becomeFirstResponder()
    }
}

extension BookListController: UISearchBarDelegate {
    func searchBar(
        _ searchbar: UISearchBar,
        textDidChange searchText: String
    ) {
        if searchText.isEmpty {
            bookList = BookManager.shared.getBooks()
        } else {
            bookList = BookManager.shared.getBooks().filter { $0.author.lowercased().contains(searchText.lowercased())
                || $0.name.lowercased().contains(searchText.lowercased())
                || $0.description.lowercased().contains(searchText.lowercased())
            }
        }
        bookListTableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension BookListController {
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Books"

        bookListTableView = UITableView(frame: .zero)
        bookListTableView.translatesAutoresizingMaskIntoConstraints = false
        bookListTableView.backgroundColor = .clear
        bookListTableView.separatorStyle = .none
        bookListTableView.delegate = self
        bookListTableView.dataSource = self
        bookListTableView.rowHeight = 95
        bookListTableView.keyboardDismissMode = .onDrag
        view.addSubview(bookListTableView)

        // Empty View
        emptyView = UIView(frame: .zero)

        let emptyImageView = UIImageView(frame: .zero)
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        emptyImageView.image = .emptyBook
        emptyView.addSubview(emptyImageView)

        let emptyTitleLabel = UILabel(frame: .zero)
        emptyTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyTitleLabel.textColor = .black
        emptyTitleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        emptyTitleLabel.text = "Don't have any book"
        emptyView.addSubview(emptyTitleLabel)

        let emptyInfoLabel = UILabel(frame: .zero)
        emptyInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyInfoLabel.textColor = .darkGray
        emptyInfoLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        emptyInfoLabel.text = "Add new book and fill this space with books"
        emptyInfoLabel.textAlignment = .center
        emptyInfoLabel.numberOfLines = 0
        emptyView.addSubview(emptyInfoLabel)

        let addBookButton = UIButton(frame: .zero)
        addBookButton.translatesAutoresizingMaskIntoConstraints = false
        addBookButton.backgroundColor = .orange
        addBookButton.setTitleColor(.white, for: .normal)
        addBookButton.setTitle("ADD BOOK", for: .normal)
        addBookButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        addBookButton.layer.cornerRadius = 2
        addBookButton.addTarget(self, action: #selector(addBookTapped), for: .touchUpInside)
        emptyView.addSubview(addBookButton)

        NSLayoutConstraint.activate([
            bookListTableView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor),
            bookListTableView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor),
            bookListTableView.topAnchor.constraint(equalTo: view.safeTopAnchor),
            bookListTableView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor),

            emptyTitleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            emptyTitleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),

            emptyImageView.bottomAnchor.constraint(equalTo: emptyTitleLabel.topAnchor, constant: -20),
            emptyImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            emptyImageView.heightAnchor.constraint(equalToConstant: 150),
            emptyImageView.widthAnchor.constraint(equalToConstant: 150),

            emptyInfoLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 40),
            emptyInfoLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -40),
            emptyInfoLabel.topAnchor.constraint(equalTo: emptyTitleLabel.bottomAnchor, constant: 15),

            addBookButton.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 40),
            addBookButton.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -40),
            addBookButton.bottomAnchor.constraint(equalTo: emptyView.bottomAnchor, constant: -20),
            addBookButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupToolBar() {
        let addToolbarItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addBookTapped)
        )
        navigationItem.rightBarButtonItem = addToolbarItem

        let menuToolbarItem = UIBarButtonItem(
            image: .menu,
            style: .plain,
            target: self,
            action: #selector(menuTapped)
        )
        navigationItem.leftBarButtonItem = menuToolbarItem
    }

    private func configureSearchController() {
        searchBar.placeholder = "Search books..."
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }

    private func confirmDelete(indexPath: IndexPath) {
        let alert = UIAlertController(
            title: "CONFIRMATION",
            message: "Are you sure want to delete?",
            preferredStyle: .alert
        )
        let deleteAction = UIAlertAction(
            title: "Delete",
            style: .destructive
        ) { [weak self] _ in
            guard let self else { return }
            do {
                try BookManager.shared.deleteBook(id: self.bookList[indexPath.row].id)
                self.bookList.remove(at: indexPath.row)
                self.bookListTableView.deleteRows(
                    at: [indexPath],
                    with: UITableView.RowAnimation.fade
                )
            } catch {
                self.showAlert(error.localizedDescription)
            }
        }
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel
        )

        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

    private func editBook(book: Book) {
        let viewController = AddBookController()
        viewController.initializeData(book)
        viewController.delegate = self
        let navController = UINavigationController(rootViewController: viewController)
        present(navController, animated: true)
    }
}

extension BookListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection _: Int
    ) -> Int {
        tableView.backgroundView = bookList.count == 0 ? emptyView : nil
        return bookList.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookCell.cellId) as! BookCell // swiftlint:disable:this force_cast
        cell.setupData(data: bookList[indexPath.row])
        return cell
    }

    func tableView(
        _: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let viewController = BookDetailController()
        viewController.initializeData(bookList[indexPath.row])
        navigationController?.pushViewController(viewController, animated: true)
    }

    func tableView(_: UITableView, canEditRowAt _: IndexPath) -> Bool {
        return true
    }

    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        UISwipeActionsConfiguration(
            actions: [
                .init(
                    style: .normal,
                    title: "Edit"
                ) {[weak self] _, _, handler in
                    if let book = self?.bookList[indexPath.row] {
                        self?.editBook(book: book)
                        handler(true)
                    }
                },
                .init(
                    style: .destructive,
                    title: "Delete"
                ) {[weak self] _, _, handler in
                    self?.confirmDelete(indexPath: indexPath)
                    handler(true)
                }
            ]
        )
    }

    func tableView(
        _ tableView: UITableView,
        contextMenuConfigurationForRowAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil
        ) { _ in
            UIMenu(
                title: "Action",
                children: [
                    UIAction(title: "Edit") {[weak self] _ in
                        if let book = self?.bookList[indexPath.row] {
                            self?.editBook(book: book)
                        }
                    },
                    UIAction(title: "Delete", attributes: .destructive) {[weak self] _ in
                        if self?.bookList[indexPath.row] != nil {
                            self?.confirmDelete(indexPath: indexPath)
                        }
                    }
                ]
            )
        }
    }
}

extension BookListController: @preconcurrency AddBookControllerDelegate {
    func onUpdate(book: Book?) {
        if let book {
            let index: Int? = bookList.firstIndex { $0.id == book.id }

            if let bookListIndex = index {
                bookList[bookListIndex] = book
                do {
                    try BookManager.shared.updateBook(book: book)
                    bookListTableView.reloadRows(
                        at: [.init(row: bookListIndex, section: 0)],
                        with: .automatic
                    )
                } catch let error as BookMangerError {
                    showAlert(error.rawValue)
                } catch {}
            } else {
                bookList.append(book)
                BookManager.shared.addBook(book: book)
                bookListTableView.insertRows(
                    at: [.init(row: bookList.count - 1, section: 0)],
                    with: .automatic
                )
            }
        }
    }
}

extension BookListController: @preconcurrency SideMenuDelegate {
    func didSelect(_ controller: SideMenuController, menu: SideMenu) {
        if menu.type == .home { return }
        let viewController = switch menu.type {
        case .bookRequest: BookRequestController()
        case .notification: NotificationController()
        case .setting: SettingController()
        default: fatalError("This menu selection is not handled")
        }

        navigationController?.pushViewController(
            viewController,
            animated: true
        )
        dismiss(animated: false)
    }
}
