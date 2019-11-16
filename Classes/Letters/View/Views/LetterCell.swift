//
//  LetterCell.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/15/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

class LetterCell: UITableViewCell {

    var viewModel: LetterViewModel?

    let avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 45 / 2
        iv.layer.masksToBounds = true
        return iv
    }()

    let onlineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.Names.onlineGreen.color
        view.layer.cornerRadius = 8/2
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.Names.onlineGreen.color.cgColor
        return view
    }()

    let identityButton: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .left
        button.setTitleColor(UIColor.Names.darkBlue.color, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return button
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = UIColor.Names.blackBlue.color
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.font = label.font.boldItalic
        return label
    }()

    let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.font = label.font.italic
        label.textColor = UIColor.Names.blackBlue.color
        return label
    }()

    let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textColor = UIColor.Names.textGray.color
        return label
    }()

    let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.Names.separator.color
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        contentView.backgroundColor = UIColor.Names.white.color

        contentView.addSubview(avatarImageView)
        contentView.addSubview(onlineView)
        contentView.addSubview(identityButton)
        contentView.addSubview(timeLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(messageLabel)
        contentView.addSubview(separatorView)

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            avatarImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25),
            avatarImageView.widthAnchor.constraint(equalToConstant: 45),
            avatarImageView.heightAnchor.constraint(equalToConstant: 45),
        ])

        NSLayoutConstraint.activate([
            onlineView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            onlineView.leftAnchor.constraint(equalTo: avatarImageView.leftAnchor, constant: 5),
            onlineView.widthAnchor.constraint(equalToConstant: 8),
            onlineView.heightAnchor.constraint(equalToConstant: 8),
        ])

        NSLayoutConstraint.activate([
            identityButton.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 5),
            identityButton.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 14),
            identityButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),
            identityButton.heightAnchor.constraint(equalToConstant: 20),
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: identityButton.bottomAnchor, constant: 4),
            titleLabel.leftAnchor.constraint(equalTo: identityButton.leftAnchor, constant: 0),
            titleLabel.rightAnchor.constraint(equalTo: identityButton.rightAnchor, constant: 0),
        ])

        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            messageLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            messageLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
        ])

        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 10),
            timeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -22),
        ])

        NSLayoutConstraint.activate([
            separatorView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 25),
            separatorView.leftAnchor.constraint(equalTo: messageLabel.leftAnchor),
            separatorView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5),
        ])

        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 23),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: LetterViewModel) {
        self.viewModel = viewModel
        avatarImageView.kf.setImage(with: viewModel.user.avatar)
        onlineView.isHidden = !viewModel.user.isOnline
        identityButton.setImage(viewModel.user.isVerified ? UIImage(named: "bookmark") : nil, for: .normal)
        identityButton.setTitle(viewModel.user.isVerified ? String(format: " %@", viewModel.user.name) : viewModel.user.name, for: .normal)
        timeLabel.text = viewModel.sentAt
        titleLabel.text = viewModel.title
        messageLabel.text = viewModel.message
    }
}
