//
//  MentorDetailReviewCell.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/15/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

class MentorDetailReviewCell: UITableViewCell {

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = UIColor.Names.blackBlue.color
        return label
    }()

    let ratingImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.masksToBounds = true
        return iv
    }()

    let reviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.font = label.font.italic
        label.textColor = UIColor.Names.blackBlue.color
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = UIColor.Names.white.color

        contentView.addSubview(nameLabel)
        contentView.addSubview(ratingImageView)
        contentView.addSubview(reviewLabel)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
        ])

        NSLayoutConstraint.activate([
            ratingImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            ratingImageView.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 0),
            ratingImageView.widthAnchor.constraint(equalToConstant: 84),
        ])

        NSLayoutConstraint.activate([
            reviewLabel.topAnchor.constraint(equalTo: ratingImageView.bottomAnchor, constant: 5),
            reviewLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 0),
            reviewLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 0),
        ])

        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: reviewLabel.bottomAnchor, constant: 2),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: MentorDetailReviewViewModel) {
        nameLabel.text = viewModel.name
        ratingImageView.image = UIImage(named: viewModel.ratingImageName)
        reviewLabel.text = viewModel.text
    }
}
