//
//  BookRequestController.swift
//  LibraryManagement
//
//  Created by Anbu on 20/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import UIKit

final class BookRequestController: UIViewController {
    private var bookRequestTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationItem()
        registerCell()
        bookRequestTableView.reloadData()
    }

    private func registerCell() {
        bookRequestTableView.register(
            BookRequsetCell.self,
            forCellReuseIdentifier: BookRequsetCell.cellId
        )
    }

    @objc private func addBookRequestTapped(_: UIBarButtonItem) {
        let addBookRequestController = AddBookRequestController()
        addBookRequestController.delegate = self
        navigationController?.pushViewController(
            addBookRequestController,
            animated: true
        )
    }
}

extension BookRequestController {
    private func setupView() {
        view.backgroundColor = UIColor(hex: 0xF9FEFF)
        title = "Book Request"

        bookRequestTableView = UITableView(frame: .zero)
        bookRequestTableView.translatesAutoresizingMaskIntoConstraints = false
        bookRequestTableView.separatorStyle = .none
        bookRequestTableView.backgroundColor = .clear
        bookRequestTableView.rowHeight = 90
        bookRequestTableView.dataSource = self
        view.addSubview(bookRequestTableView)

        bookRequestTableView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor).isActive = true
        bookRequestTableView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor).isActive = true
        bookRequestTableView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        bookRequestTableView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
    }

    private func setupNavigationItem() {
        let addBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addBookRequestTapped)
        )
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
}

extension BookRequestController: UITableViewDataSource {
    func tableView(
        _: UITableView,
        numberOfRowsInSection _: Int
    ) -> Int {
        BookManager.shared.getBookRequest().count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: BookRequsetCell.cellId
        ) as! BookRequsetCell // swiftlint:disable:this force_cast 
        cell.setupData(data: BookManager.shared.getBookRequest()[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension BookRequestController: @preconcurrency BookRequestCellDelegate {
    func rejectRequest(request: BookRequest) {
        do {
            try BookManager.shared.updateRequestyStatus(
                id: request.id,
                status: .reject
            )
            bookRequestTableView.reloadData()
        } catch let error as BookMangerError {
            showAlert(error.rawValue)
        } catch {}
    }

    func issueBook(request: BookRequest) {
        do {
            try BookManager.shared.updateRequestyStatus(
                id: request.id,
                status: .accept
            )
            bookRequestTableView.reloadData()
        } catch let error as BookMangerError {
            showAlert(error.rawValue)
        } catch {}
    }
}

extension BookRequestController: @preconcurrency AddBookRequestDelegate {
    func onNewBookRequestAdded(request _: BookRequest) {
        bookRequestTableView.reloadData()
    }
}
