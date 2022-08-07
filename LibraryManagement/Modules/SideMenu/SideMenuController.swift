//
//  SideMenuController.swift
//  LibraryManagement
//
//  Created by Anbu on 17/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import UIKit

class SideMenuController: UIViewController {
    private var sideMenuTableView: UITableView!
    private var sideMenuList = [SideMenu]()

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
        view.backgroundColor = .white

        sideMenuTableView = UITableView(frame: .zero)
        sideMenuTableView.translatesAutoresizingMaskIntoConstraints = false
        sideMenuTableView.separatorStyle = .none
        sideMenuTableView.backgroundColor = .white
        sideMenuTableView.rowHeight = 50
        sideMenuTableView.sectionHeaderHeight = 100
        sideMenuTableView.dataSource = self
        sideMenuTableView.delegate = self
        view.addSubview(sideMenuTableView)

        sideMenuTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        sideMenuTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        sideMenuTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        sideMenuTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    private func registerCell() {
        sideMenuTableView.register(MenuCell.self, forCellReuseIdentifier: MenuCell.cellId)
    }

    private func loadMenuData() {
        let notificationCount = NotificationManager.shared.getNotification().count
        sideMenuList.append(SideMenu(title: "Home", image: "home", isSelected: true, type: .home, badge: 0))
        sideMenuList.append(SideMenu(title: "Book Request", image: "message", isSelected: false, type: .bookRequest, badge: 0))
        sideMenuList.append(SideMenu(title: "Notification", image: "notification", isSelected: false, type: .notification, badge: notificationCount))
        sideMenuList.append(SideMenu(title: "Settings", image: "setting", isSelected: false, type: .setting, badge: 0))
    }

    private func menuTapped(index: Int) {
        for i in 0 ..< sideMenuList.count {
            if sideMenuList[i].isSelected {
                sideMenuList[i].isSelected = false
                break
            }
        }
        sideMenuList[index].isSelected = true
        sideMenuTableView.reloadData()
        switch sideMenuList[index].type {
        case .home:
            break
        case .bookRequest:
            let vc = BookRequestController()
            (UIApplication.shared.keyWindow?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
        case .notification:
            let vc = NotificationController()
            (UIApplication.shared.keyWindow?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
        case .setting:
            let vc = SettingController()
            (UIApplication.shared.keyWindow?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
        }
        dismiss(animated: false, completion: nil)
    }
}

extension SideMenuController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return sideMenuList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.cellId) as! MenuCell
        cell.setupData(data: sideMenuList[indexPath.row])
        return cell
    }

    func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        let header = MenuHeaderCell(frame: .zero)
        return header
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        menuTapped(index: indexPath.row)
    }
}
