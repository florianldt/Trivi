//
//  MyPageBasicItemView.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/15/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

class MyPageBasicItemView: UIView {

    let itemIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let itemLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = UIColor.Names.blackBlue.color
        return label
    }()

    let badgeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.Names.darkBlue.color
        view.layer.cornerRadius = 18/2
        return view
    }()

    let badgeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()

    let disclosureImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "disclosure")
        return iv
    }()

    var itemIconImageViewLeftConstraint: NSLayoutConstraint!

    init() {
        super.init(frame: .zero)
        addSubview(itemIconImageView)
        addSubview(itemLabel)
        addSubview(badgeView)
        addSubview(badgeLabel)
        addSubview(disclosureImageView)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 56),
        ])

        itemIconImageViewLeftConstraint = itemIconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 30)
        NSLayoutConstraint.activate([
            itemIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            itemIconImageViewLeftConstraint,
        ])

        NSLayoutConstraint.activate([
            itemLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 62),
            itemLabel.heightAnchor.constraint(equalToConstant: 20),
            itemLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            itemLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -100),
        ])

        NSLayoutConstraint.activate([
            disclosureImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -23),
            disclosureImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(imageName: String, text: String, iconLeftInset: CGFloat) {
        itemIconImageView.image = UIImage(named: imageName)
        itemLabel.text = text
        itemIconImageViewLeftConstraint.constant = iconLeftInset
    }

}
