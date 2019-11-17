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
        label.textColor = UIColor.Names.myPageBlue.color
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 0
        label.text = "Mia"
        return label
    }()

    let lvlImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "lvl")
        return iv
    }()

    let pointsImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "points")
        return iv
    }()

    init() {
        super.init(frame: .zero)
        addSubview(nameLabel)
        addSubview(lvlImageView)
        addSubview(pointsImageView)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 21),
            nameLabel.heightAnchor.constraint(equalToConstant: 36),
        ])

        NSLayoutConstraint.activate([
            lvlImageView.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 8),
            lvlImageView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 4),
        ])

        NSLayoutConstraint.activate([
            pointsImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -21),
            pointsImageView.centerYAnchor.constraint(equalTo: lvlImageView.centerYAnchor, constant: 0),
        ])

        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
