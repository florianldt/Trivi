//
//  LetterDetailHeadlineView.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/15/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

class LetterDetailHeadlineView: UIView {

    let headlineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.font = label.font.italic
        label.textColor = UIColor.Names.blackBlue.color
        label.numberOfLines = 0
        return label
    }()

    init() {
        super.init(frame: .zero)

        addSubview(headlineLabel)

        NSLayoutConstraint.activate([
            headlineLabel.topAnchor.constraint(equalTo: topAnchor, constant: 9),
            headlineLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 31),
            headlineLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -22),
        ])

        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 0),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: LetterViewModel) {
        headlineLabel.text = viewModel.user.headline
    }
}

