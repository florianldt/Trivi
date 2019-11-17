//
//  HomeViewController.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/13/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit
import RxSwift
import SafariServices

class HomeViewController: UIViewController {

    enum NavigationControllerType {
        case home
        case chat
    }

    let interactor: HomeInteractor
    let disposeBag = DisposeBag()
    var chatViewController: ChatViewController!
    var isVisible = false

    let chatBotCallerButton: ChatBotCallerButton = {
        let button = ChatBotCallerButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor.Names.white.color
        tv.register(VideoFeedLargeSectionCell.self)
        tv.register(VideoFeedDefaultSectionCell.self)
        tv.register(UITableViewCell.self)
        tv.dataSource = self
        tv.rowHeight = UITableView.automaticDimension
        tv.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        tv.separatorStyle = .none
        return tv
    }()

    private var isChatOpen: Bool {
        return chatViewController != nil
    }

    init(interactor: HomeInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .closeChat, object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Names.white.color
        setupNavigationBar()

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        setupChatBotCallerButton()
        addNotificationObservers()

        interactor
            .viewModel
            .subscribe(onNext: { [weak self] _ in
                guard let strongSelf = self else { return }
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
            })
            .disposed(by: disposeBag)

        interactor.loadVideoFeed()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isVisible = true

        if Secrets.hiddenMessageIndex == 0 {
            if chatViewController == nil {
                addChatViewController()
            }
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        isVisible = false
    }

    private func setupNavigationBar() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "nb_trivi"))
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        changeNavigationBarColor(for: .home)
    }

    private func changeNavigationBarColor(for type: NavigationControllerType) {
        var color: UIColor {
            switch type {
            case .home:
                return UIColor.Names.white.color
            case .chat:
                return UIColor.Names.clearBlue.color
            }
        }
        navigationController?.navigationBar.barTintColor = color
    }

    private func setupChatBotCallerButton() {
        view.addSubview(chatBotCallerButton)

        NSLayoutConstraint.activate([
            chatBotCallerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -19),
            chatBotCallerButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -9),
            chatBotCallerButton.heightAnchor.constraint(equalToConstant: 81),
            chatBotCallerButton.widthAnchor.constraint(equalTo: chatBotCallerButton.heightAnchor),
        ])

        chatBotCallerButton.innerButton.addTarget(self, action: #selector(onChatBotCallerButton), for: .touchUpInside)
    }

    @objc
    private func onChatBotCallerButton() {
        addChatViewController()
    }

    private func addChatViewController() {
        let chatInteractor = ChatInteractor(networkingProvider: interactor.networkingProvider)
        chatViewController = ChatViewController(interactor: chatInteractor)
        chatViewController.delegate = self
        chatViewController.modalPresentationStyle = .overCurrentContext
        chatViewController.modalTransitionStyle = .crossDissolve
        self.definesPresentationContext = true
        changeNavigationBarColor(for: .chat)
        present(chatViewController, animated: true)
    }

    private func closeChatViewController() {
        chatViewController.delegate = nil
        changeNavigationBarColor(for: .home)
        chatViewController.dismiss(animated: true)
        chatViewController = nil
    }

    private func addNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(onCloseChatNotification(_:)), name: .closeChat, object: nil)
    }

    @objc
    private func onCloseChatNotification(_ notification: Notification) {
        guard isChatOpen && isVisible else { return }
        closeChatViewController()
    }
}

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.viewModel.value.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let returnCell: UITableViewCell
        let cellViewMdoel = interactor.viewModel.value.cellViewModel(at: indexPath)
        switch cellViewMdoel {
        case .loading:
            let cell = tableView.dequeue(UITableViewCell.self, for: indexPath)
            returnCell = cell
        case .videoLargeSection(let viewModel):
            let cell = tableView.dequeue(VideoFeedLargeSectionCell.self, for: indexPath)
            cell.delegate = self
            cell.configure(with: viewModel)
            returnCell = cell
        case .videoDefaultSection(let viewModel):
            let cell = tableView.dequeue(VideoFeedDefaultSectionCell.self, for: indexPath)
            cell.delegate = self
            cell.configure(with: viewModel)
            returnCell = cell
        case .failure(let viewModel):
            let cell = tableView.dequeue(UITableViewCell.self, for: indexPath)
            returnCell = cell
        }
        return returnCell
    }
}

extension HomeViewController: ChatViewControllerDelegate {
    func isChatVisible(_ visible: Bool) {
        isVisible = visible
    }
}

extension HomeViewController: VideoFeedSectionCellDelegate {

    func didSelectVideo(of id: String) {
        guard let url = URL(string: String(format: "https://www.youtube.com/watch?v=%@", id)) else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
    }
}
