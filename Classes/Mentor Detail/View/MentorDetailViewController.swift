//
//  MentorDetailViewController.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/15/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit
import RxSwift

class MentorDetailViewController: UIViewController, UIGestureRecognizerDelegate {

    let interactor: MentorInteractor
    let disposeBag = DisposeBag()

    let navigationitemButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(UIColor.Names.darkBlue.color, for: .normal)
        return button
    }()

    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor.Names.white.color
        tv.dataSource = self
        tv.register(UITableViewCell.self)
        tv.register(MentorDetailAvatarCell.self)
        tv.register(MentorDetailHeadlineCell.self)
        tv.register(MentorDetailReviewLanguagesCell.self)
        tv.register(MentorDetailSeparatorCell.self)
        tv.register(MentorDetailTitleCell.self)
        tv.register(MentorDetailTextCell.self)
        tv.register(MentorDetailBioCell.self)
        tv.register(MentorDetailReviewCell.self)
        tv.register(MentorDetailListCell.self)
        tv.separatorStyle = .none
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0)
        return tv
    }()

    let actionStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 11
        sv.distribution = .fillEqually
        return sv
    }()

    let chatButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.Names.white.color
        button.layer.cornerRadius = 72/2
        button.setImage(UIImage(named: "button_chat"), for: .normal)
        button.layer.masksToBounds = false
        return button
    }()

    let phoneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.Names.white.color
        button.layer.cornerRadius = 72/2
        button.setImage(UIImage(named: "button_phone"), for: .normal)
        button.layer.masksToBounds = false
        return button
    }()

    init(interactor: MentorInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Names.white.color

        view.addSubview(tableView)
        view.addSubview(actionStackView)
        actionStackView.addArrangedSubview(chatButton)
        actionStackView.addArrangedSubview(phoneButton)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        NSLayoutConstraint.activate([
            actionStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            actionStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            actionStackView.heightAnchor.constraint(equalToConstant: 72),
            actionStackView.widthAnchor.constraint(equalToConstant: 72*2+11)
        ])

        interactor
            .viewModel
            .subscribe(onNext: { [weak self] viewModel in
                guard let strongSelf = self else { return }
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                    strongSelf.configureNavigationTitle(with: viewModel)
                }
            })
            .disposed(by: disposeBag)

        interactor.loadMentor()
        addButtonShadow(chatButton)
        addButtonShadow(phoneButton)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationController()
    }

    private func setupNavigationController() {
        navigationController?.navigationBar.barTintColor = UIColor.Names.white.color
        navigationController?.navigationBar.tintColor = UIColor.Names.darkBlue.color
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(onLeftBarButtonItem))
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationItem.titleView = navigationitemButton
    }

    @objc
    private func onLeftBarButtonItem() {
        navigationController?.popViewController(animated: true)
    }

    private func addButtonShadow(_ button: UIView) {
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowRadius = 12
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
    }

    private func configureNavigationTitle(with viewModel: MentorDetailViewModel) {
        navigationitemButton.setImage(viewModel.isVerified ? UIImage(named: "detail_bookmark") : nil, for: .normal)
        navigationitemButton.setTitle(viewModel.isVerified ? String(format: " %@", viewModel.name) : viewModel.name, for: .normal)
    }
}

extension MentorDetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.viewModel.value.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let returnCell: UITableViewCell
        let cellViewModel = interactor.viewModel.value.cellViewModel(at: indexPath)
        switch cellViewModel {
        case .avatar(let url):
            let cell = tableView.dequeue(MentorDetailAvatarCell.self, for: indexPath)
            cell.configure(with: url)
            returnCell = cell
        case .headline(let headline):
            let cell = tableView.dequeue(MentorDetailHeadlineCell.self, for: indexPath)
            cell.configure(with: headline)
            returnCell = cell
        case .list(let elements):
            let cell = tableView.dequeue(MentorDetailListCell.self, for: indexPath)
            cell.elements = elements
            returnCell = cell
        case .ratingLanguages(let viewModel):
            let cell = tableView.dequeue(MentorDetailReviewLanguagesCell.self, for: indexPath)
            cell.configure(with: viewModel)
            returnCell = cell
        case .separator:
            let cell = tableView.dequeue(MentorDetailSeparatorCell.self, for: indexPath)
            returnCell = cell
        case .title(let title):
            let cell = tableView.dequeue(MentorDetailTitleCell.self, for: indexPath)
            cell.configure(with: title)
            returnCell = cell
        case .text(let text):
            let cell = tableView.dequeue(MentorDetailTextCell.self, for: indexPath)
            cell.configure(with: text)
            returnCell = cell
        case .bio(let bio):
            let cell = tableView.dequeue(MentorDetailBioCell.self, for: indexPath)
            cell.configure(with: bio)
            returnCell = cell
        case .review(let viewModel):
            let cell = tableView.dequeue(MentorDetailReviewCell.self, for: indexPath)
            cell.configure(with: viewModel)
            returnCell = cell
        default:
            let cell = tableView.dequeue(UITableViewCell.self, for: indexPath)
            cell.contentView.backgroundColor = .blue
            returnCell = cell
        }
        return returnCell
    }
}
