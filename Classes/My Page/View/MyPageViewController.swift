//
//  MyPageViewController.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/13/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit
import AloeStackView

class MyPageViewController: AloeStackViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Names.white.color
        setupAloeStackView()
    }

    private func setupAloeStackView() {
        stackView.rowInset = .zero
        stackView.separatorInset.left = 24
        stackView.separatorHeight = 0.5
        setupNameView()
        setupMessagesView()
        setupSessionView()
        setupBookmarkView()
        setupHistoryView()
        setupHelpView()
        setupNotificationView()
        setupNewLetterNotificationView()
        setupSessionNotificationView()
        setupRecommendNotificationView()
        setupLogoutView()
        setupDeleteView()
        setupLogoView()
    }

    private func setupNameView() {
        let view = MyPageNameView()
        stackView.addRow(view)
        stackView.hideSeparator(forRow: view)
        stackView.setInset(forRow: view, inset: UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0))
    }

    private func setupMessagesView() {
        let view = MyPageBasicItemView()
        view.configure(imageName: "mypage_message", text: "Messages", iconLeftInset: 30, badgeNumber: 1)
        stackView.addRow(view)
    }

    private func setupSessionView() {
        let view = MyPageBasicItemView()
        view.configure(imageName: "mypage_session", text: "Session", iconLeftInset: 31, badgeNumber: 5)
        stackView.addRow(view)
    }

    private func setupBookmarkView() {
        let view = MyPageBasicItemView()
        view.configure(imageName: "mypage_bookmark", text: "Bookmark", iconLeftInset: 33)
        stackView.addRow(view)
    }

    private func setupHistoryView() {
        let view = MyPageBasicItemView()
        view.configure(imageName: "mypage_history", text: "History", iconLeftInset: 31)
        stackView.addRow(view)
    }

    private func setupHelpView() {
        let view = MyPageBasicItemView()
        view.configure(imageName: "mypage_help", text: "Help", iconLeftInset: 30)
        stackView.addRow(view)
    }

    private func setupLogoutView() {
        let view = MyPageBasicItemView()
        view.configure(imageName: "mypage_logout", text: "Logout", iconLeftInset: 31)
        stackView.addRow(view)
    }

    private func setupDeleteView() {
        let view = MyPageBasicItemView()
        view.configure(imageName: "mypage_delete", text: "Delete Account", iconLeftInset: 34)
        stackView.addRow(view)
    }

    private func setupNotificationView() {
        let view = MyPageBasicItemView()
        view.configure(imageName: "mypage_notification", text: "Notification", iconLeftInset: 32)
        view.disclosureImageView.isHidden = true
        stackView.addRow(view)
        stackView.hideSeparator(forRow: view)
        stackView.setInset(forRow: view, inset: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
    }

    private func setupNewLetterNotificationView() {
        let view = MyPageSwitchItemView()
        view.configure(text: "New letter", isOn: true)
        stackView.addRow(view)
    }

    private func setupSessionNotificationView() {
        let view = MyPageSwitchItemView()
        view.configure(text: "Session", isOn: false)
        stackView.addRow(view)
    }

    private func setupRecommendNotificationView() {
        let view = MyPageSwitchItemView()
        view.configure(text: "Recommend", isOn: true)
        stackView.addRow(view)
        stackView.hideSeparator(forRow: view)
        stackView.setInset(forRow: view, inset: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }

    private func setupLogoView() {
        let view = MyPageLogoView()
        stackView.addRow(view)
        stackView.hideSeparator(forRow: view)
    }
}
