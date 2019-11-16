//
//  LetterDetailInformationView.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/15/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

class LetterDetailInformationView: UIView {

    let ratingImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    let phoneButton: UIButton = {
        let button = UIButton()
        button.adjustsImageWhenHighlighted = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "action_phone"), for: .normal)
        return button
    }()

    let chatButton: UIButton = {
        let button = UIButton()
        button.adjustsImageWhenHighlighted = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "action_chat"), for: .normal)
        return button
    }()

    init() {
        super.init(frame: .zero)

        addSubview(ratingImageView)
        addSubview(phoneButton)
        addSubview(chatButton)

        NSLayoutConstraint.activate([
            ratingImageView.topAnchor.constraint(equalTo: topAnchor, constant: 36),
            ratingImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 33),
            ratingImageView.widthAnchor.constraint(equalToConstant: 78),
        ])

        NSLayoutConstraint.activate([
            phoneButton.topAnchor.constraint(equalTo: topAnchor, constant: 31),
            phoneButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -19),
            phoneButton.widthAnchor.constraint(equalToConstant: 23),
            phoneButton.heightAnchor.constraint(equalToConstant: 23),
        ])

        NSLayoutConstraint.activate([
            chatButton.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            chatButton.rightAnchor.constraint(equalTo: phoneButton.leftAnchor, constant: -19),
            chatButton.widthAnchor.constraint(equalToConstant: 50),
            chatButton.heightAnchor.constraint(equalToConstant: 38),
        ])

        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: chatButton.bottomAnchor, constant: 27),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: LetterViewModel) {
        ratingImageView.image = UIImage(named: viewModel.user.ratingImageName)
    }
}
