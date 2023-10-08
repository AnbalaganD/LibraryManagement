//
//  BookListController.swift
//  LibraryManagement
//
//  Created by Anbu on 15/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import UIKit

class BookListController: UIViewController {
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

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.setNeedsLayout()
        navigationController?.view.layoutIfNeeded()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.searchBar(self.searchBar, textDidChange: self.searchBar.text ?? "")
        }
        navigationController?.navigationBar.isTranslucent = true
    }

    private func registerCells() {
        bookListTableView.register(BookCell.self, forCellReuseIdentifier: BookCell.cellId)
    }

    @objc func addBookTapped(_: Any) {
        let vc = AddBookController()
        vc.delegate = self
        let navController = UINavigationController(rootViewController: vc)
        present(navController, animated: true, completion: nil)
    }

    @objc private func menuTapped(_: UIBarButtonItem) {
        let vc = SideMenuController()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = sideTransitioningDelegate
        present(vc, animated: true)
    }

    func focusSearchBar() {
        searchBar.becomeFirstResponder()
    }
}

extension BookListController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
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
        view.backgroundColor = UIColor(hex: "#f9feff")
        title = "Books"

        bookListTableView = UITableView(frame: .zero)
        bookListTableView.translatesAutoresizingMaskIntoConstraints = false
        bookListTableView.backgroundColor = .clear
        bookListTableView.separatorStyle = .none
        bookListTableView.delegate = self
        bookListTableView.dataSource = self
        bookListTableView.rowHeight = 95
        view.addSubview(bookListTableView)

        bookListTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bookListTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bookListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        bookListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

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
        addBookButton.addTarget(self, action: #selector(addBookTapped(_:)), for: .touchUpInside)
        emptyView.addSubview(addBookButton)

        emptyTitleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        emptyTitleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true

        emptyImageView.bottomAnchor.constraint(equalTo: emptyTitleLabel.topAnchor, constant: -20).isActive = true
        emptyImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        emptyImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        emptyImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true

        emptyInfoLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 40).isActive = true
        emptyInfoLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -40).isActive = true
        emptyInfoLabel.topAnchor.constraint(equalTo: emptyTitleLabel.bottomAnchor, constant: 15).isActive = true

        addBookButton.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 40).isActive = true
        addBookButton.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -40).isActive = true
        addBookButton.bottomAnchor.constraint(equalTo: emptyView.bottomAnchor, constant: -20).isActive = true
        addBookButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func setupToolBar() {
        let addToolbarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBookTapped))
        navigationItem.rightBarButtonItem = addToolbarItem

        let menuToolbarItem = UIBarButtonItem(image: .menu, style: .plain, target: self, action: #selector(menuTapped))
        navigationItem.leftBarButtonItem = menuToolbarItem
    }

    private func configureSearchController() {
        searchBar.placeholder = "Search books..."
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }

    private func confirmDelete(indexPath: IndexPath) {
        let alert = UIAlertController(title: "CONFIRMATION", message: "Are you sure want to delete?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            let id = self?.bookList[indexPath.row].id
            self?.bookList.remove(at: indexPath.row)
            self?.bookListTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)

            if let removedId = id {
                do {
                    try BookManager.shared.deleteBook(id: removedId)
                } catch {
                    self?.showAlert(error.localizedDescription)
                }
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

    private func editBook(book: Book) {
        let vc = AddBookController()
        vc.initializeData(book)
        vc.delegate = self
        let navController = UINavigationController(rootViewController: vc)
        present(navController, animated: true, completion: nil)
    }
}

extension BookListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection _: Int) -> Int {
        tableView.backgroundView = bookList.count == 0 ? emptyView : nil
        return bookList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookCell.cellId) as! BookCell
        cell.setupData(data: bookList[indexPath.row])
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BookDetailController()
        vc.initializeData(bookList[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
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
                .init(style: .normal, title: "Edit") {[weak self] action, view, handler in
                    if let book = self?.bookList[indexPath.row] {
                        self?.editBook(book: book)
                    }
                },
                .init(style: .destructive, title: "Delete") {[weak self] action, view, handler in
                    self?.confirmDelete(indexPath: indexPath)
                }
            ]
        )
    }
}

extension BookListController: AddBookControllerDelegate {
    func onUpdate(book: Book?) {
        if let b = book {
            let index: Int? = bookList.firstIndex { $0.id == b.id }

            if let bookListIndex = index {
                bookList[bookListIndex] = b
                do {
                    try BookManager.shared.updateBook(book: b)
                } catch let error as BookMangerError {
                    showAlert(error.rawValue)
                } catch {}
            } else {
                bookList.append(b)
                BookManager.shared.addBook(book: b)
            }

            bookListTableView.reloadData()
        }
    }
}

extension BookListController: BookDetailPreviewingDelegate {
    func bookDetailController(didSelect action: UIPreviewAction, item: Book) {
        switch action.title {
        case "Edit":
            editBook(book: item)
        case "Delete":
            guard let bookListIndex: Int = bookList.firstIndex(where: { $0.id == item.id }) else { return }
            bookList.remove(at: bookListIndex)
            try? BookManager.shared.deleteBook(id: item.id)
            bookListTableView.deleteRows(at: [IndexPath(row: bookListIndex, section: 0)], with: .fade)
        default:
            break
        }
    }
}
