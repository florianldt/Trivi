//
//  MentorsViewController.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/13/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit
import RxSwift

class MentorsViewController: UIViewController {

    let interactor: MentorsInteractor
    let disposeBag = DisposeBag()

    lazy var collectionView: UICollectionView = {
        let layout = WaterfallLayout()
        layout.delegate = self
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.Names.clearBlue.color
        cv.register(UICollectionViewCell.self)
        cv.register(MentorCell.self)
        cv.dataSource = self
        cv.delegate = self
        cv.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        return cv
    }()

    init(interactor: MentorsInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Names.clearBlue.color
        setupNavigationBar()

        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        interactor
            .viewModel
            .subscribe(onNext: { [weak self] _ in
                guard let strongSelf = self else { return }
                DispatchQueue.main.async {
                    strongSelf.collectionView.reloadData()
                }
            })
            .disposed(by: disposeBag)

        interactor.loadMentors()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor.Names.clearBlue.color
    }

    private func setupNavigationBar() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "nb_trivi"))
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}

extension MentorsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor.viewModel.value.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let returnCell: UICollectionViewCell
        let cellViewModel = interactor.viewModel.value.cellViewModel(at: indexPath)
        switch cellViewModel {
        case .loading:
            let cell = collectionView.dequeue(UICollectionViewCell.self, for: indexPath)
            returnCell = cell
        case .mentor(let viewModel):
            let cell = collectionView.dequeue(MentorCell.self, for: indexPath)
            cell.configure(with: viewModel)
            returnCell = cell
        case .failure(let viewModel):
            let cell = collectionView.dequeue(UICollectionViewCell.self, for: indexPath)
            returnCell = cell
        }
        return returnCell
    }
}

extension MentorsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mentorDetailInteractor = MentorInteractor(networkingProvider: interactor.networkingProvider)
        let mentorDetailViewController = MentorDetailViewController(interactor: mentorDetailInteractor)
        mentorDetailViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(mentorDetailViewController, animated: true)
    }
}

extension MentorsViewController: WaterfallLayoutDelegate {

    func collectionViewLayout(for section: Int) -> WaterfallLayout.Layout {
        return .waterfall
    }

    func collectionView(_ collectionView: UICollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return interactor.viewModel.value.sizeForItem(at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, minimumInterItemSpacingFor section: Int) -> CGFloat? {
        return 20.0
    }

    func collectionView(_ collectionView: UICollectionView, minimumLineSpacingFor section: Int) -> CGFloat? {
        return 12.0
    }

    func collectionView(_ collectionView: UICollectionView, sectionInsetFor section: Int) -> UIEdgeInsets? {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }

    func collectionView(_ collectionView: UICollectionView, headerHeightFor section: Int) -> CGFloat? {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, headerInsetFor section: Int) -> UIEdgeInsets? {
        return .zero

    }

    func collectionView(_ collectionView: UICollectionView, footerHeightFor section: Int) -> CGFloat? {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, footerInsetFor section: Int) -> UIEdgeInsets? {
        return .zero
    }
}
