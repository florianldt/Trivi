//
//  MentorCell.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/13/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit
import Kingfisher

class MentorCell: UICollectionViewCell {

    var viewModel: MentorViewModel?

    let content: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.Names.white.color
        view.layer.cornerRadius = 13.0
        return view
    }()

    let avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 13
        iv.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return iv
    }()

    let identityButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.contentHorizontalAlignment = .left
        button.setImage(UIImage(named: "bookmark"), for: .normal)
        button.setTitleColor(UIColor.Names.darkBlue.color, for: .normal)
        return button
    }()

    let languagesStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 5
        sv.distribution = .fillEqually
        return sv
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor.Names.textGray.color
        label.numberOfLines = 0
        return label
    }()

    let ratingImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = UIColor.Names.clearBlue.color

        contentView.addSubview(content)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(identityButton)
        contentView.addSubview(languagesStackView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(ratingImageView)

        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: contentView.topAnchor),
            content.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            content.leftAnchor.constraint(equalTo: contentView.leftAnchor),
        ])

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: content.topAnchor),
            avatarImageView.rightAnchor.constraint(equalTo: content.rightAnchor),
            avatarImageView.leftAnchor.constraint(equalTo: content.leftAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 174),
        ])

        NSLayoutConstraint.activate([
            identityButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 6),
            identityButton.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 11),
            identityButton.rightAnchor.constraint(equalTo: content.rightAnchor, constant: -11),
            identityButton.heightAnchor.constraint(equalToConstant: 18),
        ])

        NSLayoutConstraint.activate([
            languagesStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            languagesStackView.centerYAnchor.constraint(equalTo: identityButton.centerYAnchor, constant: 0),
            languagesStackView.heightAnchor.constraint(equalToConstant: 11),
        ])

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: identityButton.bottomAnchor, constant: 7),
            descriptionLabel.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 10),
            descriptionLabel.rightAnchor.constraint(equalTo: content.rightAnchor, constant: -4),
        ])

        NSLayoutConstraint.activate([
            ratingImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 13),
            ratingImageView.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 12),
            ratingImageView.widthAnchor.constraint(equalToConstant: 84),
        ])


    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: MentorViewModel) {
        self.viewModel = viewModel
        avatarImageView.kf.setImage(with: viewModel.avatar)
        identityButton.setTitle(String(format: " %@", viewModel.name), for: .normal)
        descriptionLabel.text = viewModel.description
        ratingImageView.image = UIImage(named: viewModel.ratingImageName)
        setupLanguageStackView(with: viewModel.languages)
    }

    private func setupLanguageStackView(with languages: [String]) {
        languagesStackView.removeAllArrangedSubviews()
        for language in languages {
            let countryImageView = UIImageView(image: UIImage(named: language.uppercased()))
            countryImageView.contentMode = .scaleAspectFit
            countryImageView.translatesAutoresizingMaskIntoConstraints = false
            countryImageView.heightAnchor.constraint(equalToConstant: 11).isActive = true
            countryImageView.widthAnchor.constraint(equalToConstant: 11).isActive = true
            languagesStackView.addArrangedSubview(countryImageView)
        }
    }
}
