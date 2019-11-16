//
//  VideoMessageThumbnailView.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/16/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

class VideoMessageThumbnailView: UIView {

    var viewModel: VideoThumbnailViewModel?

    let thumbnailImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = UIColor.Names.darkBlue.color
        iv.layer.masksToBounds = true
        return iv
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = UIColor.Names.blackBlue.color
        label.numberOfLines = 3
        return label
    }()

    let likesCounter: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = false
        button.setTitle(" 867", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.setTitleColor(UIColor.Names.blackBlue.color, for: .normal)
        button.setImage(UIImage(named: "like"), for: .normal)
        return button
    }()

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.Names.white.color
        layer.cornerRadius = 16
        layer.masksToBounds = true

        addSubview(thumbnailImageView)
        addSubview(titleLabel)
        addSubview(likesCounter)

        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            thumbnailImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            thumbnailImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 153),
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 17),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -13),
        ])

        NSLayoutConstraint.activate([
            likesCounter.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 11),
            likesCounter.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
        ])

        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: likesCounter.bottomAnchor, constant: 14),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: VideoThumbnailViewModel) {
        self.viewModel = viewModel
        thumbnailImageView.kf.setImage(with: viewModel.poster)
        titleLabel.text = viewModel.title
    }
}
