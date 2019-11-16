//
//  LetterDetailAvatarView.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/15/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

class LetterDetailAvatarView: UIView {

    let avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        return iv
    }()

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(avatarImageView)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 260),
            widthAnchor.constraint(equalToConstant: 290),
        ])

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor),
            avatarImageView.leftAnchor.constraint(equalTo: leftAnchor),
            avatarImageView.rightAnchor.constraint(equalTo: rightAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: LetterViewModel) {
        avatarImageView.kf.setImage(with: viewModel.user.avatar)
    }
}
