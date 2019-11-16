//
//  MyPageNameView.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/15/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

class MyPageNameView: UIView {

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.Names.darkBlue.color
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 0
        label.text = "Mia"
        return label
    }()

    init() {
        super.init(frame: .zero)
        addSubview(nameLabel)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 21),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -21),
            nameLabel.heightAnchor.constraint(equalToConstant: 36),
        ])

        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
