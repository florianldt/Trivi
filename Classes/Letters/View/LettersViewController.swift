//
//  LettersViewController.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/13/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit
import RxSwift

class LettersViewController: UIViewController {

    let interactor: LettersInteractor
    let disposeBag = DisposeBag()

    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.rowHeight = UITableView.automaticDimension
        tv.register(LoadingTVCell.self)
        tv.register(LetterCell.self)
        tv.register(ErrorTVCell.self)
        tv.separatorStyle = .none
        return tv
    }()

    init(interactor: LettersInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

        interactor
            .viewModel
            .subscribe(onNext: { [weak self] _ in
                guard let strongSelf = self else { return }
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
            })
            .disposed(by: disposeBag)

        interactor.loadLetters()
    }

    private func setupNavigationBar() {
        navigationItem.title = ""
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor.Names.white.color
    }

    private func showLetterDetail(for viewModel: LetterViewModel) {
        let letterDetailInteractor = LetterDetailInteractor(viewModel: viewModel)
        let letterDetailViewController = LetterDetailViewController(interactor: letterDetailInteractor)
        letterDetailViewController.modalPresentationStyle = .overFullScreen
        letterDetailViewController.modalTransitionStyle = .crossDissolve
        present(letterDetailViewController, animated: true)
    }
}

extension LettersViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.viewModel.value.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let returnCell: UITableViewCell
        let cellViewModel = interactor.viewModel.value.cellViewModel(at: indexPath)
        switch cellViewModel {
        case .loading:
            let cell = tableView.dequeue(LoadingTVCell.self, for: indexPath)
            cell.activityIndicator.startAnimating()
            returnCell = cell
        case .letter(let viewModel):
            let cell = tableView.dequeue(LetterCell.self, for: indexPath)
            cell.configure(with: viewModel)
            returnCell = cell
        case .failure(let viewModel):
            let cell = tableView.dequeue(ErrorTVCell.self, for: indexPath)
            cell.configure(with: viewModel)
            returnCell = cell
        }
        return returnCell
    }
}

extension LettersViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let cell = tableView.cellForRow(at: indexPath) as? LetterCell,
            let viewModel = cell.viewModel
            else { return }
        showLetterDetail(for: viewModel)
    }
}
