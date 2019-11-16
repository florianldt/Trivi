//
//  ChatViewController.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/14/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit
import RxSwift
import SafariServices

protocol ChatViewControllerDelegate: class {
    func isChatVisible(_ visible: Bool)
}

class ChatViewController: UIViewController {

    let interactor: ChatInteractor
    let disposeBag = DisposeBag()

    weak var delegate: ChatViewControllerDelegate?
    var simpleChoiceViewController: BotChoiceSimpleViewController!

    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(TextMessageCell.self)
        tv.register(VideoMessageCell.self)
        tv.register(LoadingTVCell.self)
        tv.register(ErrorTVCell.self)
        tv.backgroundColor = UIColor.Names.clearBlue.color
        tv.dataSource = self
        tv.delegate = self
        tv.separatorStyle = .none
        tv.contentInset.top = 18
        return tv
    }()

    init(interactor: ChatInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        self.interactor.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("ChatViewController deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Names.clearBlue.color
        setupNavigationBar()

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])

        interactor
            .viewModel
            .subscribe(onNext: { [weak self] _ in
                guard let strongSelf = self else { return }
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
            })
            .disposed(by: disposeBag)

        interactor.createConversation()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.isChatVisible(true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.isChatVisible(false)
    }

    private func setupNavigationBar() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "nb_trivi"))
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor.Names.clearBlue.color
    }

    private func showSimplePromptViewController(with prompts: [QNAResponse.Prompt]) {
        simpleChoiceViewController = BotChoiceSimpleViewController(prompts: prompts)
        simpleChoiceViewController.delegate = self
        simpleChoiceViewController.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(simpleChoiceViewController)
        view.addSubview(simpleChoiceViewController.view)
        NSLayoutConstraint.activate([
            simpleChoiceViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            simpleChoiceViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            simpleChoiceViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            simpleChoiceViewController.view.heightAnchor.constraint(equalToConstant: CGFloat(prompts.count) * 50 + 60),
        ])
        simpleChoiceViewController.didMove(toParent: self)
    }

    private func removeSimplePromptViewController() {
        simpleChoiceViewController.willMove(toParent: self)
        simpleChoiceViewController.view.removeFromSuperview()
        simpleChoiceViewController.removeFromParent()
        simpleChoiceViewController.didMove(toParent: self)
        simpleChoiceViewController = nil
    }
}

extension ChatViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.viewModel.value.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let returnCell: UITableViewCell
        let cellViewModel = interactor.viewModel.value.viewModel(at: indexPath)
        switch cellViewModel {
        case .loading:
            let cell = tableView.dequeue(LoadingTVCell.self, for: indexPath)
            cell.activityIndicator.startAnimating()
            cell.contentView.backgroundColor = UIColor.Names.clearBlue.color
            returnCell = cell
        case .text(let viewModel):
            let cell = tableView.dequeue(TextMessageCell.self, for: indexPath)
            cell.configure(with: viewModel)
            returnCell = cell
        case .video(let viewModel):
            let cell = tableView.dequeue(VideoMessageCell.self, for: indexPath)
            cell.configure(with: viewModel)
            cell.delegate = self
            returnCell = cell
        case .failure(let viewModel):
            let cell = tableView.dequeue(ErrorTVCell.self, for: indexPath)
            cell.configure(with: viewModel)
            returnCell = cell
        }
        return returnCell
    }
}

extension ChatViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let returnHeight: CGFloat
        let cellViewModel = interactor.viewModel.value.viewModel(at: indexPath)
        switch cellViewModel {
        case .loading:
            returnHeight = 60.0
        case .text, .video:
            returnHeight = UITableView.automaticDimension
        case .failure:
            returnHeight = 60.0
        }
        return returnHeight
    }
}

extension ChatViewController: VideoMessageCellDelegate {

    func didTapVideo(of id: String) {
        guard let url = URL(string: String(format: "https://www.youtube.com/watch?v=%@", id)) else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
    }
}

extension ChatViewController: ChatInteractorDelegate {

    func showPrompts(_ prompts: [QNAResponse.Prompt]) {
        DispatchQueue.main.async {
            self.showSimplePromptViewController(with: prompts)
        }
    }
}

extension ChatViewController: BotChoiceSimpleViewControllerDelegate {

    func didSelect(_ prompts: QNAResponse.Prompt) {
        DispatchQueue.main.async {
            self.removeSimplePromptViewController()
        }
        interactor.sendMessage(with: prompts.displayText)
    }
}
