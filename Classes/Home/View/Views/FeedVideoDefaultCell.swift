//
//  FeedVideoDefaultCell.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/14/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

class VideoFeedDefaultCell: UICollectionViewCell {

    var viewModel: FeedVideoViewModel?

    let coverImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = UIColor.Names.darkBlue.color
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 13
        return iv
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = UIColor.Names.blackBlue.color
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = UIColor.Names.white.color
        contentView.addSubview(coverImageView)
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            coverImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            coverImageView.heightAnchor.constraint(equalToConstant: 117),
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 6),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: FeedVideoViewModel) {
        self.viewModel = viewModel
        coverImageView.kf.setImage(with: viewModel.cover)
        titleLabel.text = viewModel.title
    }
}
