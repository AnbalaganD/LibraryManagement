//
//  SideMenuController.swift
//  LibraryManagement
//
//  Created by Anbu on 17/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import UIKit

protocol SideMenuDelegate: AnyObject {
    func didSelect(_ controller: SideMenuController, menu: SideMenu)
}

final class SideMenuController: UIViewController {
    private var sideMenuTableView: UITableView!
    private var sideMenuList = [SideMenu]()

    weak var delegate: SideMenuDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadMenuData()
        setupView()
        registerCell()
        sideMenuTableView.reloadData()
    }
}

extension SideMenuController {
    private func setupView() {
        view.backgroundColor = .systemBackground

        sideMenuTableView = UITableView(frame: .zero)
        sideMenuTableView.translatesAutoresizingMaskIntoConstraints = false
        sideMenuTableView.separatorStyle = .none
        sideMenuTableView.backgroundColor = .systemBackground
        sideMenuTableView.rowHeight = 50
        sideMenuTableView.sectionHeaderHeight = 100
        sideMenuTableView.dataSource = self
        sideMenuTableView.delegate = self
        view.addSubview(sideMenuTableView)

        sideMenuTableView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor).isActive = true
        sideMenuTableView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor).isActive = true
        sideMenuTableView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        sideMenuTableView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
    }

    private func registerCell() {
        sideMenuTableView.register(
            MenuCell.self,
            forCellReuseIdentifier: MenuCell.cellId
        )
    }

    private func loadMenuData() {
        let notificationCount = NotificationManager.shared.getNotification().count
        sideMenuList.append(
            contentsOf: [
                SideMenu(
                    title: "Home",
                    image: "home",
                    isSelected: true,
                    type: .home,
                    badge: 0
                ),
                SideMenu(
                    title: "Book Request",
                    image: "message",
                    isSelected: false,
                    type: .bookRequest,
                    badge: 0
                ),
                SideMenu(
                    title: "Notification",
                    image: "notification",
                    isSelected: false,
                    type: .notification,
                    badge: notificationCount
                ),
                SideMenu(
                    title: "Settings",
                    image: "setting",
                    isSelected: false,
                    type: .setting,
                    badge: 0
                )
            ]
        )
    }

    private func menuTapped(index: Int) {
        for index in 0 ..< sideMenuList.count where sideMenuList[index].isSelected {
            sideMenuList[index].isSelected = false
            break
        }
        sideMenuList[index].isSelected = true
        sideMenuTableView.reloadData()
        delegate?.didSelect(
            self,
            menu: sideMenuList[index]
        )
    }
}

extension SideMenuController: UITableViewDataSource, UITableViewDelegate {
    func tableView(
        _: UITableView,
        numberOfRowsInSection _: Int
    ) -> Int {
        sideMenuList.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.cellId) as! MenuCell
        cell.setupData(data: sideMenuList[indexPath.row])
        return cell
    }

    func tableView(
        _: UITableView,
        viewForHeaderInSection _: Int
    ) -> UIView? {
        MenuHeaderCell(frame: .zero)
    }

    func tableView(
        _: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        menuTapped(index: indexPath.row)
    }
}
