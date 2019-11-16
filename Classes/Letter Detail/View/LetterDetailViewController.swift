//
//  LetterDetailViewController.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/15/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit
import AloeStackView

class LetterDetailViewController: UIViewController {

    let interactor: LetterDetailInteractor

    let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.41)
        return view
    }()

    let aloeStackView: AloeStackView = {
        let sv = AloeStackView()
        sv.layer.cornerRadius = 15
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.layer.masksToBounds = true
        sv.separatorHeight = 0
        sv.rowInset = .zero
        return sv
    }()

    var aloeStackHeightContraint: NSLayoutConstraint!

    init(interactor: LetterDetailInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        view.addSubview(backgroundView)
        view.addSubview(aloeStackView)

        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        aloeStackHeightContraint = aloeStackView.heightAnchor.constraint(equalToConstant: 442)
        NSLayoutConstraint.activate([
            aloeStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            aloeStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            aloeStackView.widthAnchor.constraint(equalToConstant: 290),
            aloeStackHeightContraint,
        ])

        addBackgroundGesture()
        setupAloeStackView()
    }

    private func addBackgroundGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onBackgroundView))
        backgroundView.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc
    private func onBackgroundView() {
        dismiss(animated: true)
    }

    private func setupAloeStackView() {
        setupAvatarView()
        setupIdentityView()
        setupHeadlineView()
        setupInformationView()

        let headlineHeight: CGFloat = interactor.viewModel.user.headline.height(withConstrainedWidth: 290 - 31 - 22, font: UIFont.systemFont(ofSize: 17, weight: .medium))
        aloeStackHeightContraint.constant = 384 + headlineHeight
    }

    private func setupAvatarView() {
        let view = LetterDetailAvatarView()
        view.configure(with: interactor.viewModel)
        aloeStackView.addRow(view)
    }

    private func setupIdentityView() {
        let view = LetterDetailIdentityView()
        view.configure(with: interactor.viewModel)
        aloeStackView.addRow(view)
    }

    private func setupHeadlineView() {
        let view = LetterDetailHeadlineView()
        view.configure(with: interactor.viewModel)
        aloeStackView.addRow(view)
    }

    private func setupInformationView() {
        let view = LetterDetailInformationView()
        view.configure(with: interactor.viewModel)
        aloeStackView.addRow(view)
    }
}
