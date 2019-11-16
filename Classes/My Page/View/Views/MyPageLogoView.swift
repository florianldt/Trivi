//
//  MyPageLogoView.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/15/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

class MyPageLogoView: UIView {

    let appImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "trivi")
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    let appLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Trivi"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = UIColor.Names.darkBlue.color
        return label
    }()

    init() {
        super.init(frame: .zero)
        addSubview(appImageView)
        addSubview(appLabel)

        NSLayoutConstraint.activate([
            appImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            appImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            appImageView.widthAnchor.constraint(equalToConstant: 42),
        ])

        NSLayoutConstraint.activate([
            appLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            appLabel.topAnchor.constraint(equalTo: appImageView.bottomAnchor, constant: -20),
        ])

        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: appLabel.bottomAnchor, constant: 15),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
