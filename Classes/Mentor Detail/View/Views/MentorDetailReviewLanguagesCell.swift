//
//  MentorDetailReviewLanguagesCell.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/15/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

class MentorDetailReviewLanguagesCell: UITableViewCell {

    let ratingImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.masksToBounds = true
        return iv
    }()

    let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor.Names.blackBlue.color
        label.numberOfLines = 1
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = UIColor.Names.white.color
        contentView.addSubview(ratingImageView)
        contentView.addSubview(ratingLabel)

        NSLayoutConstraint.activate([
            ratingImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            ratingImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            ratingImageView.widthAnchor.constraint(equalToConstant: 84),
        ])

        NSLayoutConstraint.activate([
            ratingLabel.centerYAnchor.constraint(equalTo: ratingImageView.centerYAnchor, constant: 0),
            ratingLabel.leftAnchor.constraint(equalTo: ratingImageView.rightAnchor, constant: 7),
        ])

        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: ratingImageView.bottomAnchor, constant: 0),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: MentorDetailRatingLanguagesViewModel) {
        ratingImageView.image = UIImage(named: viewModel.ratingImageName)
        ratingLabel.text = viewModel.reviewText
    }
}
