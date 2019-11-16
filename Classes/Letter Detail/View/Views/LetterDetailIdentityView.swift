//
//  LetterDetailIdentityView.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/15/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

class LetterDetailIdentityView: UIView {

    let onlineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.Names.onlineGreen.color
        view.layer.cornerRadius = 8/2
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.Names.onlineGreen.color.cgColor
        return view
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor.Names.darkBlue.color
        return label
    }()

    var nameLabelLeftConstraint: NSLayoutConstraint!

    init() {
        super.init(frame: .zero)

        addSubview(onlineView)
        addSubview(nameLabel)

        NSLayoutConstraint.activate([
            onlineView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            onlineView.leftAnchor.constraint(equalTo: leftAnchor, constant: 31),
            onlineView.heightAnchor.constraint(equalToConstant: 8),
            onlineView.widthAnchor.constraint(equalTo: onlineView.heightAnchor),
        ])

        nameLabelLeftConstraint = nameLabel.leftAnchor.constraint(equalTo: onlineView.rightAnchor, constant: 6)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            nameLabelLeftConstraint,
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -31),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
        ])

        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: LetterViewModel) {
        onlineView.isHidden = !viewModel.user.isOnline
        nameLabel.text = viewModel.user.name
        nameLabelLeftConstraint.constant = viewModel.user.isOnline ? 6 : -8
    }
}
