//
//  MentorDetailAvatarCell.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/15/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

class MentorDetailAvatarCell: UITableViewCell {

    let avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 16
        return iv
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = UIColor.Names.white.color

        contentView.addSubview(avatarImageView)

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            avatarImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
            avatarImageView.widthAnchor.constraint(equalToConstant: 365),
            avatarImageView.heightAnchor.constraint(equalToConstant: 365),
        ])

        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 0),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with url: URL?) {
        avatarImageView.kf.setImage(with: url)
    }
}
